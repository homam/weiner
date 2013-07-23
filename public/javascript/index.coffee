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
