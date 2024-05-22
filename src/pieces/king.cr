require "./piece"

module Chess
  module Pieces
    class King < Piece
      def to_s(io : IO) : Nil
        io << (@color == :white ? "♔" : "♚")
      end

      def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
        moves = [] of Board::Coord

        candidate_coords = [
          Board::Coord.new(coord.x-1, coord.y-1),
          Board::Coord.new(coord.x-1, coord.y),
          Board::Coord.new(coord.x-1, coord.y+1),
          Board::Coord.new(coord.x, coord.y-1),
          Board::Coord.new(coord.x, coord.y+1),
          Board::Coord.new(coord.x+1, coord.y-1),
          Board::Coord.new(coord.x+1, coord.y),
          Board::Coord.new(coord.x+1, coord.y+1),
        ]

        candidate_coords.each do |candidate_coord|
          if candidate_coord.valid? && board[candidate_coord].color != self.color
            moves << candidate_coord
          end
        end

        # TODO: implement castling

        moves
      end
    end
  end
end
