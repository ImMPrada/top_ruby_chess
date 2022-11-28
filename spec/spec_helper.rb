require 'simplecov'
require 'simplecov-lcov'

core_root = './lib/chess/core/'
require 'byebug'
require "#{core_root}chess"
require "#{core_root}cell"
require "#{core_root}pieces/base_piece"
require "#{core_root}pieces/bishop"
require "#{core_root}pieces/knight"

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
