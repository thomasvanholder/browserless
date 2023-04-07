# frozen_string_literal: true

require "bundler/gem_tasks"
require "standard/rake"
require "rake/testtask"

task default: :standard

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList["test/**/*_test.rb"]
  test.warning = false
end
desc "Run tests"
task default: :test
