require_relative "lifx_light"

class Colors

  HUE_RANGE = 0..360
  BRIGHTNESS_RANGE = 20..80
  SATURATION_RANGE = 20..100

  CYCLE_TIME = 10.0

  def initialize
    @lights = LifxLight.get_lights.select{|x| x.connected }
  end

  def run
    while (true)
      @lights.each do |light|
        light.set_color("hue:#{random_hue} saturation:#{random_saturation} brightness:#{random_brightness}", CYCLE_TIME* 1.5)
        sleep(CYCLE_TIME/ @lights.count)
      end
    end
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

Colors.new.run
