require_relative "lib/game"

# ask the player to start a new game or load a previous one. Get a start or load answer. return the answer
puts "WELCOME TO HANGMAN"
puts "Enter S to start a new game or L to load"
answer = gets.chomp.downcase
until %w[s l].include?(answer)
  puts "Enter S to start a new game or L to load"
  answer = gets.chomp.downcase
end
sleep(2)
# check the answer and act accordinlgy loading or starting a new game
if answer == "l"
  require_relative "lib/file_manager"
  file_manager = FileManager.new("savefile")
  loaded_data = file_manager.load_game
  game = Game.new(loaded_data)
else
  game = Game.new
end

game.start_game
