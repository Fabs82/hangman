# A class that manages the player.
class Player
  def initialize(name)
    @name = name
    puts "#{@name} initialized"
  end

  def choose_letter
    puts "Please choose a letter from the alphabet"
    gets.chomp.downcase
  end
end
