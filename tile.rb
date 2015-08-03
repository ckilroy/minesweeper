class Tile
  attr_accessor :revealed
  attr_reader :pos, :board

  def initialize(board, has_bomb, pos)
    @revealed = false
    @has_bomb = has_bomb
    @board = board
    @pos = pos
  end

  def reveal! # should this have exclamation point?
    self.revealed = true
  end

  def neighbors
    neighbors = []
    differences = [ [ 0, 1],
                    [ 1, 1],
                    [ 1, 0],
                    [ 1,-1],
                    [ 0,-1],
                    [-1,-1],
                    [-1, 0],
                    [-1, 1] ]

    differences.each do |difference|
      neighbor_pos = pos[0] + difference[0], pos[1] + difference[1]
      neighbors << board[neighbor_pos] if board.on_board?(neighbor_pos)
    end

    neighbors
  end
end
