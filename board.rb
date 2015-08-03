require_relative 'tile'

class Board
  WIDTH = 9
  HEIGHT = 9
  NUM_BOMBS = 10

attr_reader :grid

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  def populate
    bomb_positions = choose_bomb_positions

    (0...HEIGHT).each do |row_idx|
      (0...WIDTH).each do |col_idx|
        has_bomb = bomb_positions.include?([row_idx, col_idx])
        self[row_idx, col_idx] = Tile.new(self, has_bomb, [row_idx, col_idx])
      end
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(x, y, value)
    grid[x][y] = value
  end

  def choose_bomb_positions
    bomb_positions = []
    until bomb_positions.size == NUM_BOMBS
      new_pos = random_pos
      bomb_positions << new_pos unless bomb_positions.include?(new_pos)
    end
    bomb_positions
  end

  def random_pos
    x_coord = rand(HEIGHT)
    y_coord = rand(WIDTH)
    [x_coord, y_coord]
  end

  def render
    grid.each do |row|
      row.each do |cell|
        if cell.revealed == false
          print cell.flagged ? "F " : "* "
        else
          if cell.neighbor_bomb_count == 0
            print "_ "
          else
            print "#{cell.neighbor_bomb_count} "
          end
        end
      end
      print "\n"
    end
  end

  def on_board?(pos)
    x, y = pos
    x.between?(0, HEIGHT - 1) && y.between?(0, WIDTH - 1)
  end
end
