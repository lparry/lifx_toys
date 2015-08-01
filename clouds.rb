require_relative "lifx_light"

class Clouds

  MIN_KELVIN = 2500
  MAX_KELVIN = 9000

  MIN_BRIGHTNESS = 10
  MAX_BRIGHTNESS = 100

  CYCLE_TIME = 5.0

  def initialize
    @lights = LifxLight.get_lights.select{|x| x.connected }
  end

  def run
    while (true)
      @lights.each do |light|
        light.set_color("kelvin:#{random_kelvin} brightness:#{random_brightness}", CYCLE_TIME* 1.5)
        sleep(CYCLE_TIME/ @lights.count)
      end
    end
  end

  def random_kelvin
    rand(MIN_KELVIN..MAX_KELVIN)
  end

  def random_brightness
    rand(MIN_BRIGHTNESS..MAX_BRIGHTNESS).to_f / 100
  end
end

Clouds.new.run
