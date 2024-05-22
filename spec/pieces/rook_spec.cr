require "../spec_helper"

describe Chess::Pieces::Rook do
  describe "#available_moves" do
    it "can move across the board" do
      b = Board.new
      b.clear_board
      rook_coord = Board::Coord.new("a1")
      b[rook_coord] = Pieces::Rook.new(:white)

      available_moves = b.available_moves(rook_coord)
      available_moves.size.should eq(14)
      available_moves.should contain(Board::Coord.new("a8"))
      available_moves.should contain(Board::Coord.new("h1"))
    end

    it "can move in all 4 directions" do
      b = Board.new
      b.clear_board
      rook_coord = Board::Coord.new("d4")
      b[rook_coord] = Pieces::Rook.new(:white)

      available_moves = b.available_moves(rook_coord)
      available_moves.size.should eq(14)
      available_moves.should contain(Board::Coord.new("d8"))
      available_moves.should contain(Board::Coord.new("a4"))
      available_moves.should contain(Board::Coord.new("h4"))
      available_moves.should contain(Board::Coord.new("d1"))
    end

    it "is blocked by friendly pieces" do
      b = Board.new
      b.clear_board
      rook_coord = Board::Coord.new("a1")
      b[rook_coord] = Pieces::Rook.new(:white)
      b["a6"] = Pieces::Pawn.new(:white)

      available_moves = b.available_moves(rook_coord)
      available_moves.should_not contain(Board::Coord.new("a6"))
      available_moves.should_not contain(Board::Coord.new("a7"))
    end

    it "is blocked by, but can capture, opponent's pieces" do
      b = Board.new
      b.clear_board
      rook_coord = Board::Coord.new("f5")
      b[rook_coord] = Pieces::Rook.new(:white)
      b["d5"] = Pieces::Pawn.new(:black)

      available_moves = b.available_moves(rook_coord)
      available_moves.should contain(Board::Coord.new("d5"))
      available_moves.should_not contain(Board::Coord.new("c5"))
    end
  end
end
