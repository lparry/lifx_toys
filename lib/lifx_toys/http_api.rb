require 'json'
require 'httparty'

module LifxToys
  module HttpApi
    class << self

      def set_color(selector, color, duration = 2)
        HTTParty.put(color_url(selector),
                     headers: authorization_headers,
                     query: {
                       color: color,
                       duration: duration
                     })
      end

      def get_light_info(selector)
        HTTParty.get(info_url(selector),
                     headers: authorization_headers)
      end

      def set_power_state (selector, state, duration = 2)
        HTTParty.put(power_url(selector),
                     headers: authorization_headers,
                     query: {
                       state: state,
                       duration: duration
                     })
      end

      private

      def info_url(selector)
        "https://api.lifx.com/v1beta1/lights/#{selector}"
      end

      def power_url(selector)
        "https://api.lifx.com/v1beta1/lights/#{selector}/power"
      end

      def color_url(selector)
        "#{info_url(selector)}/color"
      end

      def authorization_headers
        {"Authorization" => "Bearer #{ENV["LIFX_TOKEN"]}"}
      end
    end
  end
end
