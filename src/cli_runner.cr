require "./chess"
require "./cli"

module Chess
  module CliRunner
    extend self

    def run
      game = Game.new
    
      while game.in_progress?
        Cli.print_board(game.board)

        valid_move = false
        while !valid_move
          print "#{game.action.to_s.capitalize}'s turn: "
          move = gets

          begin
            game.make_move(move.to_s)
            valid_move = true
          rescue
            puts "Invalid move. Try again."
            move_valid = false
          end
        end

        puts ""
      end
    end
  end
end

Chess::CliRunner.run