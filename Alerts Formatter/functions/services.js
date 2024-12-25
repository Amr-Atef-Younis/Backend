const alertsFormatter = require("./controller");

class AlertsService {
    constructor(payload) {
        const { incident } = payload;
        if (!incident || !incident.metric || !incident.metric.labels) {
            return res.status(400).json({ error: "Invalid payload structure" });
        }
        const { policy_name } = incident;

        this.incident = incident;
        this.mainBlocks = [
            {
                type: "header",
                text: {
                    type: "plain_text",
                    text: `${policy_name}`,
                },
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
