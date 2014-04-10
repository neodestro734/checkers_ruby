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
		puts "\n\nWelcome to checkers!!\n"
		player = @player1 #red
		loop do
			@board.display

			piece_to_move = player.get_piece_to_move(@board)
			if piece_to_move.color != player.color
				puts "You must move your own piece!".colorize(:red)
				next
			end

			# user_input = player.get_user_input
			# parsed_input = parse_input(user_input)
			user_move_seq = [player.get_move_sequence]
			next unless piece_to_move.valid_move_seq?(user_move_seq)
			piece_to_move.perform_moves(user_move_seq)
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
			puts 'Please enter a piece to move by its board coordinates.'
			puts '(0,0) is in the upper left hand corner:'
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

	def get_move_sequence
		move_seq = []
		begin
			puts 'Please enter a move sequence in this format: 2,2,4,4'
			move_seq_arr = gets.chomp.split(',')
			p move_seq_arr
			move_seq = move_seq_arr.map(&:to_i)
			p move_seq
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