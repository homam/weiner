types = {
  asterisk: {m: 12, n1: .3, n2: 0, n3: 10, a: 1, b: 1},
  bean: {m: 2, n1: 1, n2: 4, n3: 8, a: 1, b: 1},
  butterfly: {m: 3, n1: 1, n2: 6, n3: 2, a: .6, b: 1},
  circle: {m: 4, n1: 2, n2: 2, n3: 2, a: 1, b: 1},
  clover: {m: 6, n1: .3, n2: 0, n3: 10, a: 1, b: 1},
  cloverFour: {m: 8, n1: 10, n2: -1, n3: -8, a: 1, b: 1},
  cross: {m: 8, n1: 1.3, n2: .01, n3: 8, a: 1, b: 1},
  diamond: {m: 4, n1: 1, n2: 1, n3: 1, a: 1, b: 1},
  drop: {m: 1, n1: .5, n2: .5, n3: .5, a: 1, b: 1},
  ellipse: {m: 4, n1: 2, n2: 2, n3: 2, a: 9, b: 6},
  gear: {m: 19, n1: 100, n2: 50, n3: 50, a: 1, b: 1},
  heart: {m: 1, n1: .8, n2: 1, n3: -8, a: 1, b: .18},
  heptagon: {m: 7, n1: 1000, n2: 400, n3: 400, a: 1, b: 1},
  hexagon: {m: 6, n1: 1000, n2: 400, n3: 400, a: 1, b: 1},
  malteseCross: {m: 8, n1: .9, n2: .1, n3: 100, a: 1, b: 1},
  pentagon: {m: 5, n1: 1000, n2: 600, n3: 600, a: 1, b: 1},
  rectangle: {m: 4, n1: 100, n2: 100, n3: 100, a: 2, b: 1},
  roundedStar: {m: 5, n1: 2, n2: 7, n3: 7, a: 1, b: 1},
  square: {m: 4, n1: 100, n2: 100, n3: 100, a: 1, b: 1},
  star: {m: 5, n1: 30, n2: 100, n3: 100, a: 1, b: 1},
  triangle: {m: 3, n1: 100, n2: 200, n3: 200, a: 1, b: 1}
}

format = d3.format(".4n")
scale = d3.scale.linear().domain([-200, 200]).range([-200, 200]);
#scale = d3.scale.pow().exponent(1.5)#.domain([0,100]).range([0,1000])

$svg = d3.select('body').append('svg')
.attr('widht', 960).attr('height', 500)

shape = d3.superformula().type('asterisk').size(100000).segments(3600)

$path = $svg.append('path').attr('class', 'big')
.attr('transform', 'translate(480,250)')
.attr('d', shape)

$control = d3.select("#controls").selectAll("div").data(d3.entries(types.asterisk)).enter().append("div").attr("id", (d) -> d.key)
$control.append("label").text (d) -> d.key

$control.append("input").attr("type", "range").attr("max", 200).attr("min", -200)
.property("value", (d) ->
  d.value
  #scale d.value
)
.on "change", (d) ->
  #v = scale.invert(@value)
  v = scale @value
  $path.attr "d", shape.param(d.key, v)
  d3.select(@nextSibling).text @value+ ">"+ format(v)

$control.append("span").text (d) -> format d.value

types = d3.select("#controls").append("div").selectAll("button").data(d3.entries(types)).enter().append("button").text((d) -> d.key)
.on "click", (d) ->
  for param of d.value
    $control = d3.select("#" + param)
    $control.select("input").property "value", scale(d.value[param])
    $control.select("span").text format(d.value[param])
    shape.param param, d.value[param]
  $path.transition().duration(500).attr 'd', shape
