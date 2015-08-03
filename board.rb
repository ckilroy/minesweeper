require_relative 'tile'
require 'colorize'


class Board
  WIDTH = 9
  HEIGHT = 9
  NUM_BOMBS = 10

attr_reader :grid, :cursor_pos

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH) }
    populate
    @cursor_pos = [0,0]
  end

  def move_curs(direction)
    if direction == :r
      cursor_pos[1] += 1
      cursor_pos[1] -= 1 unless on_board?(cursor_pos)
    elsif direction == :l
      cursor_pos[1] -= 1
      cursor_pos[1] += 1 unless on_board?(cursor_pos)
    elsif direction == :u
      cursor_pos[0] -= 1
      cursor_pos[0] += 1 unless on_board?(cursor_pos)
    else
      cursor_pos[0] += 1
      cursor_pos[0] -= 1 unless on_board?(cursor_pos)
    end
  end

  def populate
    bomb_positions = choose_bomb_positions

    (0...HEIGHT).each do |row_idx|
      (0...WIDTH).each do |col_idx|
        pos = [row_idx, col_idx]
        has_bomb = bomb_positions.include?(pos)
        self[pos] = Tile.new(self, has_bomb, pos)
      end
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
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
    system("clear")
    puts "  #{(0...WIDTH).to_a.join(" ")}"

    grid.each_with_index do |row, idx|
      print "#{idx} "
      row.each do |cell|
        if cursor_pos == cell.pos
          print cell.to_s.colorize(:red)
        else
          print cell
        end
      end
      print "\n"
    end
  end

  def on_board?(pos)
    x, y = pos
    x.between?(0, HEIGHT - 1) && y.between?(0, WIDTH - 1)
  end

  def exploded_bomb?
    tiles.any? { |tile| tile.exploded? }
  end

  def swept?
    tiles.all? { |tile| tile.revealed? || tile.has_bomb? }
  end

  def tiles
    grid.flatten
  end

  def reveal_all_bombs
    tiles.each { |tile| tile.reveal if tile.has_bomb? }
  end
end
