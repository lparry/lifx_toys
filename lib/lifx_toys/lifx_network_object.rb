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

    def turn_on(duration = 2)
      HttpApi.set_power_state(selector, 'on', duration)
    end

    def toggle
      HttpApi.toggle_power_state(selector)
    end

    def turn_off(duration = 2)
      HttpApi.set_power_state(selector, 'off', duration)
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
