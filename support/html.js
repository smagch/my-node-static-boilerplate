/**
 * make requests
 * and write
 */
var req = require('request')
  , glob = require('glob')
  , async = require('async')
  , path = require('path')
  , fs = require('fs')
  , mkdirp = require('mkdirp')
  , debug = require('debug')('dev')
  , matcher = /^views\/(.*index)\.jade/;

module.exports = buildHtml;

function buildHtml(done) {
  glob('views/**/index.jade', function (err, files) {
    if (err) done(err);

    var reqPaths = files.map(function (filename) {
      var match = matcher.exec(filename);
      if (!match || !match[1]) throw new Error('no match : ' + filename);
      debug('file : ' + match[1] + '.html');
      return match[1] + '.html';
    });

    async.map(reqPaths, write, done);
  });
}

// TODO only statusCode 200
function write(filename, done) {
  var writePath = path.resolve('.', 'public', filename)
    , abort;

  debug('writePath : ' + writePath);

  mkdirp(path.dirname(writePath), function (err) {
    if (err) return done(err);
    req('http://localhost:3000/' + filename)
      .on('error', function (err) {
        if (abort) return
        abort = true
        done(err)
      })
      .on('end', function () {
        if (abort) return
        debug('reqest end : ' + filename)
      })
      .pipe(fs.createWriteStream(writePath))
        .on('error', function (err) {
          if (abort) return
          done(err)
        })
        .on('close', function () {
           if (abort) return
           // simply return filename
           done(null, filename)
        });
  });
}