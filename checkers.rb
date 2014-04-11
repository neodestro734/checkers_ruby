require './board.rb'
require './piece.rb'
require './humanplayer.rb'
require 'debugger'
require 'colorize'

class Checkers

	def initialize
		@board = Board.new(true)
		@player1 = HumanPlayer.new(:red)
		@player2 = HumanPlayer.new(:black)

	end

	def run
		# system "clear"
		# puts "\nWelcome to checkers!!"
		player = @player1 #red
		loop do
			system "clear"
			print "\nWelcome to checkers!!\n\n"
			# print "\nBrought to you by pingram\n\n"
			@board.display

			piece_to_move = player.get_piece_to_move(@board)

			if piece_to_move.color != player.color
				puts "\nYou must move your own piece!\n".colorize(:red)
				gets	# this allows us to continue when the user presses enter
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

if __FILE__ == $PROGRAM_NAME
	c = Checkers.new
	c.run
end