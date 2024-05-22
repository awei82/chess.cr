require "./piece"

module Chess
  module Pieces
    class Bishop < Piece
      def to_s(io : IO) : Nil
        io << (@color == :white ? "♗" : "♝")
      end

      def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
        moves = [] of Board::Coord

         # check up-left
         candidate_coord = Board::Coord.new(coord.x-1, coord.y+1)
         while candidate_coord.valid?
           if board[candidate_coord].empty?
             moves << candidate_coord
           elsif board[candidate_coord].color != self.color
             moves << candidate_coord
             break
           else
             break
           end
 
           candidate_coord = Board::Coord.new(candidate_coord.x-1, candidate_coord.y+1)
         end
 
         # check up-right
         candidate_coord = Board::Coord.new(coord.x+1, coord.y+1)
         while candidate_coord.valid?
           if board[candidate_coord].empty?
             moves << candidate_coord
           elsif board[candidate_coord].color != self.color
             moves << candidate_coord
             break
           else
             break
           end
 
           candidate_coord = Board::Coord.new(candidate_coord.x+1, candidate_coord.y+1)
         end
 
         # check down-left
         candidate_coord = Board::Coord.new(coord.x-1, coord.y-1)
         while candidate_coord.valid?
           if board[candidate_coord].empty?
             moves << candidate_coord
           elsif board[candidate_coord].color != self.color
             moves << candidate_coord
             break
           else
             break
           end
 
           candidate_coord = Board::Coord.new(candidate_coord.x-1, candidate_coord.y-1)
         end
 
         # check down-right
         candidate_coord = Board::Coord.new(coord.x+1, coord.y-1)
         while candidate_coord.valid?
           if board[candidate_coord].empty?
             moves << candidate_coord
           elsif board[candidate_coord].color != self.color
             moves << candidate_coord
             break
           else
             break
           end
 
           candidate_coord = Board::Coord.new(candidate_coord.x+1, candidate_coord.y-1)
         end
        moves
      end
    end
  end
end
