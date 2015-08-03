require 'forwardable'
require_relative 'lifx_light'

module LifxToys
  class LifxNetworkObject

    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    def get_info
      make_request :get_light_info
    end

    def turn_on(options = {})
      make_request :set_power_state, 'on', options
    end

    def toggle
      make_request :toggle_power_state
    end

    def turn_off(options = {})
      make_request :set_power_state, 'off', options
    end

    def set_color(color, options = {})
      response = make_request :set_color, color, options
      if response.success?
        puts "info: set #{selector} to #{color}" if ENV["DEBUG"]
        nil
      else
        puts "warning: light status - #{response}"
        -1
      end
    end

    def breathe(color, options = {})
      make_request :breathe, color, options
    end

    def pulse(color, options = {})
      make_request :pulse, color, options
    end

    def make_request(method_name, *args)
      HttpApi.public_send(method_name, selector, *args)
    end
  end
end
