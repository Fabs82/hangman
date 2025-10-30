require "json"

# A class that manages saving and loading files
class FileManager
  def initialize(filename)
    @filename = filename
    @file_path = File.join(__dir__, "save", "#{@filename}.json")
  end

  def save_game(data)
    json_data = JSON.pretty_generate(data)
    File.open(@file_path, "w") do |file|
      file.write(json_data)
    end
    puts "Game saved to #{@file_path}"
  end

  def load_game
    load_data = File.read(@file_path)
    JSON.parse(load_data)
  rescue Errno::ENOENT
    puts "Save file not found: #{@file_path}"
    nil
  rescue JSON::ParserError
    puts "Save file corrupted: #{@file_path}"
    nil
  end
end
