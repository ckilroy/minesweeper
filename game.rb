require_relative 'board'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @board.populate
  end

  def play
    take_turn until over?

    if won?
      board.render
      puts "You won!"
    else
      board.reveal_all_bombs
      board.render
      puts "BOOM! You lost!"
    end
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
      puts "Flag, Unflag or Reveal? (f/u/r)"
      print "> "
      move = gets.chomp.downcase
      return move.to_sym if ["f", "u", "r"].include?(move)
      puts "That's not a valid move."
    end
  end

  def take_turn
    board.render

    pos = get_pos
    move = get_move

    if move == :f
      board[pos].flag
    elsif move == :u
      board[pos].unflag
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

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
