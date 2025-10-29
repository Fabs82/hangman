require "json"

# A class that manages saving and loading files
class FileManager
  def initialize(filename)
    @filename = filename
  end

  def save_game(data)
    json_data = JSON.generate(data)
    file_path = "save/#{@filename}.json"
    File.open(file_path, "w") do |file|
      file.write(json_data)
    end
    puts "Game saved to #{file_path}"
  end

  def load_game
  end
end
