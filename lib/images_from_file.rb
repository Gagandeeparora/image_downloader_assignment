# frozen_string_literal: true

class ImagesFromFile
  def self.call(file_path)
    new(file_path).perform
  end

  def initialize(file_path)
    @file_path = file_path
  end

  def perform
    file_content.split.map { |images_url| Image.new(url: images_url) }
  end

  private

  def file_content
    File.read(current_file_path)
  end

  def current_file_path
    if @file_path && File.exist?(@file_path)
      @file_path
    else
      puts 'No file found.'
      @file_path = "#{File.expand_path('')}/empty_file.txt"
    end
  end
end
