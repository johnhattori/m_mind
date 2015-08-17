COLORS = [
  'yellow'
  'blue'
  'pink'
  'purple'
  'green'
  'red'
]

# Create random target combination
generate_target = (colors, guess_size) ->
	target = []
	for i in [0...guess_size]
	 	target.push(_.sample(colors))
	return target

# if guess right color, right place, then score = 2
# if guess right color, wrong place, then score = 1
score_guess = (guess, target) ->
	score = (0 for [0...guess.length])
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

test_score_guess = ->
	console.assert( _.isEqual(score_guess(['ye', 'bl', 'pe', 'pu'], ['ye', 'bl', 'pe', 'pu']), [2, 2, 2, 2]) )
	console.assert( _.isEqual(score_guess(['ye', 'bl', 'pe', 'pu'], ['ye', 'bl', 'gr', 're']), [2, 2, 0, 0]) )
	console.assert( _.isEqual(score_guess(['ye', 'bl', 'pe', 'pu'], ['bl', 'ye', 'pu', 'pe']), [1, 1, 1, 1]) )
	console.assert( _.isEqual(score_guess(['ye', 'bl', 'pe', 'pu'], ['re', 'gr', 're', 'gr']), [0, 0, 0, 0]) )
	console.assert( _.isEqual(score_guess(['ye', 'bl', 'pe', 'pu'], ['re', 'gr', 'pu', 'pe']), [1, 1, 0, 0]) )
	console.assert( _.isEqual(score_guess(['ye', 'bl', 'pe', 'pu'], ['ye', 'pe', 'pu', 're']), [2, 1, 1, 0]) )
test_score_guess()


GUESS_LEN = 4

update_activeguess = (guess_num) ->
  $('.activeguess').removeClass('activeguess')

  rows = $('.board > tbody > tr')
  for i in [0...GUESS_LEN]
    $(rows[guess_num].children[i]).addClass('activeguess')

$ ->
  guess_num = 0

  update_activeguess(guess_num)

  for color in COLORS
    $('<div/>', {style: "background-color:#{color}"})
      .appendTo('.colors')

  $('.colors > div').draggable({helper: 'clone'})
  $('.guess .activeguess').droppable(
    drop: (event, ui) ->
      drop_color =  $(ui.draggable).css('background-color')
      $(this).css('background-color', drop_color)
  )
