require 'lifx'
require_relative 'lan_client_base'

module LifxToys
  class Clouds < LanClientBase

    KELVIN_RANGE = 2500..9000
    BRIGHTNESS_RANGE = 10..100

    def fade_duration
      5.0
    end

    def color_for_light(_)
      # random white light
      LIFX::Color.hsbk(0, 0, random_brightness, random_kelvin)
    end

    def random_kelvin
      rand(KELVIN_RANGE)
    end

    def random_brightness
      rand(BRIGHTNESS_RANGE).to_f / 100
    end

  end
end
