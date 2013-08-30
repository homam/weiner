app = null
srv = null
piler = null
cvJs = null
cvCss = null
exports.initialize = (_app,_srv,_piler) ->
  app = _app
  srv = _srv
  piler = _piler
  cvJs = piler.createJSManager()
  cvJs.renderTagsDefer = (namespaces...) ->

    tags = ""
    for src in @getSources namespaces...
      tags += @wrapInTag src[0], 'defer="defer"' +  (src[1] || '')
      tags += "\n"
    return tags

  cvJs.bind(app, srv);
  #clientjs.addFile("public/javascript/index.coffee")
  #clientjs.addUrl("http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.js")
  ['jquery2.js','d3.js','superformula.js','underscore.js'].forEach (f) ->
    cvJs.addFile("libs", "public/javascript/libs/#{f}")
  #clientjs.addOb({ VERSION: "1.0.0" });


  cvCss = piler.createCSSManager();
  cvCss.bind(app,srv)
  cvCss.addFile("cv", "public/styles/fx.styl")
  #clientcss.addFile("public/styles/index.less")


  cvCss.addFile("home", "public/styles/home.styl")

  ['libs/d3.js', 'home.coffee'].forEach (f) ->
    cvJs.addFile("home", "public/javascript/#{f}")

  this




exports.index = (req, res) ->
  res.render 'index',
    title: 'Homam Hosseini'
    js: cvJs
    css: cvCss

exports.cv = (req, res) ->
  res.render 'cv',
    title: 'Homam Hosseini'
    js: cvJs
    css: cvCss

exports.super = (req,res) ->
  res.render 'super',
    title: 'super shapes'
    css: cvCss
    js: cvJs