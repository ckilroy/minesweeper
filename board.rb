class Board
  WIDTH = 9
  HEIGHT = 9
  NUM_BOMBS = 10

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  def populate
    bomb_positions = choose_bomb_positions
    
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
end
