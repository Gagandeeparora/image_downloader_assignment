# frozen_string_literal: true

require 'downloader'
require 'image_downloader'

RSpec.describe Downloader do
  let(:valid_image_url) { 'http://images.reddoorz.com/photos/238492/desktop_hotel_gallery_large_900x600_DSCF7067.JPG' }
  let(:file_path) { "#{File.expand_path('')}/spec/lib/test_images.txt" }
  let(:args) { [file_path] }

  describe '.call' do
    it 'downloads valid images' do
      stub_request(:get, valid_image_url)
        .to_return(status: 200, body: 'image_data', headers: { 'Content-Type' => 'image' })
      expect { Downloader.call(args) }.to output(/Downloaded: #{valid_image_url}/).to_stdout
    end
  end

  describe 'private methods' do
    it 'images from file' do
      images = ImagesFromFile.call(file_path)
      expect(images).to be_an(Array)
      expect(images.size).to eq(1)
    end
  end
end
