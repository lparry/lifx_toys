require 'forwardable'
require_relative 'lifx_network_object'

module LifxToys
  class LifxLight

    extend Forwardable
    def_delegators :@data, :label, :connected, :power, :color, :brightness, :product_name, :last_seen, :seconds_since_seen
    def_delegators :@network_object, :set_color

    attr_reader :light_id

    def self.get_lights
      @lights ||= LifxNetworkObject.new("all").get_info.map do |data|
        LifxLight.new(data)
      end
    end

    def initialize(data)
      @light_id = data["id"]
      @data = OpenStruct.new(data)
      @updated_at = Time.now
      @network_object = LifxNetworkObject.new(selector)
    end

    def update_info
      @data ||= OpenStruct.new(LifxNetworkObject.get_info(selector))
      @updated_at = Time.now
    end

    def inspect
      "#<#{self.class.name} light_id=#{light_id.inspect} label=#{label.inspect} connected=#{connected.inspect} power=#{power.inspect} color=#{color.inspect} brightness=#{brightness.inspect} product_name=#{product_name.inspect} last_seen=#{last_seen.inspect} seconds_since_seen=#{seconds_since_seen.inspect} @updated_at=#{@updated_at}>"
    end

    private

    def selector
      "id:#{light_id}"
    end

  end
end
