
require "./piece"

module Chess
  module Pieces
    class Rook < Piece
      def to_s(io : IO) : Nil
        io << (@color == :white ? "♖" : "♜")
      end

      def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
        moves = [] of Board::Coord

        # check left
        candidate_coord = Board::Coord.new(coord.x-1, coord.y)
        while candidate_coord.valid?
          if board[candidate_coord].empty?
            moves << candidate_coord
          elsif board[candidate_coord].color != self.color
            moves << candidate_coord
            break
          else
            break
          end

          candidate_coord = Board::Coord.new(candidate_coord.x-1, candidate_coord.y)
        end

        # check right
        candidate_coord = Board::Coord.new(coord.x+1, coord.y)
        while candidate_coord.valid?
          if board[candidate_coord].empty?
            moves << candidate_coord
          elsif board[candidate_coord].color != self.color
            moves << candidate_coord
            break
          else
            break
          end

          candidate_coord = Board::Coord.new(candidate_coord.x+1, candidate_coord.y)
        end

        # check up
        candidate_coord = Board::Coord.new(coord.x, coord.y+1)
        while candidate_coord.valid?
          if board[candidate_coord].empty?
            moves << candidate_coord
          elsif board[candidate_coord].color != self.color
            moves << candidate_coord
            break
          else
            break
          end

          candidate_coord = Board::Coord.new(candidate_coord.x, candidate_coord.y+1)
        end

        # check down
        candidate_coord = Board::Coord.new(coord.x, coord.y-1)
        while candidate_coord.valid?
          if board[candidate_coord].empty?
            moves << candidate_coord
          elsif board[candidate_coord].color != self.color
            moves << candidate_coord
            break
          else
            break
          end

          candidate_coord = Board::Coord.new(candidate_coord.x, candidate_coord.y-1)
        end

        moves
      end

    end
  end
end
