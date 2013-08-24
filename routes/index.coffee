app = null
srv = null
piler = null
clientjs = null
clientcss = null
exports.initialize = (_app,_srv,_piler) ->
  app = _app
  srv = _srv
  piler = _piler
  clientjs = piler.createJSManager()
  clientjs.renderTagsDefer = (namespaces...) ->

    tags = ""
    for src in @getSources namespaces...
      tags += @wrapInTag src[0], 'defer="defer"' +  (src[1] || '')
      tags += "\n"
    return tags

  clientjs.bind(app, srv);
  #clientjs.addFile("public/javascript/index.coffee")
  #clientjs.addUrl("http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.js")
  ['jquery2.js','d3.js','superformula.js','underscore.js'].forEach (f) ->
    clientjs.addFile("libs", "public/javascript/libs/#{f}")
  #clientjs.addOb({ VERSION: "1.0.0" });

  console.log clientjs.renderTags("libs")
  console.log clientjs.renderTags()


  clientcss = piler.createCSSManager();
  clientcss.bind(app,srv)
  clientcss.addFile("public/styles/test.styl")
  #clientcss.addFile("public/styles/index.less")
  console.log clientcss.renderTags()

  this




exports.index = (req, res) ->
  res.render 'index',
    title: 'Hello World!'
    js: clientjs

exports.super = (req,res) ->
  res.render 'super',
    title: 'super shapes'