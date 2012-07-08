/**
 * make requests
 * and write
 */
var req = require('request')
  , glob = require('glob')
  , async = require('async')
  , path = require('path')
  , fs = require('fs')
  , debug = require('debug')('dev')
  , matcher = /^views\/(.*index)\.jade/;

glob('views/**/index.jade', function (err, files) {
  if (err) throw err

  var reqPaths = files.map(function (filename) {
    var match = matcher.exec(filename)
    if (!match || !match[1]) {
      throw new Error('no match : ' + filename)
    }

    debug('file : ' + match[1] + '.html')

    return match[1] + '.html'
  })

  async.map(reqPaths, write, function (err, results) {
    if (err) throw err
    console.log('build finished, wrote ' + results.length + ' files')
  })
})

function write(filename, done) {
  var abort;

  req('http://localhost:3000/' + filename)
    .on('error', function (err) {
      if (abort) return
      abort = true
      done(err)
    })
    .on('end', function () {
      if (abort) return
      // done()
      debug('reqest end : ' + filename)
    })
    .pipe(fs.createWriteStream(path.resolve('.', 'foo.html')))
      .on('error', function (err) {
        if (abort) return
        done(err)
      })
      .on('close', function () {
         if (abort) return
         done(null, 'OK')
      })
}