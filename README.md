# Coding Challenge 

This is a project to to implement the functionality of downloading images from a given plain text file and save to local drive.
## Installation

### Application

Let's start by installing the ruby dependencies
run bundle install


## Run

### Application

You can put your file on the project:

ruby lib/main.rb 'text_file_path.txt'

Please add absolute path or use the example images.txt


All valid image urls will be saved in the downloads folder. The invalid urls will be ignored

### Test suite

You can run tests with
bundle exec rspec spec
