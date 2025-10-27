# A class that picks a ranwom word from a loaded list
class SecretWord
  attr_reader :word

  def initialize(word)
    @word = word.split(//)
  end

  def hide_letters
  end

  def show_letter
  end
end
