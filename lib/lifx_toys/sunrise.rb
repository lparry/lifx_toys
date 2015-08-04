require "lifx_http"
module LifxToys
  class Sunrise

    MIN_KELVIN = 2500
    MAX_KELVIN = 9000

    MIN_BRIGHTNESS = 0.0
    MAX_BRIGHTNESS = 1.0

    SUNRISE_TIME =  30 * # minutes
                    60.0   # seconds

    attr_reader :sunrise_time,
                :start_brightness,
                :start_temperature,
                :end_brightness,
                :end_temperature

    def initialize(selector = 'all',
                   sunrise_time = SUNRISE_TIME,
                   start_brightness = MIN_BRIGHTNESS,
                   start_temperature = MIN_KELVIN,
                   end_brightness = MAX_BRIGHTNESS,
                   end_temperature = MAX_KELVIN)

      @sunrise_time = sunrise_time
      @start_brightness = start_brightness
      @start_temperature = start_temperature
      @end_brightness = end_brightness
      @end_temperature = end_temperature

      @lights = LifxHttp::Api.with_default_selector(selector)
    end

    # warning: this method takes half the sunrise time to execute
    def run
      # pre-set light color to avoid green at low brightness
      @lights.set_color("brightness:#{start_brightness} kelvin:#{start_temperature}", duration: 0, power_on: false)
      @lights.set_color("brightness:#{end_brightness}", duration: half_sunrise_time)
      sleep(half_sunrise_time)
      @lights.set_color("kelvin:#{end_temperature}", duration: half_sunrise_time)
    end

    def half_sunrise_time
      sunrise_time / 2
    end
  end
end
