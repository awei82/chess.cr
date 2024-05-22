require "./pieces"

module Chess
  class Board
    struct Coord
      getter x, y : Int32
      getter file, rank : Char

      def initialize(@x : Int32, @y : Int32)
        @rank = '1' + y
        @file = 'a' + x
      end

      def initialize(algebraic_coord : String)
        @file, @rank = algebraic_coord.chars.map &.downcase
        raise "invalid coordinate" unless FILES.includes?(file) && RANKS.includes?(rank)
  
        @x = Coord.file_to_x(file)
        @y = Coord.rank_to_y(rank)
      end

      def valid?
        x >= 0 && x < 8 && y >= 0 && y < 8
      end

      # # returns the coordinate of a given piece
      # def find(piece : Pieces::Piece) : Coord?
      #   @grid.each_with_index do |row, x|
      #     row.each_with_index do |square, y|
      #       if square == piece
      #         return Coord.new(x, y)
      #       end
      #     end
      #   end
      #   nil
      # end


      def algebraic_coord
        {file, rank}.join
      end

      # File a -> 0, b -> 1, etc.
      def self.file_to_x(file : Char) : Int32
        file - 'a'
      end

      # Rank 1 -> 0, 2 -> 1, etc.
      def self.rank_to_y(rank : Char) : Int32
        rank - '1'
      end
    end


    FILES = Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
    RANKS = Set.new(['1', '2', '3', '4', '5', '6', '7', '8'])

    @grid : Array(Array(Pieces::Piece))

    def initialize
      @grid = Array.new(8) { Array(Pieces::Piece).new(8, Pieces::NilPiece.new) }
      setup_board
    end

    def [](coord : Coord)
      @grid[coord.x][coord.y]
    end

    def []=(coord : Coord, piece : Pieces::Piece)
      @grid[coord.x][coord.y] = piece
    end


    def [](algebraic_coord : String)
      self[Coord.new(algebraic_coord)]
    end

    def []=(algebraic_coord : String, piece : Pieces::Piece)
      self[Coord.new(algebraic_coord)] = piece
    end

    def setup_board
      @grid = Array.new(8) { Array(Pieces::Piece).new(8, Pieces::NilPiece.new) }

      ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"].each { |c| self[c] = Pieces::Pawn.new(:black) }
      ["a8", "h8"].each { |c| self[c] = Pieces::Rook.new(:black)}
      ["b8", "g8"].each { |c| self[c] = Pieces::Knight.new(:black)}
      ["c8", "f8"].each { |c| self[c] = Pieces::Bishop.new(:black)}
      self["d8"] = Pieces::Queen.new(:black)
      self["e8"] = Pieces::King.new(:black)

      ["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"].each { |c| self[c] = Pieces::Pawn.new(:white) }
      ["a1", "h1"].each { |c| self[c] = Pieces::Rook.new(:white)}
      ["b1", "g1"].each { |c| self[c] = Pieces::Knight.new(:white)}
      ["c1", "f1"].each { |c| self[c] = Pieces::Bishop.new(:white)}
      self["e1"] = Pieces::Queen.new(:white)
      self["d1"] = Pieces::King.new(:white)
    end

    def clear_board
      @grid = Array.new(8) { Array(Pieces::Piece).new(8, Pieces::NilPiece.new) }
    end

    def available_moves(coord : Coord)
      self[coord].available_moves(self, coord)
    end

    def available_moves(algebraic_coord : String) : Array(Pieces::Piece)
      coord = Coord.new(algebraic_coord)
      self[coord].available_moves(self, coord)
    end

    # Applies the move and returns the captured piece (or NilPiece if none captured)
    def apply_move(departure_coord : Coord, target_coord : Coord) : Pieces::Piece
      raise "invalid move" unless self.available_moves(departure_coord).includes? target_coord
      
      moving_piece = self[departure_coord]
      target_piece = self[target_coord]

      self[target_coord] = self[departure_coord]
      self[departure_coord] = Pieces::NilPiece.new

      target_piece

      # TODO: handle castling, pawn promotion
    end

    def apply_move(departure_coord : String, target_coord : String)
      self.apply_move(Coord.new(departure_coord), Coord.new(target_coord))
    end

    def pieces(color : Symbol) : Array(Pieces::Piece)
      pieces = [] of Pieces::Piece
      @grid.each do |row|
        row.each do |piece|
          if piece.color == color
            pieces << piece
          end
        end
      end
      pieces
    end

    def in_check?(color : Symbol) : Bool
      all_moves = [] of Coord
      opposing_color = color == :black ? :white : :black
      each_coord do |coord|
        if self[coord].color == opposing_color
          all_moves += available_moves(coord)
        end
      end

      king_coord = Coord.new(-1,-1)
      each_coord do |coord|
        if self.[coord].is_a?(Pieces::King) && self.[coord].color == color
          king_coord = coord
          break
        end
      end

      all_moves.includes? king_coord
    end

    def each_coord(&)
      (0..7).each do |x|
        (0..7).each do |y|
          yield Coord.new(x,y)
        end
      end
    end
  end
end
