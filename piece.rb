require './board.rb'
require 'debugger'

# red stats at 7, black starts at 0

class InvalidMoveError < ArgumentError
end

class Piece

	attr_accessor :color, :is_king, :pos, :board, :disp_char

	def initialize(color, pos, board, is_king = false)
		@color = color
		@pos = pos
		@board = board
		@is_king = is_king
		@disp_char = color.to_s.chars.first
		if is_king
			@disp_char + 'k'
		end

		board.add_piece(self, pos)
	end

	def subtract_moves(pos1, pos2)
		[pos1[0] - pos2[0], pos1[1] - pos2[1]]
	end

	def get_move_type(pos1, pos2)
		if subtract_moves(pos1, pos2).all? { |dif| dif.abs == 1 }
				:slide
			else
				:jump
			end
	end

	def perform_jump(move_to)
		jump_diffs = move_diffs.select do |diff|
			diff.all? { |coord| coord.abs == 2 }
		end

		jump_poses = jump_diffs.map do |diff|
			[@pos[0] + diff[0], @pos[1] + diff[1]]
		end

		return false unless jump_poses.include?(move_to)
		# p "jump_pos valid"

		jumped_pos_x = (move_to[0] - @pos[0]) / 2 + @pos[0]
		jumped_pos_y = (move_to[1] - @pos[1]) / 2 + @pos[1]
		jumped_pos = [jumped_pos_x, jumped_pos_y]

		return false if @board.empty?(jumped_pos)	#no piece to jump
		# p "piece to jump"

		return false if @board[jumped_pos].color == @color
		# p "opponent exists in spot"

		# remove opponent piece
		@board.remove_piece(@board[jumped_pos], jumped_pos)
		@board.move_piece(self, move_to)
		maybe_promote


		true	
	end

	def perform_slide(move_to)
		slide_diffs = move_diffs.select do |diff|
			diff.all? { |coord| coord.abs == 1 }
		end

		slide_poses = slide_diffs.map do |diff|
			[@pos[0] + diff[0], @pos[1] + diff[1]]
		end

		if slide_poses.include?(move_to)
			@board.move_piece(self, move_to)
			# p @pos
			maybe_promote
			true
		else
			false
		end
	end

	def maybe_promote
		promote_square = (@color == :red ? 0 : 7)
		if @pos[0] == promote_square
			puts "Piece promoted to King"
			self.is_king = true
			self.disp_char.upcase!
		end
	end

	RED_MOVES = [[-1, -1], [-1, 1], [-2, -2], [-2, 2]]
	BLACK_MOVES = [[1, -1], [1, 1], [2, -2], [2, 2]]
	KING_MOVES = RED_MOVES + BLACK_MOVES

	def move_diffs
		
		move_diffs = all_move_diffs

		valid_diffs = []

		move_diffs.each do |diff|
			new_pos = [@pos[0] + diff[0], @pos[1] + diff[1]]

			if @board.on_board?(new_pos) && @board.empty?(new_pos)
				valid_diffs << diff
			end
		end

		valid_diffs
	end

	def all_move_diffs
		if self.is_king == false
			if self.color == :red
				move_diffs = RED_MOVES
			elsif self.color == :black
				move_diffs = BLACK_MOVES
			end
		else # self.is_king == true
			move_diffs = KING_MOVES
		end
	end

	def perform_moves!(move_sequence)
		#move_sequence is like: [pos2, pos3, pos4, pos5]
		if move_sequence.nil? || move_sequence.empty?
			raise InvalidMoveError.new('The move sequence is empty')
		end

		(0...move_sequence.length).each do |i|
			is_successful = false

			move_type = get_move_type(@pos, move_sequence[i])
			if move_type == :slide
				is_successful = perform_slide(move_sequence[i])
			elsif move_type == :jump
				is_successful = perform_jump(move_sequence[i])
			end

			if is_successful == false
				raise InvalidMoveError.new("The move sequence was incorrect")
			end

			#prevent users from sliding after jumping
			if i < move_sequence.length - 1
				# @board.display
				next_move = get_move_type(@pos, move_sequence[i + 1])
				raise InvalidMoveError.new("Only first move can be a slide") if next_move == :slide
			end
		end
		true
	end

	def perform_moves(move_sequence)
		if valid_move_seq?(move_sequence)
			perform_moves!(move_sequence)
		else
			raise InvalidMoveError.new("Returned from perform_moves")
		end
	end

	def valid_move_seq?(move_sequence)
		start_pos = @pos
		new_board = @board.dup
		new_piece = new_board[start_pos]

		begin
			new_piece.perform_moves!(move_sequence)
		rescue => e
			puts e
			false
		else
			true
		end
	end

end



if __FILE__ == $PROGRAM_NAME
	begin
		puts "\n\n\n\n\n\n"
		b = Board.new()
		piece = Piece.new(:black, [1, 1], b)
		p2 = Piece.new(:red, [2, 2], b)
		p3 = Piece.new(:red, [4, 2], b)
		b.display
		puts "\n\n"

		move_sequence = [[3, 3], [5, 2]]
		# p piece.valid_move_seq?(move_sequence)
		piece.perform_moves(move_sequence)
	rescue => e
		puts e
	ensure
		b.display
	end
	# p3 = Piece.new(:black, [1, 3], b)
	# # p piece
	# # p piece.move_diffs
	# puts "\n\n"
	# p piece.perform_slide([2, 0])
	# # p p2.perform_jump([0, 4])
	# b.display
	# puts "is king? #{p2.is_king}"
	# p piece.is_king
	# p piece.perform_jump([3, 3])
																			# p piece.perform_slide([2, 0])
	# p piece.perform_jump([0,3])
	# puts "\n\n"
	# b.display
	# piece.perform_slide([10,10])
	# p piece.pos
	# p p2.pos
	# p piece
	# p p2
	# move_pair = [[0,-1],[1,-2]]
	# p piece.get_move_type(move_pair)
end

