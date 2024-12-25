const express =  require('express');
const serverless = require('serverless-http');
const cors = require('cors');
const middleware = require("./middleware");
const app = express();
const router = express.Router();

app.use(cors());

app.use(express.json());

router.post(
    '/',
    middleware.alertsFormatter
);


app.use('/', router);
module.exports.handler = serverless(app);
