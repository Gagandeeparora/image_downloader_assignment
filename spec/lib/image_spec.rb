# frozen_string_literal: true

require 'image'
require 'pry'

RSpec.describe Image do
  let(:valid_http_url) { 'http://images.reddoorz.com/photos/238492/desktop_hotel_gallery_large_900x600_DSCF7067.JPG' }
  let(:valid_https_url) { 'https://images.reddoorz.com/photos/238492/desktop_hotel_gallery_large_900x600_DSCF7067.JPG' }
  let(:invalid_url) { 'not_a_valid_url' }

  describe '#initialize' do
    it { expect(Image.new.class).to eq(Image) }

    it 'creates an Image object with a URL' do
      image = Image.new(url: valid_http_url)
      expect(image.url).to eq(valid_http_url)
      expect(image.uri).to be_an_instance_of(URI::HTTP)
    end
  end

  describe '#valid_url?' do
    it 'returns true for a valid HTTP URL' do
      image = Image.new(url: valid_http_url)
      expect(image.valid_url?).to be true
    end

    it 'returns true for a valid HTTPS URL' do
      image = Image.new(url: valid_https_url)
      expect(image.valid_url?).to be true
    end

    it 'returns false for an invalid URL' do
      image = Image.new(url: invalid_url)
      expect(image.valid_url?).to be false
    end
  end
end
