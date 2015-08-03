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

      private

      def info_url(selector)
        "https://api.lifx.com/v1beta1/lights/#{selector}"
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
