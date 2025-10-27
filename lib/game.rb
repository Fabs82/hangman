require_relative "dictionary"
require_relative "secret-word"
require_relative "player"

# A class that manages the flow of the game
class Game
  def initialize
    @player = Player.new("Player One")
    @dictionary = Dictionary.new
    @secret_word = SecretWord.new(@dictionary.pick_random_word)
    @used_letters = []
    @turn = 1
  end

  def start_game
    # takes the secret word and calls a method that hides it showing only underscores for visual feedback
    @secret_word.hide_word
    while @turn <= 10
      start_turn
      # repeatidly asks the player for input until a  valid letter has been entered
      letter = @player.choose_letter until check_valid_input(letter)
      # append used letters to the array so that they cannot be used again
      @used_letters.append(letter)
      # show the word with the letters found for visual feedback
      @secret_word.show_word(letter)
      # calls the method to check if word has been found and end loop
      return puts "Word found. You win!" if @secret_word.word_found?

      # increase counter
      @turn += 1
    end
    puts "Time is up. You lost!"
  end

  def start_turn
    puts "\n---TURN NUMBER #{@turn}---"
    puts "Letter already chosen #{@used_letters}"
    # TO DO: delete print statement when done
    puts "DEBUG: The secret word is: #{@secret_word.word.join}"
  end

  def check_valid_input(letter)
    return unless @used_letters.none?(letter) && ("a".."z").to_a.include?(letter)

    true
  end
end

game = Game.new

game.start_game
