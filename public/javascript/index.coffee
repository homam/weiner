$ ()->
  skills = [
    ['.NET', 'AJAX', 'MVC', 'C#', 'CSS', 'Casual Games', 'Distributed Syststems', 'Architecture', 'Scrum', 'SOA', 'SQL', 'Git', 'JavaScript', 'HTML5'],
    ['Cloud Computing', 'Simulations', 'Haskell', 'Canvas', 'SVG', 'Objective-C'],
    ['ActionScript', 'Flash', 'Mathematica', 'Python', 'Ruby', 'Visualization']
  ]

  skills = _(skills.map((s,i) -> s.map (a) -> {name: a, size: i})).flatten()
  skills = skills.sort (a, b) -> if a.name > b.name then 1 else -1

  $skill = d3.select('.skills .list').selectAll('li').data(skills)
  .enter().append('li')
  .text((s) -> s.name + ' ').attr('class', (s) -> ['a', 'b', 'c'][s.size])


  fancySVG = () ->

    xScale = (p) -> p[0] * 4 +4
    yScale = (p) -> p[1] * + 4

    closePath = false

    window.data = [0..299].map (i) -> [0,0]

    window.line = d3.svg.line().x(xScale).y(yScale)#.interpolate('basis')


    square = () ->
      closePath = false
      yScale = (p) -> p[1] * 2 + 4
      window.line = window.line.y(yScale)
      window.data = data.map (p, i) ->
        quarter = data.length/3
        p = switch
          when i <= quarter-1 then [0,i+1]
          when i <= 2*quarter then [(i-quarter), quarter]
          else [quarter, 3*quarter-i]
        p

    normal = () ->
      closePath = false
      yScale = (p) -> p[1] * 20000 + 4
      window.line = window.line.y(yScale)
      mu = (data.length-1)/2
      sigma = Math.random() * (mu*.5-mu*.1) + mu*.1
      console.log mu, sigma
      window.data = data.map (p,i) ->
        [i/3, (1/(sigma*2*3.14)) * Math.exp(-0.5*Math.pow((i-mu)/sigma, 2))]

    square()
    #normal()

    setInterval () ->
     if Math.random() > .1
        normal()
     else
        square()
     draw()
    ,2000


    height = $('body').outerHeight()
    width = $('body').outerWidth()


    $svg = d3.select('body').append('svg').attr('width',width).attr('height', height)
    $('svg').prependTo(document.body)
    #data = (i for i in [0..height] by 10)
    #$svg.selectAll('.line').data(data).enter()
    #.append('line').attr('y1', (d) -> d).attr('y2', (d) -> d).attr('x1', 0).attr('x2', 10)

    window.draw = () ->
      $path = $svg.selectAll('path').data([data])
      $path.enter().append('path')
      $path.transition().duration(2000).attr('d', (d) -> line(d) + (if closePath  then 'Z' else '') )

    draw()

    setInterval () ->
      data = data.map (p) ->
        p[0] += (if (Math.random() > .5) then 1 else -1) * Math.random()*50
        p[1] += (if (Math.random() > .5) then 1 else -1) * Math.random()*50
        p
      draw()
    ,2000000