require_relative 'json_base'
require_relative 'customer_answer'
module CorePro
  module Models
    class CustomerQuestion < JsonBase
      attr_accessor :answers
      attr_accessor :prompt
      attr_accessor :type

      def from_json! json, classDefs
        classDefs = classDefs || {}
        super json, classDefs
      end

      def initialize
        super
        @answers = []
      end
    end
  end
end
