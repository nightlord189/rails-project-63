# frozen_string_literal: true

module HexletCode
  module Inputs
    class BaseInput
      def initialize(name, value, attributes = {})
        @name = name
        @value = value
        @attributes = exclude_keys_from_hash(attributes, :as)
        puts "input initialized, name: #{@name}, value: #{@value}, attributes: #{@attributes}"
      end
    end
  end
end

