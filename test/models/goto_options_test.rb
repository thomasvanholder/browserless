require "test_helper"

class GotoOptionsTest < Minitest::Test
  def setup
    Browserless.configure do |config|
      config.api_key = "test_key"
    end
  end

  def teardown
    Browserless.configure { nil }
  end

  def test_initialize_with_default_values
    Browserless.configure do |config|
      config.api_key = "test_key"
      config.goto_options = {}
    end

    options = Browserless::GotoOptions.new

    assert_equal 0, options.timeout
    assert_equal "load", options.wait_until
  end

  def test_initialize_with_custom_values
    options = Browserless::GotoOptions.new(timeout: 1000, wait_until: "networkidle0")

    assert_equal 1000, options.timeout
    assert_equal "networkidle0", options.wait_until
  end

  def test_initialize_with_custom_values_in_initializer
    Browserless.configure do |config|
      config.api_key = "test_key"
      config.goto_options = {
        timeout: 15_000,
        wait_until: "networkidle2"
      }
    end

    options = Browserless::GotoOptions.new

    assert_equal 15_000, options.timeout
    assert_equal "networkidle2", options.wait_until
  end

  def test_initialize_with_custom_values_in_initializer_and_overwrite
    Browserless.configure do |config|
      config.api_key = "test_key"
      config.goto_options = {
        timeout: 1000
      }
    end

    options = Browserless::Options.new(timeout: 10_000)

    assert_equal 10_000, options.timeout
  end
end
