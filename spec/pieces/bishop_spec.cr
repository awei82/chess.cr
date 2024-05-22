require "../spec_helper"

describe Chess::Pieces::Bishop do
  describe "#available_moves" do
    it "can move across the board" do
      b = Board.new
      b.clear_board
      bishop_coord = Board::Coord.new("h8")
      b[bishop_coord] = Pieces::Bishop.new(:white)

      available_moves = b.available_moves(bishop_coord)
      available_moves.size.should eq(7)
      available_moves.should contain(Board::Coord.new("a1"))
    end

    it "can move in all 4 directions" do
      b = Board.new
      b.clear_board
      bishop_coord = Board::Coord.new("d4")
      b[bishop_coord] = Pieces::Bishop.new(:white)

      available_moves = b.available_moves(bishop_coord)
      available_moves.size.should eq(13)
      available_moves.should contain(Board::Coord.new("a7"))
      available_moves.should contain(Board::Coord.new("h8"))
      available_moves.should contain(Board::Coord.new("a1"))
      available_moves.should contain(Board::Coord.new("g1"))
    end

    it "is blocked by friendly pieces" do
      b = Board.new
      b.clear_board
      bishop_coord = Board::Coord.new("a8")
      b[bishop_coord] = Pieces::Bishop.new(:white)
      b["e4"] = Pieces::Pawn.new(:white)

      available_moves = b.available_moves(bishop_coord)
      available_moves.should_not contain(Board::Coord.new("e4"))
      available_moves.should_not contain(Board::Coord.new("f3"))
    end

    it "is blocked by, but can capture, opponent's pieces" do
      b = Board.new
      b.clear_board
      bishop_coord = Board::Coord.new("d6")
      b[bishop_coord] = Pieces::Bishop.new(:white)
      b["b4"] = Pieces::Pawn.new(:black)

      available_moves = b.available_moves(bishop_coord)
      available_moves.should contain(Board::Coord.new("b4"))
      available_moves.should_not contain(Board::Coord.new("a3"))
    end
  end
end
