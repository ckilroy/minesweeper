class Tile
  attr_reader :revealed
  
  def initialize(has_bomb)
    @revealed = false
    @has_bomb = has_bomb
  end
end
