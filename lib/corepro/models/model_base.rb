require_relative 'json_base'
require 'uri'

module CorePro
  module Models
    class ModelBase < JsonBase
      attr_accessor :requestId

      def self.escape(val)
        if val.to_s.empty?
          ''
        else
          URI::escape(val)
        end
      end

      def to_s
        vars = self.instance_variables.map{|v|
            "#{v}=#{instance_variable_get(v).inspect}"
        }.join(", ")
        "<#{self.class}: #{vars}>"
      end

      # Alias camel cased methods with snake case
      def method_missing(method, *args, &block)
        return super(method, *args, &block) unless respond_to?(method) # throw NoMethodFound error
        self.send(camelized_method(method), *args, &block)
      end

      def respond_to?(method, *args)
        super(method, *args) || super(camelized_method(method), *args)
      end

      private

      def camelized_method(method)
        method.to_s.camelize(:lower).to_sym
      end

    end
  end
end
