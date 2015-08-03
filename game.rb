require_relative 'board'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @board.populate
  end

  def play

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


end
