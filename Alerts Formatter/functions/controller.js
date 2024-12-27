const { ALERT_STATES} = require("../constants");
const { SLACK_CHANNELS } = require('../secrets')

const _ = require("lodash");
const axios = require("axios");

class AlertsFormatter{
    async slowSqlQueries(incident, mainBlocks){
        const { metric } = incident;
        const { labels } = metric;

        const sortedLabels = {
            ..._.omit(labels, ['queryExecuted','insertId', 'log', 'User', 'machine']),
            queryExecuted:labels['queryExecuted']
        }

        const alertDetails = Object.entries(sortedLabels)
            .map(([key, value]) => {
                if (key === "queryExecuted") {
                    return `*${key}*:\t\`\`\`${value}\`\`\``;
                }
                return `*${key}*:\t_${value}_`;
            })
            .join("\n");

        const blocks = _.cloneDeep(mainBlocks);

        const incidentLabels = {
            incidentId: _.get(incident, "incident_id"),
            machine: _.get(labels, "machine"),
            user: _.get(labels, "User"),
            };

        const incidentSection = Object.entries(incidentLabels).map(([key, value]) => {
            return `*${key}*:\t_${value}_`;
        }).join("\n")

        blocks.push(
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: incidentSection,
                },
            },
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: alertDetails,
                },
            }
            );

        const attachments = [{ color:"#ff0000",blocks }];
        const data = {attachments}

        const response = await axios.post(
            SLACK_CHANNELS.SLOW_SQL_QUERY_WEBHOOK,
            data,
            {
                headers: {
                    "Content-Type": "application/json",
                },
            }
        );

        return response
    }

    async defaultAlertsFormatter(incident, mainBlocks) {
        const { metric } = incident;
        const { labels } = metric;

        const state = _.get(incident, 'state');

        const incidentColor = state === ALERT_STATES.OPEN ? "#ff0000" : "#36a64f";

        const sortedLabels = _.omit(labels, ['insertId', 'log'])

        const alertDetails = Object.entries(sortedLabels)
            .map(([key, value]) => {
                return `*${key}*:\t_${value}_`;
            })
            .join("\n");

        const blocks = _.cloneDeep(mainBlocks);

        const incidentLabels = _.pick(incident, ["observed_value","incident_id"]);
        const incidentSection = Object.entries(incidentLabels).map(([key, value]) => {
            return `*${key}*:\t_${value}_`;
        }).join("\n")

        blocks.push(
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: incidentSection,
                },
            },
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: alertDetails,
                },
            }
            );

        const attachments = [{ color:incidentColor,blocks }];
        const data = {attachments}

        const response = await axios.post(
            SLACK_CHANNELS.HEARTBEATS_WEBHOOK,
            data,
            {
                headers: {
                    "Content-Type": "application/json",
                },
            }
        );

        return response
    }
}

const alertsFormatter = new AlertsFormatter()

module.exports = alertsFormatter;
