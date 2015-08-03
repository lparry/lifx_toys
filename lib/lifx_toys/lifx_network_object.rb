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

    def turn_on(options = {})
      HttpApi.set_power_state(selector, 'on', options)
    end

    def toggle
      HttpApi.toggle_power_state(selector)
    end

    def turn_off(options = {})
      HttpApi.set_power_state(selector, 'off', options)
    end

    def set_color(color, options = {})
      response = HttpApi.set_color(selector, color, options)
      if response.success?
        puts "info: set #{selector} to #{color}" if ENV["DEBUG"]
        nil
      else
        puts "warning: light status - #{response}"
        -1
      end
    end
  end
end
