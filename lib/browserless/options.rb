# frozen_string_literal: true

module Browserless
  class Options
    HEADER_TEMPLATE = "<div></div>" # empty header
    FOOTER_TEMPLATE = "<div style='font-size: 11px; margin-left: 40px; font: Helvetica'><span class='pageNumber'></span> of <span class='totalPages'></span></div>"

    attr_reader :display_header_footer, :margin, :pdf_format, :print_background, :header_template, :footer_template, :options, :landscape

    def initialize(**options)
      @options = options
      @landscape = config_value(:landscape) || false
      @margin = config_value(:margin) || {}
      @pdf_format = config_value(:format) || "A4"
      @print_background = config_value(:print_background) || false
      @header_template = config_value(:header_template) || HEADER_TEMPLATE
      @footer_template = config_value(:footer_template) || FOOTER_TEMPLATE
      @display_header_footer = config_value(:display_header_footer) || false
    end

    def to_h
      {
        landscape: landscape,
        displayHeaderFooter: display_header_footer,
        printBackground: print_background,
        margin: margin,
        format: pdf_format,
        headerTemplate: header_template,
        footerTemplate: footer_template
      }
    end

    private

    def config_value(key)
      return options[key] if Browserless.configuration.options.nil?

      options[key] || Browserless.configuration.options[key]
    end
  end
end
