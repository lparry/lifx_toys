require_relative "lifx_light"
module LifxToys
  class Sunrise

    MIN_KELVIN = 2500
    MAX_KELVIN = 9000

    MIN_BRIGHTNESS = 0.0
    MAX_BRIGHTNESS = 1.0

    SUNRISE_TIME =  30 * # minutes
                    60.0   # seconds

    def initialize
      @lights = LifxNetworkObject.new('all')
    end

    # warning: this method takes half the sunrise time to execute
    def run
      # pre-set light color to avoid green at low brightness
      @lights.set_color("brightness:#{MIN_BRIGHTNESS} kelvin:#{MIN_KELVIN}", 0)
      @lights.set_color("brightness:#{MAX_BRIGHTNESS}", half_sunrise_time)
      sleep(half_sunrise_time)
      @lights.set_color("kelvin:#{MAX_KELVIN}", half_sunrise_time)
    end

    def half_sunrise_time
      SUNRISE_TIME / 2
    end
  end
end
