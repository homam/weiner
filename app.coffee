express = require 'express'
path = require 'path'
http = require 'http'
piler = require 'piler'


app = express()
srv = http.createServer(app)


app.use express.static '/.public'

app.set 'port', process.env.PORT or 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'ejs'
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router

app.use express.favicon('public/favicon.png')



app.use(require('less-middleware')({src: 'public', dest: 'public', prefix: '/public'}))
app.use require('connect-coffee-script')
  src: __dirname + '/public'
  bare: true


clientjs = piler.createJSManager()
clientjs.bind(app, srv);
clientjs.addFile("public/javascript/index.coffee")
#clientjs.addUrl("http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.js")
['jquery2.js','d3.js','superformula.js','underscore.js'].forEach (f) ->
  clientjs.addFile("libs", "public/javascript/libs/#{f}")
#clientjs.addOb({ VERSION: "1.0.0" });

console.log clientjs.renderTags("libs")
console.log clientjs.renderTags()


clientcss = piler.createCSSManager();
clientcss.bind(app,srv)
clientcss.addFile("public/styles/test.styl")
clientcss.addFile("public/styles/index.less")
console.log clientcss.renderTags()


app.use express.static __dirname + '/public'

app.get '/', (require './routes').index
app.get '/super', (require './routes').super


console.log 'express starting ...'
srv.listen app.get('port'), ()->
  console.log "express started at port " + app.get('port')