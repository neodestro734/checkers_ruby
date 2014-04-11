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
		player = @player1 #red
		loop do
			system "clear"
			print "\nWelcome to checkers!!\n\n"
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

			if red_wins?
				print "\n\nRED WON!!!\n\n\n"
				return
			elsif black_wins?
				print "\n\nBLACK WON!!!\n\n\n"
				return
			end
		end
	end

	def red_wins?
		@board.rows.flatten.compact.none? { |piece| piece.color == :black }
	end

	def black_wins?
		@board.rows.flatten.compact.none? { |piece| piece.color == :red }
	end

end

if __FILE__ == $PROGRAM_NAME
	c = Checkers.new
	c.run
end