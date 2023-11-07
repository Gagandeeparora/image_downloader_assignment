# frozen_string_literal: true

require 'uri'
require 'httparty'
require 'pry'

class ImageDownloader
  def self.call(image)
    new(image).download_image
  end

  def initialize(image)
    @image = image
    @output_folder = "#{File.expand_path('..', __dir__)}/downloads/"
  end

  def download_image
    response = get_image
    if response.success? && (response.headers['Content-Type'].start_with? 'image')
      save_image(response.body)
      puts "Downloaded: #{@image.url}"
    elsif response.success?
      raise "Don't have image content"
    else
      puts "Failed to download: #{@image.url} (HTTP Status: #{response.code})"
    end
  rescue Exception => e
    request_error!(e)
  end

  private

  def generate_filename
    uri = @image.uri
    File.join(@output_folder, File.basename(uri.path))
  end

  def save_image(data)
    File.binwrite(generate_filename, data)
  end

  def get_image
    HTTParty.get(@image.url, { timeout: 30 })
  end

  def request_error!(exception)
    msg = case exception
          when Errno::ECONNREFUSED
            'Connection Refused'
          when RuntimeError
            exception.message
          else
            'Error'
          end
    puts "Failed to download: #{@image.url} (#{msg})"
  end
end
