require './board.rb'
require './piece.rb'
require 'debugger'
require 'colorize'

class Checkers

	def initialize
		@board = Board.new(true)
		@player1 = HumanPlayer.new(:red)
		@player2 = HumanPlayer.new(:black)

	end

	def run
		puts "\n\nWelcome to checkers!!"
		player = @player1 #red
		loop do
			print "\n"
			@board.display

			piece_to_move = player.get_piece_to_move(@board)

			if piece_to_move.color != player.color
				puts "\nYou must move your own piece!\n".colorize(:red)
				next
			end

			user_move_seq = player.get_move_sequence

			next unless piece_to_move.valid_move_seq?(user_move_seq)
			piece_to_move.perform_moves(user_move_seq)

			player = (player.color == :red ? @player2 : @player1)
		end

		def parse_input(user_input)
			user_input
		end

	end

end

class HumanPlayer

	attr_accessor :color

	def initialize(color)
		@color = color
	end

	def get_piece_to_move(board)
		begin
			puts "\n\nPlease enter a piece to move by its board coordinates."
			puts "(0,0) is in the upper left hand corner:\n\n"
			pos_arr = gets.chomp.chars
			piece_spot = parse_char_spot(pos_arr)
		rescue => e
			puts e
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
			puts "\nPlease enter a move sequence in this format: \"c5 e7\"\n\n"
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



if __FILE__ == $PROGRAM_NAME
	c = Checkers.new
	c.run
end