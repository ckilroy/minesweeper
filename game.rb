require_relative 'board'
require 'yaml'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @board.populate
  end

  def ask_to_load_game
    puts "Press l to load game. Otherwise press enter."
    print "> "
    input = gets.chomp.downcase
    load_game if input == "l"
  end

  def play
    ask_to_load_game

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
      puts "Flag, Unflag or Reveal? (f/u/r) Or Save? (s)"
      print "> "
      move = gets.chomp.downcase
      return move.to_sym if ["f", "u", "r", "s"].include?(move)
      puts "That's not a valid move."
    end
  end

  def take_turn
    board.render

    move = get_move
    if move == :s
      save_game
      return
    end
    pos = get_pos

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

  def save_game
    File.open("saved_game.txt", "w") do |f|
      f.puts board.to_yaml
    end
  end

  def load_game
    @board = YAML.load(File.read("saved_game.txt"))
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
