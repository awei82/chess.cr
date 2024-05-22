require "../spec_helper"

describe Chess::Pieces::King do
  describe "#available_moves" do
    it "can move in all directions" do
      b = Board.new
      b.clear_board
      king_coord = Board::Coord.new("c3")
      b[king_coord] = Pieces::King.new(:white)

      # can capture
      b["d4"] = Pieces::Pawn.new(:black)

      expected_moves = Set.new([
        Board::Coord.new("b4"),
        Board::Coord.new("c4"),
        Board::Coord.new("d4"),
        Board::Coord.new("b3"),
        Board::Coord.new("d3"),
        Board::Coord.new("b2"),
        Board::Coord.new("c2"),
        Board::Coord.new("d2"),
      ])
      Set.new(b.available_moves(king_coord)).should eq(expected_moves)
    end

    it "is blocked by friendly pieces" do
      b = Board.new
      b.clear_board
      king_coord = Board::Coord.new("a8")
      b[king_coord] = Pieces::King.new(:white)
      b["a7"] = Pieces::Pawn.new(:white)

      available_moves = b.available_moves(king_coord)
      available_moves.should_not contain(Board::Coord.new("a7"))
    end

    # TODO: Tests for castling
  end
end
