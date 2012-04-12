# -*- encoding : utf-8 -*-
ENV['COVERAGE'] ||= "true" if RUBY_VERSION >= "1.9"
ENV["RAILS_ENV"] ||= 'test'



require 'simplecov'
SimpleCov.start do
  #command_name  "Unit Tests #{rand(99999)}"
  coverage_dir  'tmp/coverage'
  add_group   'Libraries',    'lib'
  add_filter  'config'
end


require 'rspec'
require 'rspec/autorun'
require File.expand_path("#{File.dirname(__FILE__)}/../lib/export_table2csv.rb")

RSpec.configure do |config|
  config.color = true
  config.formatter = 'p' #'documentation'
  config.full_description = false
end


