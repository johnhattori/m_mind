COLORS = [
  'yellow'
  'blue'
  'white'
  'purple'
  'green'
  'red'
]

# if guess right color, right place, then score = 2
# if guess right color, wrong place, then score = 1
score_guess = (guess, target) ->
	score = (0 for [0..guess.length])
	target_map = {}
	# creates target_map
	for i in target
		target_map[i] = 1 if not i in target_map else target_map[i] + 1

	for color, index in guess
		if target[index] == color
			score[index] = 2
			target_map[color] -= 1

	for color, index in guess
		if target_map[color] > 0 and score[index] != 2
			target_map[color] -= 1
			score[index] = 1

	score.sort().reverse()		
	return score	

$ ->
  for color in COLORS
    $('<div/>', {style: "background-color:#{color}"})
      .appendTo('.colors')