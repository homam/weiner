$ ()->

  ((a) ->
    (jQuery.browser = jQuery.browser or {}).mobile = /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) or /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))
  ) navigator.userAgent or navigator.vendor or window.opera

  skills = [
    ['.NET', 'AJAX', 'MVC', 'C#', 'CSS3', 'Casual Games', 'Distributed Syststems', 'Architecture',
      'Scrum', 'SOA', 'SQL', 'Git', 'JavaScript', 'HTML5'],
    ['Cloud Computing', 'Simulations', 'Haskell', 'Canvas', 'SVG', 'Objective-C', 'Node.js', 'Data Visualization', 'XML'],
    ['ActionScript', 'Flash', 'Mathematica', 'Python', 'Ruby', 'R', 'Java', 'Scala']
  ]

  skills = _(skills.map((s,i) -> s.map (a) -> {name: a, size: i})).flatten()
  skills = skills.sort (a, b) -> if a.name > b.name then 1 else -1

  $skill = d3.select('.skills .list').selectAll('li').data(skills)
  .enter().append('li')
  .text((s) -> s.name + ' ').attr('class', (s) -> ['a', 'b', 'c'][s.size])

  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g)
    $('a.twitter').attr('href', 'twitter://user?screen_name=homam').attr('target', null )
  else if not $.browser.mobile
    $('.twitter').on 'click', ->
      $("body").addClass("show-modal")
      $('body').one 'click', -> $("body").removeClass("show-modal")
      false



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