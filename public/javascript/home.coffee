cos = Math.cos
sin = Math.sin
pow = Math.pow
pi = Math.PI

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
  width = height = circleR = imageSize  = null

  $svg = d3.select($viewport).append("svg")
  $g = $svg.append('g')

  sizeChanged = ->
    width = $viewport.clientWidth
    height = $viewport.clientHeight
    imageSize= Math.min(width,height)/8
    circleR = imageSize/2
    $svg.attr("width", width).attr("height", height)
    $g.attr("transform", "translate(#{width/2},#{height/2})")

  window.addEventListener 'resize', -> sizeChanged()

  sizeChanged()





  bezier = (p0, p1, p2, p3) ->
    (t) ->
      v = (w) ->
        pow((1-t),3)*p0[w]+3*pow((1-t),2)*t*p1[w]+3*(1-t)*t*t*p2[w]+t*t*t*p3[w]
      return {x: v('x'), y:v('y')}


  line = d3.svg.line().x((d) -> d.x).y((d) -> d.y).interpolate("basis")

  links = [
    {image: 'images/linkedin.svg', href: 'http://www.linkedin.com/in/homamhosseini'}
    {image: 'images/facebook.svg', href: 'https://www.facebook.com/homam.me'}
    {image: 'images/twitter.svg', href: 'https://twitter.com/homam'}
    {image: 'images/h.svg', href: 'cv'}
    {image: 'images/github.svg', href: 'https://github.com/homam'}
  ]

  length = links.length

  image = (d,i) -> links[i].image
  href = (d,i) -> links[i].href


  animating = true
  frequency = 100
  speed = .01
  time = 0
  draw = () ->

    setTimeout draw, frequency

    if not animating
      return

    time++

    t = (time*speed*pi)

    b = bezier({x:0,y:0}, {x:.2,y:2*sin(t)},{x:.7,y:-.8*cos(t)},{x:1,y:0})


    do ->
      bezPoints = (-t*.125+.5*a for a in [0..3]).map((a) ->
        (rotate(a*pi, b(x/5)) for x in [0..5])
        .map((p) -> {x:p.x*width*.6, y:p.y*height*.6})
      )

      $line = $g.selectAll('path.bez').data(bezPoints)
      $line.enter().append('path').attr('class', 'bez')
      $line.transition().ease('linear').duration(frequency).attr("d", line)

    do ->
      points = (.25+-t*.25+(1/(length/2))*a for a in [0..length-1]).map((a) ->
        (rotate(a*pi, {x: 2*pi*x/4, y:sin(x/4*pi*2+time*pi*speed*2)-sin((time)*pi*speed*2)}) for x in [0..4])
        .map((p) -> {x:p.x*width*.05, y:p.y*height*.05})
      )

      $sinLine = $g.selectAll('path.sin').data(points)
      $sinLine.enter().append("path").attr('class','sin')
      $sinLine.transition().ease('linear').duration(frequency).attr("d", line)

    do ->
      points = (-t*0.25+(1/(length/2))*a for a in [0..length-1]).map((a) ->
        (rotate(a*pi, {x: 2*pi*x/4, y:sin(x/4*pi*2+time*pi*.1)-sin((time)*pi*.1)}) for x in [0..4])
        .map((p) -> {x:p.x*width*.05, y:p.y*height*.05})
      )

      $line = $g.selectAll('path.csin').data(points)
      $line.enter().append('path').attr('class', 'csin')
      $line.transition().ease('linear').duration(frequency).attr("d", line)
      $circle = $g.selectAll('circle').data(points)
      $circle.enter().append('circle')
      $circle.transition().ease('linear').duration(frequency).attr('cx', (d) -> d[d.length-1].x).attr('cy', (d) -> d[d.length-1].y).attr('r', circleR)


      $a = $g.selectAll('a').data(points)
      $a.enter().append('a').append('image').attr("xlink:href", image)
      $a.attr('xlink:href', href)
      .transition().ease('linear').duration(frequency)
      $image = $a.select('image')
      $image.attr("width",imageSize).attr("height", imageSize)
      .transition().ease('linear').duration(frequency)
      .attr("transform", (d,i) -> "translate(#{-imageSize/2 + d[d.length-1].x} #{-imageSize/2 + d[d.length-1].y}) rotate(#{-6*time+i*45},#{imageSize/2},#{imageSize/2})")
      $image.on 'mouseover', ->
        animating = false
      $image.on 'mouseout', ->
        if not animating
          animating = true

      #.attr("transform", (d,i) -> "translate(#{-imageSize/2 - d[d.length-1].x} #{-imageSize/2 - d[d.length-1].y}) rotate(#{-12*time+i*45},#{imageSize/2},#{imageSize/2})")
      #.attr('x', (d) -> d[d.length-1].x-imageSize/2)
      #.attr('y', (d) -> d[d.length-1].y-imageSize/2)
      #.attr("transform", (d) -> "rotate(#{-time*18}) translate(#{-imageSize/2 - d[d.length-1].x} #{-imageSize/2 - d[d.length-1].y})")


      #points = ({x: 2*pi*x/4, y:sin(x/4*pi*2+time*pi*.1)-sin((time)*pi*.1)} for x in [0..4])
      #.map((p) -> {x:p.x*30,y:p.y*30})


  draw()