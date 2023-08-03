# frozen_string_literal: true

module Browserless
  class GotoOptions
    attr_reader :options, :timeout, :wait_until

    def initialize(**options)
      @options = options
      @timeout = config_value(:timeout) || 0
      @wait_until = config_value(:wait_until) || "load"
    end

    def to_h
      {
        timeout: timeout,
        waitUntil: wait_until
      }
    end

    private

    def config_value(key)
      return options[key] if Browserless.configuration.goto_options.nil?

      options[key] || Browserless.configuration.goto_options[key]
    end
  end
end
