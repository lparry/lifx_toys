require "lifx_http"
module LifxToys
  class Rainbow

    CYCLE_TIME = 1

    def initialize
      @lights = LifxHttp::LifxLight.get_lights.select{|x| x.connected }
      puts "Running with #{light_count} lights..."
    end

    def light_count
      @lights.count
    end

    def run
      @lights.each{|x| x.set_color("saturation:1 brightness:1", duration: 0)}
      while (true)
        (0...36).each do |color|
          @lights.each_with_index do |light, light_number|
            light.set_color(color_for_light(color * 10, light_number), duration: CYCLE_TIME)
          end
          sleep(CYCLE_TIME)
        end
      end
    end

    def color_for_light(base_color, index)
      offset = (360/light_count) * index
      "hue:#{((base_color) + offset) % 360}"
    end

  end
end
