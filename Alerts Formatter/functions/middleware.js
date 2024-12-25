const AlertsService = require("./services");

const {POLICY_NAMES} = require("../constants");

class middleware {
    static async alertsFormatter(req, res) {
        let response;
        const payload = req.body;
        const { incident } = payload;
        const { policy_name } = incident;
        const alertsService = new AlertsService(payload);
        switch (policy_name) {
            case POLICY_NAMES.SLOW_SQL_QUERIES:
                ( response = await alertsService.slowSqlQueriesMiddleWare())
            break;
            default:
                ( response = await alertsService.defaultAlertsMiddleware() )
            break;
        }
        res.status(response.status).json({ message: "Sent to Slack successfully", slackResponse: response.data });
    }
}

module.exports = middleware;
