const alertsFormatter = require("./controller");
const _ = require("lodash");

class AlertsService {
    constructor(payload) {
        const { incident } = payload;
        if (!incident || !incident.metric || !incident.metric.labels) {
            return res.status(400).json({ error: "Invalid payload structure" });
        }
        const { policy_name, url } = incident;

        let hyperLinks = `<${url}|*Alert link*>`

        const insertId = _.get(incident, "metric.labels.insertId");

        if (insertId) {
            const encodedInsertId = encodeURIComponent(insertId);
            const cloudUrl = `https://console.cloud.google.com/logs/query;query=insertId%3D%22${encodedInsertId}%22?project=bosta-new-infrastructure`
            hyperLinks += `\t<${cloudUrl}|*Log link*>`
        }

        this.incident = incident;
        this.mainBlocks = [
            {
                type: "header",
                text: {
                    type: "plain_text",
                    text: `${policy_name}`,
                }
            },
            {
                type: "section",
                text: {
                    type: "mrkdwn",
                    text: hyperLinks
                }
            }
        ]
    }

    async slowSqlQueriesMiddleWare() {
        try {
            const response = await alertsFormatter.slowSqlQueries(this.incident, this.mainBlocks)
            return response
            } catch (error) {
                console.error("Error sending to Slack:", error.message);
                res.status(500).json({ error: "Failed to send to Slack", details: error.message });
            }
    }

    async defaultAlertsMiddleware(){
        try {
            const response = await alertsFormatter.defaultAlertsFormatter(this.incident, this.mainBlocks)
            return response
        } catch (error) {
            console.error("Error sending to Slack:", error.message);
            res.status(500).json({ error: "Failed to send to Slack", details: error.message });
        }
    }

}

module.exports = AlertsService;
