
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http');

var app = module.exports = express();

// Configuration
var publicPath = require('path').resolve('.', 'public');

app.use(express.static(publicPath));
app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));

http.createServer(app).listen(3000, function () {
  console.log('server start');
});
