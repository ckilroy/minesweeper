class Tile
  attr_accessor :revealed, :flagged
  attr_reader :pos, :board, :has_bomb

  def initialize(board, has_bomb, pos)
    @revealed = false
    @has_bomb = has_bomb
    @board = board
    @pos = pos
    @flagged = false
  end

  def reveal! # should this have exclamation point?
    self.revealed = true unless flagged
  end

  def flag # what about this?
    self.flagged = true unless revealed
  end

  def unflag
    self.flagged = false
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

  def neighbor_bomb_count
    bomb_count = 0

    neighbors.each do |neighbor|
      bomb_count += 1 if neighbor.has_bomb
    end

    bomb_count
  end

  def has_bomb_neighbors?
    neighbor_bomb_count > 0
  end

  def reveal_until_fringe
    if has_bomb_neighbors?
      reveal!
      return
    end

    neighbors.each do |neighbor|
      reveal!
      neighbor.reveal_until_fringe unless neighbor.revealed
    end
  end

end
