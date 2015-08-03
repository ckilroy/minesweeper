class Board
  WIDTH = 9
  HEIGHT = 9

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  def populate
    bomb_positions = []
    until bomb_positions.size == 10
      new_pos = random_pos
      bomb_positions << new_pos unless bomb_positions.include?(new_pos)
    end
  end

  def random_pos
    x_coord = rand(HEIGHT)
    y_coord = rand(WIDTH)
    [x_coord, y_coord]
  end
end
