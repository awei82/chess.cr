require "./piece"

module Chess
  module Pieces
    # special piece to represent empty spaces on the board.
    class NilPiece < Piece
      def to_s(io : IO) : Nil
        io << ""
      end

      def initialize
        @color = :empty
      end

      def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
        raise "NilPiece cannot make any moves."
      end
    end
  end
end
