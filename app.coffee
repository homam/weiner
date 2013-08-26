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




app.use express.static __dirname + '/public'

indexRoute = (require './routes')
indexRoute.initialize(app, srv, piler)

app.get '/', indexRoute.index
app.get '/cv', indexRoute.index
app.get '//cv', indexRoute.index
app.get '/super', (require './routes').super


console.log 'express starting ...'
srv.listen app.get('port'), ()->
  console.log "express started at port " + app.get('port')