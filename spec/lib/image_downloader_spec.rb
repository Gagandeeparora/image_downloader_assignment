# frozen_string_literal: true

require 'image_downloader'
require 'pry'
require 'webmock/rspec'

RSpec.describe ImageDownloader do
  let(:valid_image_url) { 'https://images.reddoorz.com/photos/238492/desktop_hotel_gallery_large_900x600_DSCF7067.JPG' }
  let(:invalid_image_url) { 'not_a_valid_url' }
  let(:image) { double('Image', url: valid_image_url, uri: URI(valid_image_url)) }
  let(:invalid_image) { double('Image', url: invalid_image_url, uri: URI(invalid_image_url)) }

  describe '.call' do
    it 'downloads a valid image' do
      stub_request(:get, valid_image_url)
        .to_return(status: 200, body: 'image_data', headers: { 'Content-Type' => 'image' })
      expect { ImageDownloader.call(image) }.to output(/Downloaded: #{valid_image_url}/).to_stdout
    end

    it 'raises an error for an image without content' do
      stub_request(:get, valid_image_url)
        .to_return(status: 200, body: 'image_data', headers: { 'Content-Type' => 'text/plain' })
      expect do
        ImageDownloader.call(image)
      end.to output(/Failed to download: #{valid_image_url} \(Don't have image content\)/).to_stdout
    end

    it 'handles a failed download and outputs an error message' do
      stub_request(:get, invalid_image_url)
        .to_return(status: 404, body: 'HTTP Status: 404', headers: { 'Content-Type' => 'image' })
      expect do
        ImageDownloader.call(invalid_image)
      end.to output(/Failed to download: #{invalid_image_url} \(Error\)/).to_stdout
    end

    it 'handles connection errors and outputs an error message' do
      stub_request(:get, valid_image_url)
        .to_raise(Errno::ECONNREFUSED)
      expect do
        ImageDownloader.call(image)
      end.to output(/Failed to download: #{valid_image_url} \(Connection Refused\)/).to_stdout
    end

    it 'handles other errors and outputs a generic error message' do
      stub_request(:get, valid_image_url)
        .to_raise(StandardError)
      expect { ImageDownloader.call(image) }.to output(/Failed to download: #{valid_image_url} \(Error\)/).to_stdout
    end
  end

  describe 'private methods' do
    it 'generates a valid filename' do
      downloader = ImageDownloader.new(image)
      expect(downloader.send(:generate_filename)).to end_with("/downloads/#{valid_image_url.split('/').last}")
    end

    it 'gets an image via HTTParty' do
      downloader = ImageDownloader.new(image)
      stub_request(:get, valid_image_url)
        .to_return(status: 200, body: 'image_data', headers: { 'Content-Type' => 'image' })
      response = downloader.send(:get_image)
      expect(response.success?).to be true
      expect(response.headers['Content-Type']).to eq('image')
      expect(response.body).to eq('image_data')
    end

    it 'handles request errors and outputs an error message' do
      downloader = ImageDownloader.new(image)
      exception = RuntimeError
      expect do
        downloader.send(:request_error!, exception)
      end.to output(/Failed to download: #{valid_image_url} \(Error\)/).to_stdout
    end
  end
end
