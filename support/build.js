/**
 * make requests
 * and write
 */
var html = require('./html');

html(function (err, doc) {
  if (err) throw err;
  console.log('html build complete, wrote ' + doc.length);
});