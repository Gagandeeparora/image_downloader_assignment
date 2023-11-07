# frozen_string_literal: true

require 'pry'
require 'images_from_file'
require 'image'
require 'uri'

RSpec.describe ImagesFromFile do
  let(:image_file_path) { "#{File.expand_path('')}/spec/lib/test_images.txt" }

  let(:image_objects) { ImagesFromFile.call(image_file_path) }

  it { expect(image_objects).to be_an(Array) }

  it { expect(image_objects.sample).to be_an(Image) }

  it { expect(ImagesFromFile.new('').class).to eq(ImagesFromFile) }

  describe 'call method' do
    it 'creates Image objects from a file' do
      expect(image_objects).to be_an(Array)
      expect(image_objects.length).to eq(1)
      expect(image_objects.all? { |img| img.is_a?(Image) }).to be true
    end

    it 'returns an empty array when the file is empty' do
      empty_file_path = "#{File.expand_path('')}/empty_file.txt"
      image_objects = ImagesFromFile.call(empty_file_path)
      expect(image_objects).to eq([])
    end

    it 'returns an empty array when the file does not exist' do
      non_existent_file_path = '/non_existent_file.txt'
      image_objects = ImagesFromFile.call(non_existent_file_path)
      expect(image_objects).to eq([])
    end
  end

  context 'when the file contains valid URLs' do
    it 'creates Image objects with correct URLs' do
      expected_urls = ['http://images.reddoorz.com/photos/238492/desktop_hotel_gallery_large_900x600_DSCF7067.JPG']
      expect(image_objects.map(&:url)).to eq(expected_urls)
    end
  end
end
