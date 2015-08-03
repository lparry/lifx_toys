require_relative 'http_api'

module LifxToys
  class LifxNetworkObject

    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    def get_info
      make_request :get_info
    end

    def set_power_state(state, options = {})
      make_request :set_power_state, state, options
    end

    def toggle
      make_request :toggle_power_state
    end

    def set_color(color, options = {})
      response = make_request :set_color, color, options
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
