require "lifx"
require_relative 'lan_client_base'

module LifxToys
  class Colors < LanClientBase

    HUE_RANGE = 0..360
    BRIGHTNESS_RANGE = 20..80
    SATURATION_RANGE = 40..100

    def fade_duration
      10.0
    end

    def color_for_light(_)
      LIFX::Color.hsb(random_hue, random_saturation, random_brightness)
    end

    def random_hue
      rand(HUE_RANGE)
    end

    def random_saturation
      rand(SATURATION_RANGE).to_f / 100
    end

    def random_brightness
      rand(BRIGHTNESS_RANGE).to_f / 100
    end
  end
end
