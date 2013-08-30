cos = Math.cos
sin = Math.sin
pow = Math.pow

rotationMatrix = (angle) ->
  [
    [cos(angle), -sin(angle)]
    [sin(angle), cos(angle)]
  ]

translate = (vector, p) ->
  x: vector.x + p.x
  y: vector.y + p.y

rotate = (angle, p) ->
  x = p.x
  y = p.y
  x: x*cos(angle)-y*sin(angle)
  y: x*sin(angle)+y*cos(angle)


window.addEventListener 'load', ->
  $viewport = document.getElementById("viewport")
  width = $viewport.clientWidth
  height = $viewport.clientHeight
  circleR = width/20
  imageSize= width/10
  circleR = imageSize/2


  $svg = d3.select($viewport).append("svg").attr("width", width).attr("height", height)
  $g = $svg.append('g').attr("transform", "translate(#{width/2},#{height/2})")



  bezier = (p0, p1, p2, p3) ->
    (t) ->
      v = (w) ->
        pow((1-t),3)*p0[w]+3*pow((1-t),2)*t*p1[w]+3*(1-t)*t*t*p2[w]+t*t*t*p3[w]
      return {x: v('x'), y:v('y')}

  sinp = (t) ->
    {x: t, y: sin(t)}

  line = d3.svg.line().x((d) -> d.x).y((d) -> d.y).interpolate("basis")

  links = [
    {image: 'images/linkedin.svg'}
    {image: 'images/facebook.png'}
    {image: 'images/twitter.png'}
    {image: 'favicon.png'}
  ]

  image = (d,i) ->
    links[i].image


  time = 0
  draw = () ->

    time++

    t = (time*.1*Math.PI)

    b = bezier({x:0,y:0}, {x:sin(t),y:2},{x:.7,y:-.8},{x:1,y:0})


    points = (-t*.25+.5*a for a in [0..3]).map((a) ->
      (rotate(a*Math.PI, b(x/10)) for x in [0..10])
      .map((p) -> {x:p.x*width*.4, y:p.y*height*.25})
#      (rotate(a*Math.PI, sinp(x/10*(t%180)*Math.PI/90)) for x in [0..10])
#      .map((p) -> {x:p.x*width*.3, y:p.y*height*.3})
    )


    $line = $g.selectAll('path').data(points)
    $line.enter().append('path')
    $line.transition().ease('linear').duration(1000).attr("d", line)
    $circle = $g.selectAll('circle').data(points)
    $circle.enter().append('circle')
    $circle.transition().ease('linear').duration(1000).attr('cx', (d) -> d[d.length-1].x).attr('cy', (d) -> d[d.length-1].y).attr('r', circleR)


    $image = $g.selectAll('image').data(points)
    $image.enter().append("image").attr("xlink:href", image)
    .attr("width",imageSize).attr("height", imageSize)
    $image.transition().ease('linear').duration(1000)
    .attr("transform", (d,i) -> "translate(#{-imageSize/2 - d[d.length-1].x} #{-imageSize/2 - d[d.length-1].y}) rotate(#{-12*time+i*45},#{imageSize/2},#{imageSize/2})")
    #.attr('x', (d) -> d[d.length-1].x-imageSize/2)
    #.attr('y', (d) -> d[d.length-1].y-imageSize/2)
    #.attr("transform", (d) -> "rotate(#{-time*18}) translate(#{-imageSize/2 - d[d.length-1].x} #{-imageSize/2 - d[d.length-1].y})")



  setInterval draw, 1000