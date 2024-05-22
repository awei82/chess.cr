require "./spec_helper"

describe Chess::Board do
  # TODO: Write tests

  describe "#in_check?" do
    it "correctly checks if king is in check" do
      b = Board.new
      b.in_check?(:white).should eq(false)
      b.in_check?(:black).should eq(false)

      b[Board::Coord.new("e2")] = Pieces::Pawn.new(:black)
      b.in_check?(:white).should eq(true)

      b[Board::Coord.new("e7")] = Pieces::Rook.new(:white)
      b.in_check?(:white).should eq(true)
    end
  end
end
