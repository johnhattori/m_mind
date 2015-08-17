COLORS = [
  'yellow'
  'blue'
  'pink'
  'purple'
  'green'
  'red'
]

SCORE_MAP =
  2: 'black'
  1: 'gray'
  0: 'white'

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


GUESS_SIZE = 4

update_activeguess = (guess_num) ->
  $('.guess .activeguess').droppable('destroy')
  $('.activeguess').removeClass('activeguess')

  rows = $('.board > tbody > tr')
  for i in [0...GUESS_SIZE]
    $(rows[guess_num].children[i]).addClass('activeguess')

  make_activeguess_droppable()

make_activeguess_droppable = ->

  $('.guess .activeguess').droppable(
    drop: (event, ui) ->
      drop_color =  $(ui.draggable).css('background-color')
      $(this).css('background-color', drop_color)
      $(this).attr('data', $(ui.draggable).attr('data'))
  )


get_guess = (guess_num) ->
  guess = []
  rows = $('.board > tbody > tr')
  for i in [0...GUESS_SIZE]
    guess.push($(rows[guess_num].children[i]).attr('data'))

  return guess


is_valid_guess = (guess) ->
  return not _.contains(guess, undefined)


display_score = (score, guess_num) ->
  for i in [0...GUESS_SIZE]
    $('.score')
      .eq(guess_num)
      .find('td')
      .eq(i)
      .css('background-color', SCORE_MAP[score[i]])


$ ->

  target = generate_target(COLORS, GUESS_SIZE)
  console.log(target)
  guess_num = 0
  update_activeguess(guess_num)

  for color in COLORS
    $('<div/>', {style: "background-color:#{color}"})
      .attr('data', color)
      .appendTo('.colors')

  $('.colors > div').draggable({helper: 'clone'})

  $('.submit').on 'click', =>
    guess = get_guess(guess_num)
    if is_valid_guess(guess)
      score = score_guess(guess, target)
      console.log(target, guess, score)
      display_score(score, guess_num)
      guess_num += 1
      update_activeguess(guess_num)
