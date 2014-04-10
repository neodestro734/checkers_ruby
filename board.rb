class Board

	attr_accessor :rows

	def initialize(filled = true)
		@rows = Array.new(8) { Array.new(8, 'x') }
	end

	def [](x, y)
		#these are swapped because rows (y) come before columns (x)
		# x, y = pos
		# @rows[7-y][x]
		@rows[x][y]
	end

	def []=(x, y, piece)
		# raise "invalid pos" unless valid_pos?(pos)

		#these are swapped because rows (y) come before columns (x)
    # x, y = pos
    @rows[x][y] = piece
  end

  def display
  	(0..7).each do |r|
  		(0..7).each do |c|
  			# pos = [r, c]
  			# unless self.rows[7-c][r].nil?
  				print "#{self[r, c]} " #if self[r, c].nil?
  			# end
  		end
  		print "\n"
  	end
  end

end

b = Board.new
b.display
puts "\n\n"
b[0, 0] = 'a'
b[5, 1] = 'f'
b.display