require './piece.rb'


class Board

	attr_reader :rows

	EVEN_ROW_SPOTS = [1, 3, 5, 7]
	ODD_ROW_SPOTS = [0, 2, 4, 6]

	def initialize(add_pieces = false)
		@rows = Array.new(8) { Array.new(8, nil) }

		if add_pieces
			add_black_pieces
			add_red_pieces
		end
	end

	def [](pos)
		i, j = pos
		@rows[i][j]
	end

	def []=(pos, piece)
		raise "invalid pos" unless on_board?(pos)

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
  		print ('  ' + (8 - r).to_s + ' ').colorize(:yellow)
  		(0..7).each do |c|
  			color = (r + c).even? ? :light_red : :light_black
  			if self[[r, c]].nil?
  				print "  ".colorize(:background => color)
  			else
  				print "#{self[[r, c]].disp_char} ".colorize(:background => color)
  			end
  		end
  		print "\n"
  	end
  	print '    A B C D E F G H'.colorize(:yellow)
  end

  def dup
  	pieces = self.rows.flatten.compact
  	new_board = Board.new(false)
  	
  	pieces.each do |piece|
  		piece.class.new(piece.color, piece.pos.dup, new_board, piece.is_king)
  	end

  	new_board
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

  

	#------------------------------ PRIVATE -------------------------------------
  private

	def add_black_pieces
		(0..2).each do |row|
			if row.even?
				EVEN_ROW_SPOTS.each do |col|
					Piece.new(:black, [row, col], self, false)
				end
			else
				ODD_ROW_SPOTS.each do |col|
					Piece.new(:black, [row, col], self, false)
				end
			end
		end
	end

	def add_red_pieces
		(5..7).each do |row|
			if row.even?
				EVEN_ROW_SPOTS.each do |col|
					Piece.new(:red, [row, col], self, false)
				end
			else
				ODD_ROW_SPOTS.each do |col|
					Piece.new(:red, [row, col], self, false)
				end
			end
		end
	end

end