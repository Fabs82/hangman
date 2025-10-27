# A class that manages the player.
class Player
  def initialize(name)
    @name = name
  end

  def choose_letter
    puts "\nPlease choose a letter:"
    gets.chomp.downcase
  end
end
