// modernizr configration
(function (Modernizr) {
  Modernizr.load([
    {
      test: window.JSON,
      nope: '/javascripts/libs/json2.js'
    }
  ]);
})(window.Modernizr);