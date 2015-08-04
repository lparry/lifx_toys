require 'lifx'
module LifxToys
  class Clouds

    KELVIN_RANGE = 2500..9000
    BRIGHTNESS_RANGE = 10..100

    CYCLE_TIME = 5.0

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
          light.set_color(random_white, duration: CYCLE_TIME * 1.5)
          sleep(CYCLE_TIME / light_count)
        end
        client.flush
      end
    end

    def random_white
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
