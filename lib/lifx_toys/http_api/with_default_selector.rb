require_relative 'http_api'

module LifxToys
  module HttpApi

    class WithDefaultSelector

      attr_reader :selector

      def initialize(selector)
        @selector = selector
      end

      private

      def method_missing(method_name, *args)
        if ::LifxToys::HttpApi.respond_to? method_name
          ::LifxToys::HttpApi.public_send(method_name, selector, *args)
        else
          raise
        end
      end

      def make_request(method_name, *args)
        HttpApi.public_send(method_name, selector, *args)
      end
    end

  end
end
