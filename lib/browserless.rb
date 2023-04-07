# frozen_string_literal: true

require "json"
require "httparty"

require_relative "browserless/configuration"
require_relative "browserless/client"
require_relative "browserless/version"

module Browserless
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
