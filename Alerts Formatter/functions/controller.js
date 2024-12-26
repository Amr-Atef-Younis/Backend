const { ALERT_STATES} = require("../constants");
const { SLACK_CHANNELS } = require('../secrets')

const _ = require("lodash");
const axios = require("axios");

class AlertsFormatter{
    async slowSqlQueries(incident, mainBlocks){
        const { metric, url } = incident;
        const { labels } = metric;

        const sortedLabels = {..._.omit(labels, ['queryExecuted','insertId', 'log']), queryExecuted:labels['queryExecuted']}

        const labelString = Object.entries(sortedLabels)
            .map(([key, value]) => {
                if (key === "queryExecuted") {
                    return `*${key}*:\t\`\`\`${value}\`\`\``; // Indented code block for "queryExecuted"
                }
                return `*${key}*:\t_${value}_`; // Indented format for
            })
            .join("\n");


        const blocks = _.cloneDeep(mainBlocks);

        const insertId = labels['insertId'];
        const cloudUrl = `https://console.cloud.google.com/logs/query;query=insertId%3D%22${insertId}%22?project=bosta-new-infrastructure`

        blocks.push(
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: `<${url}|*Alert link*>\t<${cloudUrl}|*Log link*>`
                },
            },
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: labelString,
                },
            });

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
        const { metric, url } = incident;
        const { labels } = metric;

        const state = _.get(incident, 'state');

        const incidentColor = state === ALERT_STATES.OPEN ? "#ff0000" : "#36a64f";

        const sortedLabels = _.omit(labels, ['insertId', 'log'])

        const labelString = Object.entries(sortedLabels)
            .map(([key, value]) => {
                return `*${key}*:\t_${value}_`; // Indented format for
            })
            .join("\n");

        const blocks = _.cloneDeep(mainBlocks);

        blocks.push(
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: `<${url}|*Alert link*>`
                },
            },
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: labelString,
                },
            });

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
