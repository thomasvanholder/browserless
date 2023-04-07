require "test_helper"

class OptionsTest < Minitest::Test
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
      config.options = {}
    end

    options = Browserless::Options.new

    assert_equal false, options.display_header_footer
    assert_equal false, options.landscape
    assert_equal({}, options.margin)
    assert_equal "A4", options.pdf_format
    assert_equal false, options.print_background
  end

  def test_initialize_with_custom_values
    options = Browserless::Options.new(display_header_footer: true, landscape: true, margin: {top: "1cm", bottom: "1cm"}, format: "A3", print_background: true)

    assert_equal true, options.display_header_footer
    assert_equal true, options.landscape
    assert_equal({top: "1cm", bottom: "1cm"}, options.margin)
    assert_equal "A3", options.pdf_format
    assert_equal true, options.print_background
  end

  def test_initialize_with_custom_values_in_initializer
    Browserless.configure do |config|
      config.api_key = "test_key"
      config.options = {
        display_header_footer: true,
        landscape: true,
        margin: {top: "1cm", bottom: "1cm"},
        format: "A3",
        print_background: true
      }
    end

    options = Browserless::Options.new

    assert_equal true, options.display_header_footer
    assert_equal true, options.landscape
    assert_equal({top: "1cm", bottom: "1cm"}, options.margin)
    assert_equal "A3", options.pdf_format
    assert_equal true, options.print_background
  end

  def test_initialize_with_custom_values_in_initializer_and_overwrite
    Browserless.configure do |config|
      config.api_key = "test_key"
      config.options = {
        format: "A3"
      }
    end

    options = Browserless::Options.new(format: "A5")

    assert_equal "A5", options.pdf_format
  end
end
