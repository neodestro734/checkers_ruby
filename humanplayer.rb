require 'colorize'

class HumanPlayer

	attr_accessor :color

	def initialize(color)
		@color = color
	end

	def get_piece_to_move(board)
		begin
			print "\n\nPlease enter a piece to move"
			print "\nby its board coordinates.\n"
			pos_arr = gets.chomp.chars

			if pos_arr.length > 2
				raise ArgumentError.new("\nToo many characters! Should\nbe in format: \"A3\"")
			end

			piece_spot = parse_char_spot(pos_arr)
			if board[piece_spot].nil?
				raise ArgumentError.new("\nThat spot is empty!")
			end
		rescue => e
			print e.message.colorize(:red)
			retry
		end

		board[piece_spot]
	end

	def parse_char_spot(pos_arr)
		char_map = { 	'a' => 0,
                  'b' => 1,
                  'c' => 2,
                  'd' => 3,
                  'e' => 4,
                  'f' => 5,
                  'g' => 6,
                  'h' => 7 }
     i = 8 - pos_arr[1].to_i
     j = char_map[pos_arr[0].downcase]

     [i, j]
	end

	def get_move_sequence
		move_seq = []
		begin
			print "\nPlease enter a move sequence"
			print "\nin this format: \"c5 e7\"\n"
			move_seq_arr = gets.chomp.split(' ')

			move_seq_arr.each do |string_pos|
				piece_spot = parse_char_spot(string_pos)
				move_seq << piece_spot
			end
		rescue => e
			puts e
			retry
		end
		move_seq
	end

end