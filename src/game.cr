module Chess
  class Game
    getter board : Board
    getter state : Symbol
    getter action : Symbol
    getter turn : Int32

    def initialize
      @board = Board.new
      @state = :in_progress   # create enum
      @action = :white
      @turn = 1
    end

    def in_progress?
      state == :in_progress || state == :check
    end

    def over?
      state == :over
    end

    def make_move(move : String)
      departure_coord, target_coord = parse_move(move)

      piece = @board[departure_coord]

      raise "invaid piece" unless piece.color == @action
      raise "invalid target" unless @board.available_moves(departure_coord).includes? target_coord

      captured_piece = @board.apply_move(departure_coord, target_coord)

      # If player is in check, see if they've gotten out of it
      # if not, rollback + raise
      if state == :check && @board.in_check?(@action)
        # rollback
        raise "must move out of check"
      end
      
      # if player is not in check, see if they've gotten themselves into it
      # If so, rollback + raise
      if state != :check && @board.in_check?(@action)
        # rollback
        raise "move will put own King in check"
      end

      update_state
      update_action
    end

    def parse_move(move : String) : Tuple(Board::Coord, Board::Coord)
      {Board::Coord.new(move[0..1]), Board::Coord.new(move[2..3])}
    end

    def update_state
      @state = :in_progress

      if (action == :white && board.in_check?(:black)) ||
        (action == :black && board.in_check?(:white))
        @state = :check
      end

      # TODO: evaluate if also in checkmate
    end

    def update_action
      @action == :white ? (@action = :black) : (@action = :white)
    end

    def rollback_move(move : String, captured_piece : Pieces::Piece)
      departure_coord, target_coord = parse_move(move)
      @board[departure_coord] = @board[target_coord]
      @board[target_coord] = captured_piece
    end
  end
end
