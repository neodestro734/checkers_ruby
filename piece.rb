require './board.rb'
require 'debugger'

class Piece

	attr_accessor :color, :is_king, :pos, :board, :disp_char

	def initialize(color, pos, board, is_king = false)
		@color = color
		@pos = pos
		@board = board
		@is_king = is_king
		@disp_char = 'P'

		board.add_piece(self, pos)
	end

	def perform_jump(move_to)

	end

	def perform_slide(move_to)
		# valid_moves = move_diffs.select { |diff| self.pos}
	end

	RED_MOVES = [[-1, -1], [-1, 1], [-2, -2], [-2, 2]]
	BLACK_MOVES = [[1, -1], [1, 1], [2, -2], [2, 2]]
	KING_MOVES = RED_MOVES + BLACK_MOVES

	# private
	def move_diffs
		move_diffs = []

		if self.is_king == false
			if self.color == :red
				move_diffs = RED_MOVES
			elsif self.color == :black
				move_diffs = BLACK_MOVES
			end
		else # self.is_king == true
			move_diffs = KING_MOVES
		end

		valid_diffs = []

		move_diffs.each do |diff|
			new_pos = [@pos[0] + diff[0], @pos[1] + diff[1]]

			if @board.on_board?(new_pos) && @board.empty?(new_pos)
				valid_diffs << diff
			end
		end

		valid_diffs
	end

end

b = Board.new()
piece = Piece.new(:black, [1, 1], b)
p2 = Piece.new(:red, [2, 2], b)
# p piece
piece.move_diffs
b.display
# p piece.pos
# p p2.pos
# p piece
# p p2