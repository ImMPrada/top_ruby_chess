require 'simplecov'
require 'simplecov-lcov'
require 'chess/core/chess'

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
