class Tile
  DELTAS = [
    [ 0, 1],
    [ 1, 1],
    [ 1, 0],
    [ 1,-1],
    [ 0,-1],
    [-1,-1],
    [-1, 0],
    [-1, 1]
  ]

  attr_writer :revealed, :flagged
  attr_reader :pos, :board

  def initialize(board, has_bomb, pos)
    @revealed = false
    @has_bomb = has_bomb
    @board = board
    @pos = pos
    @flagged = false
  end

  def has_bomb?
    @has_bomb
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flagged
  end

  def reveal
    self.revealed = true unless flagged?
  end

  def flag
    self.flagged = true unless revealed?
  end

  def unflag
    self.flagged = false
  end

  def neighbors
    neighbors = []

    DELTAS.each do |delta|
      neighbor_pos = pos[0] + delta[0], pos[1] + delta[1]
      neighbors << board[neighbor_pos] if board.on_board?(neighbor_pos)
    end

    neighbors
  end

  def neighbor_bomb_count
    neighbors.count { |neighbor| neighbor.has_bomb? }
  end

  def has_bomb_neighbors?
    neighbor_bomb_count > 0
  end

  def reveal_until_fringe
    if has_bomb_neighbors?
      reveal
      return
    end

    neighbors.each do |neighbor|
      reveal
      neighbor.reveal_until_fringe unless neighbor.revealed?
    end
  end

  def to_s
    if !revealed?
      flagged? ? "F " : "* "
    else
      if has_bomb?
        "X "
      elsif neighbor_bomb_count == 0
        "_ "
      else
        "#{neighbor_bomb_count} "
      end
    end
  end

  def exploded?
    revealed? && has_bomb?
  end
end
