class Board

	attr_accessor :rows

	def initialize(add_pieces = true)
		@rows = Array.new(8) { Array.new(8, nil) }

		# if add_pieces
			
		# end
	end

	def [](pos)
		i, j = pos
		@rows[i][j]
	end

	def []=(pos, piece)
		# raise "invalid pos" unless valid_pos?(pos)

		i, j = pos
    @rows[i][j] = piece
  end

  def empty?(pos)
  	return true if self[pos].nil?
  	false
  end

  def on_board?(pos)
  	pos.all? { |coord| (0..7).cover?(coord) }
  end

  def display
  	(0..7).each do |r|
  		(0..7).each do |c|
  			if self[[r, c]].nil?
  				print ". "
  			else
  				print "#{self[[r, c]].disp_char} "
  			end
  		end
  		print "\n"
  	end
  end

  def add_piece(piece, pos)
  	raise "position not empty" unless empty?(pos)

  	self[pos] = piece
  end

  def remove_piece(piece, pos)
  	raise "no piece to remove" if empty?(pos)

  	self[pos] = nil
  end

  def move_piece(piece, pos)
  	raise "no piece to move" if empty?(piece.pos)
  	raise "position not empty" unless empty?(pos)

  	self[piece.pos] = nil
  	self[pos] = piece
  	piece.pos = pos
  end
end

# b = Board.new
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