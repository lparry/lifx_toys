require 'json'
require 'forwardable'

class LifxLight

  extend Forwardable
  def_delegators :@data, :label, :connected, :power, :color, :brightness, :product_name, :last_seen, :seconds_since_seen

  attr_reader :light_id

  def self.get_lights
    @lights ||= HttpApi.get_light_info("all").map do |data|
      LifxLight.new(data)
    end
  end

  def initialize(data)
    @data = OpenStruct.new(data)
    @light_id = data["id"]
    @updated_at = Time.now
  end

  def set_color(color, brightness=0.5, duration=1.0)
    response = HttpApi.set_color(color, brightness, duration, selector)
    if response["status"] == "ok"
      puts "info: set #{label} to #{color}, #{brightness}, #{duration}" if ENV["DEBUG"]
      nil
    else
      puts "warning: light status - #{response}"
      -1
    end
  end

  def update_info
    @data ||= OpenStruct.new(HttpApi.get_light_info(selector))
    @updated_at = Time.now
  end

  def inspect
    "#<#{self.class.name} light_id=#{light_id.inspect} label=#{label.inspect} connected=#{connected.inspect} power=#{power.inspect} color=#{color.inspect} brightness=#{brightness.inspect} product_name=#{product_name.inspect} last_seen=#{last_seen.inspect} seconds_since_seen=#{seconds_since_seen.inspect} @updated_at=#{@updated_at}>"
  end

  private

  def selector
    "id:#{light_id}"
  end

  module HttpApi

    def self.set_color(color, brightness, duration, selector)
      JSON.parse(%x[curl -s -H "Authorization: Bearer #{ENV["LIFX_TOKEN"]}" -X PUT -d "color=#{color} brightness:#{brightness};duration=#{duration}" "https://api.lifx.com/v1beta1/lights/#{selector}/color"])
    end

    def self.get_light_info(selector)
    JSON.parse(%x[curl -s -H "Authorization: Bearer #{ENV["LIFX_TOKEN"]}" "https://api.lifx.com/v1beta1/lights/#{selector}"])
    end
  end


end
