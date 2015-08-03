require 'json'
require 'httparty'

module LifxToys
  module HttpApi
    class << self

      def with_default_selector(selector)
        WithDefaultSelector.new(selector)
      end

      def set_color(selector, color, options = { duration: 2.0,
                                                 power_on: true})
        HTTParty.put(color_url(selector),
                     headers: authorization_headers,
                     query: options.merge({
                       color: color
                     })).tap do |response|
      if response.success?
                       puts "info: set #{selector} to #{color}" if ENV["DEBUG"]
        nil
      else
        puts "warning: light status - #{response}"
        -1
      end
                     end
      end

      def get_info(selector)
        HTTParty.get(info_url(selector),
                     headers: authorization_headers)
      end

      def set_power_state(selector, state, options = {duration: 2})
        HTTParty.put(power_url(selector),
                     headers: authorization_headers,
                     query: options.merge({
                       state: state
                     }))
      end

      def toggle_power_state(selector)
        HTTParty.post(toggle_power_url(selector),
                     headers: authorization_headers)
      end

      def breathe(selector, color, options: {
                                    # from_color: current_bulb_color,
                                      period:     1.0,
                                      cycles:     1.0,
                                      persist:    false,
                                      power_on:   true,
                                      peak:       0.5 })
        HTTParty.post(breathe_url(selector),
                     headers: authorization_headers,
                     query: options.merge({
                       color: color
                     }))
      end

      def pulse(selector, color, options: {
                                    # from_color: current_bulb_color,
                                      period:     1.0,
                                      cycles:     1.0,
                                      persist:    false,
                                      power_on:   true,
                                      peak:       1.0 })
        HTTParty.post(pulse_url(selector),
                     headers: authorization_headers,
                     query: options.merge({
                       color: color
                     }))
      end

      private

      def info_url(selector)
        "https://api.lifx.com/v1beta1/lights/#{selector}"
      end

      def color_url(selector)
        "#{info_url(selector)}/color"
      end

      def power_url(selector)
        "#{info_url(selector)}/power"
      end

      def toggle_power_url(selector)
        "#{info_url(selector)}/toggle"
      end

      def breathe_url(selector)
        "#{info_url(selector)}/effects/breathe"
      end

      def pulse_url(selector)
        "#{info_url(selector)}/effects/pulse"
      end

      def authorization_headers
        {"Authorization" => "Bearer #{ENV["LIFX_TOKEN"]}"}
      end
    end
  end
end
