require 'simplecov'
require 'simplecov-lcov'

require 'byebug'
require './lib/chess/chess'
require './lib/chess/pieces/piece'
require './lib/chess/pieces/king'
require './lib/chess/pieces/queen'
require './lib/chess/pieces/bishop'
require './lib/chess/pieces/knight'
require './lib/chess/pieces/rook'
require './lib/chess/position'
require './lib/chess/board'

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov::Formatter::LcovFormatter.config do |c|
  c.output_directory = '.'
  c.lcov_file_name = 'lcov.info'
  c.single_report_path = '../lcov.info'
end
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start

RSpec.configure do |config|
  # Use the specified formatter
  config.formatter = :documentation
end
