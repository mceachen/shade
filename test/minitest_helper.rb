begin
  require 'minitest'
rescue LoadError
  puts 'Failed to load the minitest gem; built-in version will be used.'
end
require 'minitest/autorun'
require 'minitest/great_expectations'
require 'minitest/reporters'
require 'shade'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
