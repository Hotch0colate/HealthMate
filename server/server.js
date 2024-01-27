const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
var app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
var server = app.listen(3000, console.log('Server is running on port 3000'));

app.use('/crud', require('./routes/crud'));
app.use('/user', require('./routes/user'));
app.use('/chatlog', require('./routes/chatlog'));
app.use('/chatroom', require('./routes/chatroom'));
app.use('/psychiatrist', require('./routes/psychiatrist'));
app.use('/volunteer', require('./routes/volunteer'));