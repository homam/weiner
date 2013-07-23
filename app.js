// Generated by CoffeeScript 1.6.2
(function() {
  var app, express, http, path;

  express = require('express');

  path = require('path');

  http = require('http');

  app = express();

  app.use(express["static"]('/.public'));

  app.set('port', process.env.PORT || 3000);

  app.set('views', __dirname + '/views');

  app.set('view engine', 'ejs');

  app.use(express.logger('dev'));

  app.use(express.bodyParser());

  app.use(express.methodOverride());

  app.use(app.router);

  app.use(express.favicon());

  app.use(require('less-middleware')({
    src: 'public',
    dest: 'public',
    prefix: '/public'
  }));

  app.use(require('connect-coffee-script')({
    src: __dirname + '/public',
    bare: true
  }));

  app.use(express["static"](__dirname + '/public'));

  app.get('/', (require('./routes')).index);

  http.createServer(app).listen(app.get('port'), function() {
    return console.log("express started at port " + app.get('port'));
  });

}).call(this);
