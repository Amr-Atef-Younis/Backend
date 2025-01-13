import _ from 'lodash';
import logger from '../../../config/logger.js';
import { processError } from '../../../common/classes/errorHandler/processError.js';

const orderKeysPriority = [
  'trackingNumber',
  'internationalTrackingNumber',
  'receiver.phone',
  'sender._id',
  'state.receivedAtWarehouse.warehouse._id',
  'assignedHub._id',
  'state.code',
  'type',
  'star._id' // will move it upwards once an index is created
];

export default class QueryOptimiserService {
  /**
   * This method is responsible for optimizing the filters used in elasticsearch when searching for deliveries.
   * It takes the oldQuery as an argument and returns an optimized version of the filters.
   * The optimization process involves:
   *  1. Removing the 'in' keyword when there is only one value in the array.
   *  2. Combining the '$or' filters for certain keys.
   *  3. Combining the '$and' filters for certain keys.
   *  4. Removing the '$and' keyword when there is only one filter left.
   * @param {array} oldQuery - The filters to be optimized.
   * @returns {array} The optimized filters.
   */
  static optimiseDeliverySearch(oldQuery) {
    try {
      // Clone the oldQuery so that we don't modify the original query.
      let newQuery = _.cloneDeep(oldQuery);

      // Remove the 'in' keyword when there is only one value in the array.
      newQuery = this.removeInKeywordForOneElementSearch(newQuery);

      // The keys that we want to combine the '$or' filters for.
      const keysArray = [
        'state.waitingForBusinessAction',
        'state.childState',
        'state.code'
      ];

      // If the filters have an '$and' key, then we need to optimize the filters inside it.
      if (newQuery['$and']) {
        // Combine the '$or' filters for the keys specified in the keysArray.

        newQuery['$and'] = this._findAndCombineOrFilters(
          newQuery['$and'],
          keysArray
        );

        // Combine similar In filters inside '$and' array.
        newQuery['$and'] = this._findAndCombineInFilters(newQuery['$and']);

        // Remove the '$or' keyword when it only has a single filter inside the array.
        newQuery['$and'] = this.removeOrKeywordForOneElementSearch(
          newQuery['$and']
        );

        newQuery = {
          ...Object.assign({}, ...newQuery['$and']),
          ..._.omit(newQuery, '$and')
        };
      }

      // sort the keys inside the selector to guide specific index usage
      newQuery = this._orderSelector(newQuery);

      // Store the old and new queries in an object for logging purposes.
      const queryOptimiser = {
        oldQuery,
        newQuery
      };

      logger.info(
        `[DeliverySearch][QueryOptimiser] ${JSON.stringify(queryOptimiser)}`
      );

      return newQuery;
    } catch (error) {
      processError(
        { error, suppress: true },
        'QueryOptimiserService',
        'optimiseDeliverySearch'
      );
      return oldQuery;
    }
  }

  /**
   * This method is designed to remove the '$or' keyword from the filters when
   * the array has only one element. It is used to optimize the filters used
   * in Elasticsearch when searching for deliveries.
   *
   * @param {object} filters - The filters to be optimized.
   * @returns {object} The optimized filters.
   */
  static removeOrKeywordForOneElementSearch(filters) {
    // Go through each filter in the filters array
    filters.forEach((filter, index) => {
      // Get the $or clause from the current filter
      const orClause = _.get(filter, '$or', []);

      // If the filter has an $or clause
      if (!_.isEmpty(orClause)) {
        // If the $or clause has only one element
        if (orClause.length < 2) {
          // Create a new object with the properties of the current filter
          // and the properties of the first element in the $or clause
          const newResults = {
            ..._.omit(filter, '$or'),
            ...orClause[0]
          };

          // If the new object is the same as the current filter, recursively call
          // this function with the $or clause as the new filters array
          if (JSON.stringify(newResults) === JSON.stringify(filter)) {
            filters[index] = this.removeOrKeywordForOneElementSearch(orClause);
          } else {
            // Otherwise, replace the current filter in the filters array with the new object
            filters[index] = newResults;
            // And recursively call this function with the new filters array
            filters = this.removeOrKeywordForOneElementSearch(filters);
          }
        } else {
          // If the $or clause has more than one element, replace the $or clause
          // with the result of calling this function with the $or clause as the new filters array
          filter['$or'] = this.removeOrKeywordForOneElementSearch(orClause);
          // And replace the current filter in the filters array with the new object
          filters[index] = filter;
        }
      }
    });
    // Return the optimized filters array
    return filters;
  }

  /**
   * This method is designed to remove the '$in' keyword from the filters when
   * the array has only one element. It is used to optimize the filters used
   * in Elasticsearch when searching for deliveries.
   *
   * @param {object} filters - The filters to be optimized.
   * @returns {object} The optimized filters.
   */
  static removeInKeywordForOneElementSearch(filters) {
    /**
     * Iterate over the keys of the filters object.
     */
    Object.keys(filters).forEach(key => {
      /**
       * If the key is '$in', then check if the length of the array is less
       * than 2. If it is, then assign the first element of the array to the
       * current key and return the object.
       */
      if (key === '$in') {
        if (filters[key].length < 2) {
          filters = filters[key][0] || '';
          return;
        }
      }

      /**
       * If the value of the current key is an object and not an array (i.e.
       * it is a nested filter), or if the key is '$and' or '$or', then
       * recursively call this method to remove the '$in' keyword from the
       * nested filter.
       */
      if (
        (filters[key] &&
          !(filters[key] instanceof Date) &&
          typeof filters[key] === 'object' &&
          !Array.isArray(filters[key])) ||
        key === '$and' ||
        key === '$or'
      ) {
        filters[key] = this.removeInKeywordForOneElementSearch(filters[key]);
      }
    });
    return filters;
  }

  /**
   * This function takes an array of filters and a common field that they
   * might or might not have. It then combines the filters that have the
   * common field into one filter, and leaves the filters that do not have
   * the common field as they are.
   *
   * @param {Array} filters - the filters to be combined
   * @param {string} commonField - the common field that the filters might or
   * might not have
   * @returns {Array} the combined filters
   */
  static combineSimilarFilters(filters, commonField) {
    const combined = {};
    const resultsNotContainingCommonField = [];
    const resultsWithCommonField = [];

    /**
     * First, we separate the filters into two arrays: one array that contains
     * the filters that do not have the given field, and one array that contains
     * the filters that do have the given field.
     */
    filters.forEach(filter => {
      const commonFieldClause = _.get(filter, commonField, null);

      if (!_.isNil(commonFieldClause)) {
        resultsWithCommonField.push(filter);
      } else {
        resultsNotContainingCommonField.push(filter);
      }
    });

    /**
     * Then, we go through each filter that has the given field and create
     * a new filter that has the given field with the value of that field
     * being an array of values from all the filters that have that field.
     * If the filter does not have the given field, we leave it as it is.
     */
    resultsWithCommonField.forEach(filter => {
      let startFields = filter[commonField];
      if (!startFields['$in']) {
        startFields = [startFields];
      } else {
        startFields = startFields['$in'];
      }

      startFields.forEach(startField => {
        const field = JSON.stringify(startField);

        /**
         * If the field is not already in the combined object, we create
         * a new property in the combined object with the value being the
         * filter with the given field.
         */
        if (!combined[field]) {
          combined[field] = {
            [commonField]: filter[commonField],
            $or: []
          };
        }

        const newSubFilters = _.omit(filter, commonField);

        /**
         * If the filter does not have any other fields, then we remove the
         * $or property from the combined filter.
         */
        if (Object.keys(newSubFilters).length === 0) {
          delete combined[field].$or;
          let currentValue = combined[field][commonField];
          const addedValue = this._returnArrayIfInExists(filter[commonField]);

          /**
           * If the value of the current field is different from the value
           * of the combined filter, then we add the value of the current
           * field to the combined filter.
           */
          if (filter[commonField] !== currentValue) {
            const inClause = _.get(filter, '$in', []);
            if (!_.isEmpty(inClause)) {
              combined[field][commonField]['$in'].push(...addedValue);
              return;
            }
            combined[field][commonField] = {
              $in: [...addedValue, ...combined[field][commonField]]
            };
          }
        } else if (
          /**
           * If the filter has other fields, then we add the other fields to
           * the combined filter with the $or operator.
           */
          combined[field]['$or'] &&
          JSON.stringify(newSubFilters) !== JSON.stringify(filter)
        ) {
          combined[field]['$or'].push(newSubFilters);
        }
      });
    });

    /**
     * Finally, we return the combined filters.
     */
    return [...Object.values(combined), ...resultsNotContainingCommonField];
  }

  /**
   * This function takes an array of filters and an array of all keys from
   * the filters. It goes through each filter and if the filter has an $or
   * field, it calls the combineSimilarFilters function and passes the
   * $or array and the last key from the allKeys array. After that, it
   * calls itself with the $or array and the remaining keys.
   *
   * @param {Array} filters - an array of filters
   * @param {Array} allKeys - an array of all keys from the filters
   * @returns {Array} the filters array with the $or arrays combined
   */
  static _findAndCombineOrFilters(filters, allKeys) {
    filters.forEach(filter => {
      // If the filter has an $or field
      const orClause = _.get(filter, '$or', []);
      if (!_.isEmpty(orClause)) {
        // Get the last key from the allKeys array
        const commonField = allKeys.pop();

        // Combine the $or array with the similar filters
        filter['$or'] = this.combineSimilarFilters(filter['$or'], commonField);

        // Recursively call this function with the $or array and the remaining keys
        filter['$or'] = this._findAndCombineOrFilters(filter['$or'], allKeys);
      }
    });
    return filters;
  }

  /**
   * This function takes an array of filters and goes through each filter. If
   * the filter has an $or field, it calls the _canCombineInFilters function
   * and passes the $or array as an argument. The _canCombineInFilters function
   * checks if there are any filters in the $or array that have only one key
   * and if the key is the same for two or more filters, it combines them into
   * one filter with the $in field. After that, it calls itself with the $or
   * array and the remaining keys.
   *
   * @param {Array} filters - an array of filters
   * @returns {Array} the filters array with the $or arrays combined
   */
  static _findAndCombineInFilters(filters) {
    filters.forEach(filter => {
      const orClause = _.get(filter, '$or', []);
      // If the filter has an $or field
      if (!_.isEmpty(orClause)) {
        // Combine the $or array with the similar filters
        this._canCombineInFilters(filter['$or']);

        // Recursively call this function with the $or array and the remaining keys
        filter['$or'] = this._findAndCombineInFilters(filter['$or']);
      }
    });
    return filters;
  }

  /**
   * This function takes an array of filters and goes through each filter. If
   * the filter has only one key, it means that it can be combined with other
   * filters that have the same key. This function groups the filters by key
   * and then combines them into one filter with the $in field. This function
   * is called recursively until there are no more filters that can be combined.
   *
   * @param {Array} filters - an array of filters
   * @returns {Array} the filters array with the filters combined
   */
  static _canCombineInFilters(filters) {
    // Initialize an empty array to store the filters that are going to be combined
    let filtersIncludingIn = [];

    // Initialize an empty object to store the keys as properties and the values as arrays of indices
    const keys = {};

    // Go through each filter in the filters array
    filters.forEach((filter, index) => {
      // Get the keys of the current filter
      const subFilterKeys = Object.keys(filter);

      // If the filter has only one key
      if (subFilterKeys.length === 1) {
        // Get the key
        const key = subFilterKeys[0];

        // If the key is already in the keys object, add the index to its array
        if (Object.keys(keys).includes(key)) {
          keys[key].push(index);
        } else {
          // Otherwise, create a new array with the index
          keys[key] = [index];
        }
      }
    });

    // Go through each key in the keys object
    Object.entries(keys).forEach(([key, value]) => {
      // If the array of indices has more than one element, it means that there are filters that can be combined
      if (value.length > 1) {
        // Sort the array of indices in descending order
        value.sort((a, b) => b - a);

        // Initialize an empty array to store the filters that are going to be combined
        filtersIncludingIn = [];

        // Go through each index in the sorted array of indices
        value.forEach(index => {
          // Get the filter at the current index
          const result = filters[index];

          // Remove the filter at the current index from the filters array
          filters.splice(index, 1);

          // Add the filter to the filtersIncludingIn array
          filtersIncludingIn.push(result);
        });

        // Combine the filters in the filtersIncludingIn array into one filter with the $in field
        const combinedField = this._combineInFilters(filtersIncludingIn);

        // Add the combined filter to the filters array
        filters.push(combinedField);
      }
    });
  }

  /**
   * This function takes an array of filters and combines them into one filter
   * with the $in field. It does this by getting the key of the first filter
   * and creating a new object with that key and an empty array as a value.
   * Then, it goes through each filter and adds the value of the key to the
   * array. If the value is already an array, it adds the elements of the array
   * to the array. Finally, it returns the combined filter.
   *
   * @param {Array} filters - an array of filters
   * @returns {Object} the combined filter
   */
  static _combineInFilters(filters) {
    // Get the key of the first filter
    const key = Object.keys(filters[0])[0];

    // Create a new object with the key and an empty array as a value
    const combinedField = {
      [key]: { $in: [] }
    };

    // Go through each filter in the filters array
    filters.forEach(filter => {
      // Get the value of the key from the current filter
      const addedValue = this._returnArrayIfInExists(filter[key]);

      // Add the value to the array
      combinedField[key]['$in'].push(...addedValue);
    });
    combinedField[key]['$in'] = Array.from(new Set(combinedField[key]['$in']));

    // Return the combined filter
    return combinedField;
  }

  /**
   * This function takes a value and checks if it has an $in property.
   * If it does, it returns the value of the $in property. If it doesn't,
   * it returns an array containing the value.
   *
   * This is used in the _combineInFilters function to handle the case
   * where a filter has an $in property with an array of values, or
   * a filter has a single value that is not in an array.
   *
   * This function is necessary because the MongoDB $in operator
   * requires an array of values to be passed to it, so we need to
   * make sure that we're passing an array even if the value is not
   * already in an array.
   *
   * @param {Object} value - the value from the filter
   * @returns {Array} the value or an array containing the value
   */
  static _returnArrayIfInExists(value) {
    // Get the value of the $in property of the value
    const inClause = _.get(value, '$in', []);

    // If the $in property is not empty, return it
    if (!_.isEmpty(inClause)) {
      return inClause;
    } else {
      // If the $in property is empty, return an array containing the value
      return [value];
    }
  }

  static _orderSelector(newQuery) {
    const updatedSelector = {};
    for (const key of orderKeysPriority) {
      const value = _.get(newQuery, key, '');
      if (value) updatedSelector[key] = value;
    }
    orderKeysPriority.push('pickupAddress.country._id');
    return {
      ...updatedSelector,
      ..._.omit(newQuery, orderKeysPriority),
      'pickupAddress.country._id': _.get(newQuery, 'pickupAddress.country._id')
    };
  }
}
 
