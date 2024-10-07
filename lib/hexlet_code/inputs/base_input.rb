# frozen_string_literal: true

module HexletCode
  module Inputs
    class BaseInput
      def initialize(name, value, attributes = {})
        @name = name
        @value = value
        @attributes = attributes.except(:as)
      end

      def self.exclude_keys_from_hash(hash, *keys_to_exclude)
        result = {}
        hash.each do |key, value|
          result[key] = value unless keys_to_exclude.include?(key)
        end
        result
      end
    end
  end
end
