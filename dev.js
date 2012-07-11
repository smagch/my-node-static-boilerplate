
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , path = require('path')
  , debug = require('debug')('dev')
  , app = module.exports = express()
  , publicPath = path.resolve('.', 'public')
  , mf = require('./routes/mf');

/**
 * add view locals
 */

app.locals(require('./locals'));

//var mf = new MessageFormat();
app.locals.use(function (req, res, done) {
  var lang;
  if (/\/en\//.test(req.url)) {
    lang = 'en';
  } else {
    lang = 'ja';
  }

  res.locals.lang = lang;
  res.locals.suffix = lang === 'ja' ? '' : lang;

  res.locals.i18n = mf.use(lang);
  done();
});

/**
 * set view engine jade
 */
app.set('view engine', 'jade');

/**
 * add stylus middleware
 * it's fine since this server is for development only
 */
app.use(require('./routes/stylus'));

/**
 * router
 */
app.use(app.router);

/**
 * only render index.jade
 * to see list of pages, `make pages`
 */
app.get('*/', function (req, res, next) {
  var url = req.url;
  debug('GET ' + url);
  res.render(url.substr(1) + 'index')
});

app.get('*/index.html', function (req, res, next) {
  debug('GET ' + req.url);

  var match = /^\/(.+)\.html$/.exec(req.url);
  debug('about to render : ' + match[1]);
  res.render(match[1]);
});

app.use(express.static(publicPath));

// app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));

http.createServer(app).listen(3000, function () {
  debug('dev server start')
});
