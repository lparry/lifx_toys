require 'forwardable'
require_relative 'lifx_light'

module LifxToys
  class LifxNetworkObject

    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    def get_info
      HttpApi.get_light_info(selector)
    end

    def set_color(color, duration=1.0)
      response = HttpApi.set_color(selector, color, duration)
      if response.success?
        puts "info: set #{selector} to #{color}, duration:#{duration}" if ENV["DEBUG"]
        nil
      else
        puts "warning: light status - #{response}"
        -1
      end
    end
  end
end
