require "../spec_helper"

describe Chess::Pieces::Knight do
  describe "#available_moves" do
    it "moves in L-shape in all 8 directions" do
      b = Board.new
      knight_coord = Board::Coord.new("f5")
      b[knight_coord] = Pieces::Knight.new(:white)

      # can move forward if space is unoccupied
      expected_moves = Set.new([
        Board::Coord.new("e7"),
        Board::Coord.new("g7"),
        Board::Coord.new("d6"),
        Board::Coord.new("d4"),
        Board::Coord.new("e3"),
        Board::Coord.new("g3"),
        Board::Coord.new("h6"),
        Board::Coord.new("h4"),
      ])
      Set.new(b.available_moves(knight_coord)).should eq(expected_moves)

      # cannot move out of bounds
      knight_coord = Board::Coord.new("g1")
      expected_moves = Set.new([
        Board::Coord.new("f3"),
        Board::Coord.new("h3"),
      ])
      Set.new(b.available_moves(knight_coord)).should eq(expected_moves)
    end

    it "will not move to friendly occupied space" do
      b = Board.new
      knight_coord = Board::Coord.new("d4")
      b[knight_coord] = Pieces::Knight.new(:white)

      available_moves = b.available_moves(knight_coord)
      available_moves.should_not contain(Board::Coord.new("c2"))
      available_moves.should_not contain(Board::Coord.new("e2"))
    end
  end
end
