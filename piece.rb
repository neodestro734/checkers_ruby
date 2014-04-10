require './board.rb'
require 'debugger'

# red stats at 7, black starts at 0

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
		# valid_moves 
	end

	def perform_slide(move_to)
		slide_diffs = move_diffs.select do |diff|
			diff.all? { |coord| coord.abs == 1 }
		end

		slide_poses = slide_diffs.map do |diff|
			[@pos[0] + diff[0], @pos[1] + diff[1]]
		end

		return true if slide_poses.include?(move_to)
		false		
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
p2 = Piece.new(:black, [2, 2], b)
# p piece
# p piece.move_diffs
puts "\n\n"
# p p2.perform_slide([3, 3])
b.display
# piece.perform_slide([10,10])
# p piece.pos
# p p2.pos
# p piece
# p p2