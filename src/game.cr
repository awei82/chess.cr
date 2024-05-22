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
      state == :in_progress
    end

    def over?
      state == :over
    end

    def make_move(move : String)
      departure_coord, target_coord = parse_move(move)

      piece = @board[departure_coord]

      raise "invaid piece" unless piece.color == @action
      raise "invalid target" unless @board.available_moves(departure_coord).includes? target_coord

      @board.apply_move(departure_coord, target_coord)

      update_state
      update_action
    end

    def parse_move(move : String) : Tuple(Board::Coord, Board::Coord)
      {Board::Coord.new(move[0..1]), Board::Coord.new(move[2..3])}
    end

    def update_state
      # TODO
    end

    def update_action
      @action == :white ? (@action = :black) : (@action = :white)
    end
  end
end
