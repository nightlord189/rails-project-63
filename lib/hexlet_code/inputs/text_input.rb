# frozen_string_literal: true

module HexletCode
  module Inputs
    class TextInput < BaseInput
      TAG_NAME = 'textarea'
      COLS = 20
      ROWS = 40

      def build
        @attributes = { name: @name, cols: COLS, rows: ROWS }.merge(@attributes)
        Tag.build(TAG_NAME, @attributes) { @value }
      end
    end
  end
end
