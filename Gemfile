# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').strip

gem 'httparty'

group :development, :test do
  gem 'pry', '~> 0.14.1'
  gem 'rspec', '~> 3.10'
  gem 'rubocop', '~> 1.57'
  gem 'webmock'
end
