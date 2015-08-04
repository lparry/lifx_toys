require "lifx"

module LifxToys
  class Colors

    HUE_RANGE = 0..360
    BRIGHTNESS_RANGE = 20..80
    SATURATION_RANGE = 40..100

    CYCLE_TIME = 10.0

    attr_reader :client

    def initialize
      @client = LIFX::Client.lan

      client.discover!
    end

    def lights
      client.lights
    end

    def light_count
      lights.count
    end

    def run
      while (true)
        lights.each do |light|
          light.set_color(random_color, duration: CYCLE_TIME * 1.5)
          sleep(CYCLE_TIME/ light_count)
        end
        client.flush
      end
    end

    def random_color
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
