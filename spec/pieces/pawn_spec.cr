require "../spec_helper"

describe Chess::Pieces::Pawn do
  describe "#available_moves" do
    describe "when white" do
      it "moves forward" do
        b = Board.new
        pawn_coord = Board::Coord.new("e3")
        b[pawn_coord] = Pieces::Pawn.new(:white)

        # can move forward if space is unoccupied
        b.available_moves(pawn_coord).should eq([Board::Coord.new("e4")])

        # cannot move forward if space is occupied
        b["e4"] = Pieces::Pawn.new(:white)
        b.available_moves(pawn_coord).should be_empty
        b["e4"] = Pieces::Pawn.new(:white)
        b.available_moves(pawn_coord).should be_empty
      end

      it "can attack diagonally" do
        b = Board.new
        pawn_coord = Board::Coord.new("e3")
        b[pawn_coord] = Pieces::Pawn.new(:white)

        # if opposing piece is diagonal, the move is available
        b["d4"] = Pieces::Pawn.new(:black)
        b["f4"] = Pieces::Pawn.new(:black)
        available_moves = b.available_moves(pawn_coord)
        available_moves.size.should eq(3)
        available_moves.should contain(Board::Coord.new("d4"))
        available_moves.should contain(Board::Coord.new("f4"))

        # else no
        b["d4"] = Pieces::Pawn.new(:white)
        b["f4"] = Pieces::NilPiece.new
        available_moves = b.available_moves(pawn_coord)
        available_moves.should_not contain(Board::Coord.new("d4"))
        available_moves.should_not contain(Board::Coord.new("f4"))
      end

      it "can move forward twice on start" do
        b = Board.new
        pawn_coord = Board::Coord.new("e2")
        b[pawn_coord] = Pieces::Pawn.new(:white)

        # can move forward if space is unoccupied
        available_moves = b.available_moves(pawn_coord)
        available_moves.size.should eq(2)
        available_moves.should contain(Board::Coord.new("e4"))

        # cannot move forward if space is occupied
        b["e4"] = Pieces::Pawn.new(:black)
        b.available_moves(pawn_coord).should_not contain(Board::Coord.new("e4"))
        b["e4"] = Pieces::Pawn.new(:white)
        b.available_moves(pawn_coord).should_not contain(Board::Coord.new("e4"))
      end
    end

    describe "when black" do
      it "moves forward" do
        b = Board.new
        pawn_coord = Board::Coord.new("c6")
        b[pawn_coord] = Pieces::Pawn.new(:black)

        # can move forward if space is unoccupied
        b.available_moves(pawn_coord).should eq([Board::Coord.new("c5")])

        # cannot move forward if space is occupied
        b["c5"] = Pieces::Pawn.new(:black)
        b.available_moves(pawn_coord).should be_empty
        b["c5"] = Pieces::Pawn.new(:white)
        b.available_moves(pawn_coord).should be_empty
      end

      it "can attack diagonally" do
        b = Board.new
        pawn_coord = Board::Coord.new("c6")
        b[pawn_coord] = Pieces::Pawn.new(:black)

        # if opposing piece is diagonal, the move is available
        b["b5"] = Pieces::Pawn.new(:white)
        b["d5"] = Pieces::Pawn.new(:white)
        available_moves = b.available_moves(pawn_coord)
        available_moves.size.should eq(3)
        available_moves.should contain(Board::Coord.new("b5"))
        available_moves.should contain(Board::Coord.new("d5"))

        # else no
        b["b5"] = Pieces::Pawn.new(:black)
        b["d5"] = Pieces::NilPiece.new
        available_moves = b.available_moves(pawn_coord)
        available_moves.should_not contain(Board::Coord.new("b5"))
        available_moves.should_not contain(Board::Coord.new("d5"))
      end

      it "can move forward twice on start" do
        b = Board.new
        pawn_coord = Board::Coord.new("c7")
        b[pawn_coord] = Pieces::Pawn.new(:black)

        # can move forward if space is unoccupied
        available_moves = b.available_moves(pawn_coord)
        available_moves.size.should eq(2)
        available_moves.should contain(Board::Coord.new("c5"))

        # cannot move forward if space is occupied
        b["c5"] = Pieces::Pawn.new(:black)
        b.available_moves(pawn_coord).should_not contain(Board::Coord.new("c5"))
        b["c5"] = Pieces::Pawn.new(:white)
        b.available_moves(pawn_coord).should_not contain(Board::Coord.new("c5"))
      end
    end
  end
end
