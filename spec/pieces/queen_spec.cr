require "../spec_helper"

describe Chess::Pieces::Queen do
  describe "#available_moves" do
    it "can move in all directions" do
      b = Board.new
      b.clear_board
      queen_coord = Board::Coord.new("e4")
      b[queen_coord] = Pieces::Queen.new(:white)

      available_moves = b.available_moves(queen_coord)
      available_moves.size.should eq(27)
      available_moves.should contain(Board::Coord.new("h7"))
      available_moves.should contain(Board::Coord.new("h4"))
      available_moves.should contain(Board::Coord.new("h1"))
      available_moves.should contain(Board::Coord.new("e8"))
      available_moves.should contain(Board::Coord.new("e1"))
      available_moves.should contain(Board::Coord.new("a8"))
      available_moves.should contain(Board::Coord.new("a4"))
      available_moves.should contain(Board::Coord.new("b1"))
    end
  end
end
