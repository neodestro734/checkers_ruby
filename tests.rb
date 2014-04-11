
# BOARD TESTS
# ---------------------------------------------

# b = Board.new(true)
# 	b.display
	# piece = Piece.new(:black, [1, 1], b)
	# p2 = Piece.new(:red, [2, 2], b)
	# p3 = Piece.new(:red, [4, 2], b)
	# puts "Board B:"
	# b.display
	# puts "\n\n"
	# puts "Board C:"
	# c = b.dup
	# c.display
	# p b[[1,1]].pos.object_id
	# p c[[1,1]].pos.object_id

	# b.move_piece(p3, [6,6])
	# b.display
	# puts "\n\n"
	# c.display


	# p b.on_board?([1,1])
	# p b.on_board?([7,7])
	# p b.on_board?([-1,1])
	# p b.on_board?([1,10])
	# p b.on_board?([10,1])
	# b.display
	# puts "\n\n"
	# b[[0, 0]] = 'a'
	# b[[5, 1]] = 'f'
	# b.display
	# p b.empty?([1,2])
	# p b.empty?([5,1])



# PIECE TESTS
# ---------------------------------------------

# begin
# 		puts "\n\n\n\n\n\n"
# 		b = Board.new()
# 		piece = Piece.new(:black, [1, 1], b)
# 		p2 = Piece.new(:red, [2, 2], b)
# 		p3 = Piece.new(:red, [4, 2], b)
# 		b.display
# 		puts "\n\n"

# 		move_sequence = [[3, 3], [5, 2]]
# 		# p piece.valid_move_seq?(move_sequence)
# 		piece.perform_moves(move_sequence)
# 	rescue => e
# 		puts e
# 	ensure
# 		b.display
# 	end
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