require "./piece"

module Chess
  module Pieces
    class Queen < Piece
      def to_s(io : IO) : Nil
        io << (@color == :white ? "♕" : "♛")
      end

      def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
        rook = Rook.new(color)
        bishop = Bishop.new(color)

        rook.available_moves(board, coord) + bishop.available_moves(board, coord)
      end
    end  
  end
end
