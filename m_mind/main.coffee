COLORS = [
  'yellow'
  'blue'
  'pink'
  'purple'
  'green'
  'red'
]

$ ->
  for color in COLORS
    $('<div/>', {style: "background-color:#{color}"})
      .appendTo('.colors')