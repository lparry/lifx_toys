require_relative 'http_api'

module LifxToys
  class LifxNetworkObject

    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    private

    def method_missing(method_name, *args)
      if HttpApi.respond_to? method_name
        HttpApi.public_send(method_name, selector, *args)
      else
        raise
      end
    end

    def make_request(method_name, *args)
      HttpApi.public_send(method_name, selector, *args)
    end
  end
end
