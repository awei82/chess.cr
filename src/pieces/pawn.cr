require "./piece"

module Chess
  module Pieces
    class Pawn < Piece
      def to_s(io : IO) : Nil
        io << (@color == :white ? "♙" : "♟︎")
      end

      def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
        moves = [] of Board::Coord

        if black?
          # first, check forward step
          # if coord is on board and not occupied, then it's valid
          candidate_coord = Board::Coord.new(coord.x, coord.y-1)
          if candidate_coord.valid? && board[candidate_coord].empty?
            moves << candidate_coord
          end

          # next check diagonals
          candidate_coord = Board::Coord.new(coord.x-1, coord.y-1)
          if candidate_coord.valid? && board[candidate_coord].white?
            moves << candidate_coord
          end

          candidate_coord = Board::Coord.new(coord.x+1, coord.y-1)
          if candidate_coord.valid? && board[candidate_coord].white?
            moves << candidate_coord
          end

          # if first move, also check jump move
          if coord.y == 6
            candidate_coord = Board::Coord.new(coord.x, coord.y-2)
            if candidate_coord.valid? && board[candidate_coord].empty?
              moves << candidate_coord
            end
          end
        else
          # first, check forward step
          # if coord is on board and not occupied, then it's valid
          candidate_coord = Board::Coord.new(coord.x, coord.y+1)
          if candidate_coord.valid? && board[candidate_coord].empty?
            moves << candidate_coord
          end

          # next check diagonals
          candidate_coord = Board::Coord.new(coord.x-1, coord.y+1)
          if candidate_coord.valid? && board[candidate_coord].black?
            moves << candidate_coord
          end

          candidate_coord = Board::Coord.new(coord.x+1, coord.y+1)
          if candidate_coord.valid? && board[candidate_coord].black?
            moves << candidate_coord
          end

          # if first move, also check jump move
          if coord.y == 1
            candidate_coord = Board::Coord.new(coord.x, coord.y+2)
            if candidate_coord.valid? && board[candidate_coord].empty?
              moves << candidate_coord
            end
          end

        end

        moves
      end
    end
  end
end
