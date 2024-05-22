
module Chess
  module Cli
    extend self

    ANSI_RESET = "\033[0m"
    ANSI_DARK_BACKGROUND = "\033[45m"
    ANSI_LIGHT_BACKGROUND = "\033[47m"
    ANSI_BLACK_TEXT = "\033[30m"


    def print_board(board : Board)
      puts "  a b c d e f g h"
      puts "8 " + rank_string(board, '8')
      puts "7 " + rank_string(board, '7')
      puts "6 " + rank_string(board, '6')
      puts "5 " + rank_string(board, '5')
      puts "4 " + rank_string(board, '4')
      puts "3 " + rank_string(board, '3')
      puts "2 " + rank_string(board, '2')
      puts "1 " + rank_string(board, '1')
    end

    def rank_string(board : Board, rank : Char)
      y = Board::Coord.rank_to_y rank
      rank_squares = (0..7).map {|x| board[Board::Coord.new(x, y)] }
      colorize_background(rank_squares, rank).join
    end

    def colorize_background(rank : Array(Pieces::Piece), rank_num : Char)
      if rank_num.to_i.even?
        rank.map_with_index do |piece, i|
          color = i.even? ? ANSI_LIGHT_BACKGROUND : ANSI_DARK_BACKGROUND
          piece_str = piece.empty? ? " " : piece.to_s
          color + ANSI_BLACK_TEXT + piece_str + " " + ANSI_RESET + ANSI_RESET
        end
      else
        rank.map_with_index do |piece, i|
          color = i.even? ? ANSI_DARK_BACKGROUND : ANSI_LIGHT_BACKGROUND
          piece_str = piece.empty? ? " " : piece.to_s
          color + ANSI_BLACK_TEXT + piece_str + " " + ANSI_RESET + ANSI_RESET
        end
      end
    end
  end
end
