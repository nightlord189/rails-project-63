# frozen_string_literal: true

module HexletCode
  module Inputs
    class StringInput < BaseInput
      TAG_NAME = 'input'

      def build
        @attributes = { name: @name, type: 'text', value: @value }.merge(@attributes)
        Tag.build(TAG_NAME, @attributes)
      end
    end
  end
end
