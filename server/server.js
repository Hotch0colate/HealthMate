const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
var app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use((req, res, next) => {
  const clientIp = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
  // console.log(`Client IP: ${clientIp}`);
  next();
});

const server = app.listen(3000, '0.0.0.0', () => {
  const host = server.address().address;
  const port = server.address().port;
  console.log(`Server is running on http://${host}:${port}`);
});

app.use('/crud', require('./routes/crud'));
app.use('/user', require('./routes/user'));
app.use('/chatlog', require('./routes/chatlog'));
app.use('/access', require('./routes/access'));
app.use('/chatroom', require('./routes/chatroom'));
app.use('/psychiatrist', require('./routes/psychiatrist'));
app.use('/volunteer', require('./routes/volunteer'));