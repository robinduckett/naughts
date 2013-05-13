class Cell
	constructor: ->
		@state = 'empty'

class Board
	constructor: () ->
		@board = new Array(9)

		for index in [0..9]
			@board[index] = new Cell()

		@finished = false
		@score()

	score: ->

	set_cell: (index, side) ->
		console.log @board

		if @board[index].state is "empty"
			@board[index].state = side

			return true
		else
			return false

class Naughts
	constructor: ->
		@board = new Board()

	move: (index) ->
		move = @board.set_cell(index, "crosses")

		if move
			@trigger "move", index, "crosses"
			@decide_move()
		else
			@trigger "invalid", index, "crosses"

_.extend Naughts::, Backbone.Events

module.exports = Naughts