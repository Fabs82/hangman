require_relative "dictionary"
require_relative "secret_word"
require_relative "player"
require_relative "file_manager"

# A class that manages the flow of the game
class Game
  def initialize(loaded_data = nil)
    # Set up the components that are always needed
    @player = Player.new("Player One")
    @dictionary = Dictionary.new
    @filemanager = FileManager.new("savefile")
    if loaded_data
      load_data(loaded_data)
    else
      start_new
    end
  end

  def start_game
    # hide the word
    @secret_word.hide_word if @secret_word.hidden.empty?
    # takes the secret word and calls a method that hides it showing only underscores for visual feedback
    while @mistakes_count < 3
      start_turn
      # repeatidly asks the player for input until a  valid letter has been entered
      letter = @player.choose_letter until check_valid_input(letter)
      # append used letters to the array so that they cannot be used again
      @used_letters.append(letter)
      # add letter or increase mistakes count
      check_if_letter_found(letter)
      # calls the method to check if word has been found and end loop
      return puts "Word found. You win!" if @secret_word.word_found?

      save_file
    end
    puts "Time is up. You lost!"
  end

  def start_turn
    puts "\n--- NEW TURN ---"
    puts "Letter already chosen #{@used_letters}"
    puts "Secret word: #{@secret_word.hidden.join}"
    # TO DO: delete print statement when done
    puts "DEBUG: The secret word is: #{@secret_word.word.join}"
  end

  def check_valid_input(letter)
    return unless @used_letters.none?(letter) && ("a".."z").to_a.include?(letter)

    true
  end

  def check_if_letter_found(letter)
    if @secret_word.check_letter(letter)
      # show the word with the letters found for visual feedback
      puts @secret_word.show_word(letter)
    else
      # increase the mistakes
      @mistakes_count += 1
    end
    puts "\nMistakes: #{@mistakes_count}"
    sleep(1)
  end

  def create_save_data
    # store the data used to create a JSON save file
    {
      "secret_word": @secret_word.word,
      "hidden_word": @secret_word.hidden,
      "used_letters": @used_letters,
      "mistakes": @mistakes_count
    }
  end

  def ask_for_saving
    # a method that return player'choice when prompted for saving
    puts "Do you want to save the game (Y/N)"
    answer = gets.chomp.downcase
    until %w[y n].include?(answer)
      puts "Do you want to save the game (Y/N)"
      answer = gets.chomp.downcase
    end
    answer
  end

  def save_file
    # check answer and save the file if needed
    case ask_for_saving
    when "y"
      @filemanager.save_game(create_save_data)
    else
      puts "Game not saved"
    end
  end

  def load_data(loaded_data)
    puts "Loading game..."
    @secret_word = SecretWord.new(loaded_data["secret_word"].join)
    @secret_word.hidden = loaded_data["hidden_word"]
    @used_letters = loaded_data["used_letters"]
    @mistakes_count = loaded_data["mistakes"]
  end

  def start_new
    puts "Starting new game..."
    @secret_word = SecretWord.new(@dictionary.pick_random_word)
    @used_letters = []
    @mistakes_count = 0
  end
end
