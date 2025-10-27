require_relative "dictionary"
require_relative "secret-word"
require_relative "player"
# A class that manages the flow of the game
class Game
  def initialize
    @player = Player.new("Player One")
    @dictionary = Dictionary.new
    @secret_word = SecretWord.new(@dictionary.pick_random_word)
  end

  def start_game
    # TO DO: delete print statement when done
    puts "The secret word is #{@secret_word.word.join}"
    @secret_word.hide_letters

    letter = @player.choose_letter until check_user_input(letter)
  end

  def check_user_input(letter)
    ("a".."z").to_a.include?(letter)
  end
end

game = Game.new

game.start_game
