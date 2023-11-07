# frozen_string_literal: true

require 'pry'

require_relative 'images_from_file'
require_relative 'image_downloader'
require_relative 'image'
require_relative 'downloader'

puts 'Script is starting'
# '/Users/Gagan/Desktop/Projects/image_download_assignment/images.txt'
Downloader.call(ARGV)

puts 'Script ended'
