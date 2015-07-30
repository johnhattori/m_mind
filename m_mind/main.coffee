COLORS = [
  'yellow'
  'blue'
  'pink'
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
	for color in target
		target_map[color] = if color in target_map then target_map[color] + 1 else 1

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