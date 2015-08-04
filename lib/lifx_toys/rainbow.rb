require 'lifx'
require_relative 'lan_client_base'

module LifxToys
  class Rainbow < LanClientBase

    def fade_duration
      0.1
    end

    def inter_light_wait
      0
    end

    def post_client_flush_wait
      fade_duration
    end

    def color_for_light(index)
      increment_base_hue if index == 0

      offset = (360/light_count) * index
      LIFX::Color.hsb((base_hue + offset) % 360, 1, 1)
    end

    def increment_base_hue
      @base_hue = (base_hue + 1) % 360
    end

    def base_hue
      @base_hue || 0
    end

  end
end
