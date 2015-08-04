require "lifx"
module LifxToys
  class Rainbow

    CYCLE_TIME = 0.1

    attr_reader :client

    def initialize
      @client = LIFX::Client.lan

      client.discover!
    end

    def lights
      @client.lights
    end

    def light_count
      lights.count
    end

    def run
      while (true)
        (0...360).each do |hue|
          lights.each_with_index do |light, light_index|
            light.set_color(color_for_light(hue, light_index), duration: CYCLE_TIME)
          end
          client.flush
          sleep CYCLE_TIME
        end
      end
    end

    def color_for_light(base_color, index)
      offset = (360/light_count) * index
      LIFX::Color.hsb((base_color + offset) % 360, 1, 1)
    end

  end
end
