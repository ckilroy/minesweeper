require_relative 'board'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @board.populate
  end

  def play
    take_turn until over?
  end

  def get_pos
    loop do
      puts "What position?"
      print "> "
      input = gets.chomp.split(",").map(&:to_i)
      return input if board.on_board?(input)
      puts "That's not a valid position"
    end
  end

  def get_move
    loop do
      puts "Flag or Reveal? (f/r)"
      print "> "
      move = gets.chomp.downcase
      return move.to_sym if ["f", "r"].include?(move)
      puts "That's not a valid move."
    end
  end

  def take_turn
    pos = get_pos
    move = get_move

    if move == :f
      board[pos].flag
    else
      board[pos].reveal_until_fringe
    end
  end

  def over?
    won? || lost?
  end

  def won?
    board.swept?
  end

  def lost?
    board.exploded_bomb?
  end
end
