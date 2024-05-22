module Chess
  module Pieces
    abstract class Piece
      getter color

      def initialize(@color : Symbol)
        raise "color must be white or black" unless [:white, :black].includes? @color
      end

      def black?
        @color == :black
      end

      def white?
        @color == :white
      end

      def empty?
        @color == :empty
      end

      abstract def to_s(io : IO) : Nil

      abstract def available_moves(board : Board, coord : Board::Coord) : Array(Board::Coord)
    end
  end
end
