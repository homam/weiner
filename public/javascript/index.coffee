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


  height = $('body').outerHeight()
  $svg = d3.select('body').append('svg').attr('width',200).attr('height', height)
  $('svg').prependTo(document.body)
  data = (i for i in [0..height] by 10)
  $svg.selectAll('.line').data(data).enter()
  .append('line').attr('y1', (d) -> d).attr('y2', (d) -> d).attr('x1', 0).attr('x2', 10)
