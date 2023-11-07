# frozen_string_literal: true

class Image
  attr_accessor :url, :uri

  def initialize(url: nil)
    @url = url
    @uri = URI.parse(url) if url
  end

  def valid_url?
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue ::URI::InvalidURIError
    puts "Failed to download: #{@url} (Incorrect url format)"
    false
  end
end
