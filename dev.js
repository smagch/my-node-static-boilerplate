
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http');

var app = module.exports = express();

// Configuration
var publicPath = require('path').resolve('.', 'public');
var path = require('path')
  , exec = require('child_process').exec;

function execMake(filename, next) {
  exec('make ' + filename + ' -B', function (err, stderr, stdout) {
    console.log('made : ' + filename);
    next();
  });
};

app.get('*/', function (req, res, next) {
  execMake('public' + req.url + '.html', next);
});

app.get('*.html', function (req, res, next) {
  execMake('public' + req.url, next);
});

app.get('*.css', function (req, res, next) {
  execMake('public' + req.url, next);
});

app.use(express.static(publicPath));
app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));


http.createServer(app).listen(3000, function () {
  console.log('server start');
});
