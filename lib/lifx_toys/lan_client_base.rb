require "lifx"

module LifxToys
  class LanClientBase

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

    def fade_duration
      0
    end

    def inter_light_wait
      fade_duration / light_count
    end

    def post_client_flush_wait
      0
    end

    def run
      while (true)
        lights.each_with_index do |light, light_index|
          color = color_for_light(light_index)
          light.set_color(color, duration: fade_duration)
          debug "Setting #{light.label} to #{color}, duration: #{fade_duration}"
          sleep inter_light_wait
        end
        client.flush
        sleep post_client_flush_wait
      end
    end

    def color_for_light(index)
      raise "implement #color_for_light(index)"
    end

    private

    def debug(*args)
      if ENV['DEBUG']
        puts(*args)
      end
    end

  end
end
