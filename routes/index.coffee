exports.index = (req, res) ->
  res.render 'index',
    title: 'Hello World!'
exports.super = (req,res) ->
  res.render 'super',
    title: 'super shapes'