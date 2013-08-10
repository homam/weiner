$ ()->
  skills = [
    ['.NET', 'AJAX', 'MVC', 'C#', 'CSS', 'Casual Games', 'Distributed Syststems', 'Architecture',
      'Scrum', 'SOA', 'SQL', 'Git', 'JavaScript', 'HTML5'],
    ['Cloud Computing', 'Simulations', 'Haskell', 'Canvas', 'SVG', 'Objective-C', 'Node.js'],
    ['ActionScript', 'Flash', 'Mathematica', 'Python', 'Ruby', 'Data Visualization']
  ]

  skills = _(skills.map((s,i) -> s.map (a) -> {name: a, size: i})).flatten()
  skills = skills.sort (a, b) -> if a.name > b.name then 1 else -1

  $skill = d3.select('.skills .list').selectAll('li').data(skills)
  .enter().append('li')
  .text((s) -> s.name + ' ').attr('class', (s) -> ['a', 'b', 'c'][s.size])



  drawSuperFormula = () ->
    height = 300 # $('body').outerHeight()
    width = 400 #$('body').outerWidth()

    max = Math.round window.screen.height/(2*120)

    $svg = d3.select('body').selectAll('svg').data(d3.range(0,max))
    $svg.enter().append('svg').attr('width',width).attr('height', height)
    .style("top", (d,i) -> ((i)*2*120)+"px" )
    $('svg').prependTo($("#fx"))
    size = 1000

    big = d3.superformula().type('star').size(size*50).segments(400)

    $svg.append('path').attr('class', 'superf')
    .attr('transform', 'translate(0,140)').attr('d', big)

    lazy = () ->
      top = $(document).scrollTop()
      #if(top < 0) then return null
      $svg.select('.superf').transition().duration(2)
      .attr('d', big.param('m', (top * .001) + 1200 * .008)#.param('n1', top).param('a', top).param('b', top*100)
      )

    lazy()

    $(window).on('scroll', lazy)

  drawSuperFormula()


  drawSwarm = () ->
    data = d3.range(100).map(->
      xloc: 0
      yloc: 0
      xvel: 0
      yvel: 0
    )
    width = 960
    height = 300
    angle = 2 * Math.PI
    x = d3.scale.linear().domain([-5, 5]).range([0, width])
    y = d3.scale.linear().domain([-5, 5]).range([0, height])
    time0 = Date.now()
    time1 = undefined
    canvas = d3.select("body").append("canvas").attr("width", width).attr("height", height)
    context = canvas.node().getContext("2d")
    context.fillStyle = "steelblue"
    context.strokeStyle = "#666"
    context.strokeWidth = 1.5
    d3.timer ->

      context.clearRect 0, 0, width, height
      data.forEach (d) ->
        d.xloc += d.xvel
        d.yloc += d.yvel
        d.xvel += 0.04 * (Math.random() - .5) - 0.05 * d.xvel - 0.0005 * d.xloc
        d.yvel += 0.04 * (Math.random() - .5) - 0.05 * d.yvel - 0.0005 * d.yloc
        context.beginPath()
        context.arc x(d.xloc), y(d.yloc), Math.min(1 + 1000 * Math.abs(d.xvel * d.yvel), 10), 0, angle
        context.fill()
        context.stroke()

      time1 = Date.now()

      time0 = time1
      return false

  #drawSwarm()


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


    $svg = d3.select('body').selectAll('svg').datum([1,2,3,4,5])
    #$svg.enter().append('svg').attr('width',width).attr('height', height)
    #$('svg').prependTo(document.body)
    #data = (i for i in [0..height] by 10)
    #$svg.selectAll('.line').data(data).enter()
    #.append('line').attr('y1', (d) -> d).attr('y2', (d) -> d).attr('x1', 0).attr('x2', 10)

    window.draw = () ->
      $path = $svg.selectAll('path').data([data])
      $path.enter().append('path')
      $path.transition().duration(2000).attr('d', (d) -> line(d) + (if closePath  then 'Z' else '') )

    #draw()

    setInterval () ->
      data = data.map (p) ->
        p[0] += (if (Math.random() > .5) then 1 else -1) * Math.random()*50
        p[1] += (if (Math.random() > .5) then 1 else -1) * Math.random()*50
        p
      draw()
    ,2000000