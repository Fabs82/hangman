# A class that picks a ranwom word from a loaded list
class SecretWord
  attr_reader :word
  attr_accessor :hidden

  def initialize(word)
    @word = word.split(//)
    @hidden = []
  end

  def hide_word
    # a method that hides it showing only underscores for the first feedback
    (1..@word.size).each do |_|
      @hidden.append(" _ ")
    end
    @hidden.join
    # transform the array into a string for visual feedback
  end

  def show_word(letter)
    # a method that checks if the letter chosen is in the hidden word and makes it visible
    @word.each_index do |index|
      @hidden[index] = letter if letter == @word[index]
    end
    # transform the array into a string for visual feedback
    @hidden.join
  end

  def check_letter(letter)
    @word.include?(letter)
  end

  def word_found?
    # amethod that checks if word has been found
    @word.join == @hidden.join
  end
end
