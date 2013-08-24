// Generated by CoffeeScript 1.6.2
(function() {
  var app, clientcss, clientjs, piler, srv,
    __slice = [].slice;

  app = null;

  srv = null;

  piler = null;

  clientjs = null;

  clientcss = null;

  exports.initialize = function(_app, _srv, _piler) {
    app = _app;
    srv = _srv;
    piler = _piler;
    clientjs = piler.createJSManager();
    clientjs.renderTagsDefer = function() {
      var namespaces, src, tags, _i, _len, _ref;

      namespaces = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      tags = "";
      _ref = this.getSources.apply(this, namespaces);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        src = _ref[_i];
        tags += this.wrapInTag(src[0], 'defer="defer"' + (src[1] || ''));
        tags += "\n";
      }
      return tags;
    };
    clientjs.bind(app, srv);
    ['jquery2.js', 'd3.js', 'superformula.js', 'underscore.js'].forEach(function(f) {
      return clientjs.addFile("libs", "public/javascript/libs/" + f);
    });
    console.log(clientjs.renderTags("libs"));
    console.log(clientjs.renderTags());
    clientcss = piler.createCSSManager();
    clientcss.bind(app, srv);
    clientcss.addFile("public/styles/fx.styl");
    console.log(clientcss.renderTags());
    return this;
  };

  exports.index = function(req, res) {
    return res.render('index', {
      title: 'Hello World!',
      js: clientjs,
      css: clientcss
    });
  };

  exports["super"] = function(req, res) {
    return res.render('super', {
      title: 'super shapes'
    });
  };

}).call(this);
