# frozen_string_literal: true

class Downloader
  def self.call(args)
    new(args).start
  end

  def initialize(args)
    @args = args
    @file_path = args.first
  end

  def start
    images.map { |image| ImageDownloader.call(image) if image.valid_url? }
  end

  private

  def images
    ImagesFromFile.call(@file_path)
  end
end
