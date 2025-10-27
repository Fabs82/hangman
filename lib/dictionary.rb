# A class that loads the text files, filters out words (< 5 and > 12) and pick a random word from it
class Dictionary
  def initialize
    @words_list = File.open("words-list.txt", "r") do |file|
      file.select { |word| word.strip.size > 5 && word.strip.size < 12 }
    end
  end

  def pick_random_word
    @words_list.sample.strip
  end
end
