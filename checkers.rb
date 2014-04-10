require './board.rb'
require './piece.rb'
require 'debugger'

class Checkers

	def initialize
		@board = Board.new(true)
		@player1 = HumanPlayer.new(:red)
		@player2 = HumanPlayer.new(:black)

	end

	def run
		puts "\n\nWelcome to checkers!!\n"
		player = @player1 #red
		loop do
			@board.display

			piece_to_move = player.get_piece_to_move(@board)

			# user_input = player.get_user_input
			# parsed_input = parse_input(user_input)

			# next unless piece_to_move.valid_move_seq?(parse_input)
			# piece_to_move.perform_moves(move_sequence)
			# p piece_to_move.pos unless piece_to_move.nil?
			# p player.color
			player = (player.color == :red ? @player2 : @player1)
		end

		def parse_input(user_input)
			user_input
		end

		def is_valid_move_sequence?(move_sequence)

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
			puts 'Please enter a piece to move by its board coordinates (0,0)'
			puts 'is in the upper left hand corner:'
			piece_arr = gets.chomp.split(',')
			piece_spot = piece_arr.map(&:to_i)
			# debugger
			# p piece_spot
			# # p board[piece_spot]
			# p board[piece_spot].color
		rescue => e
			puts e
			retry
		end
		board[piece_spot]
	end

	def get_user_input
		begin
			puts 'Please enter a move sequence in this format: [[2,2],[4,4]]'
			user_input = gets.chomp
		rescue
			retry
		end
		user_input
	end

end



if __FILE__ == $PROGRAM_NAME
	c = Checkers.new
	c.run
end