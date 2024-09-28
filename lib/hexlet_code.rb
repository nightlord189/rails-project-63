# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # Tag - builds an HTML tag
  class Tag
    def self.build(tag_name, attrs = {})
      attrs_strs = []
      attrs.each do |key, value|
        attrs_strs << "#{key}=\"#{value}\""
      end
      return "<#{tag_name} #{attrs_strs.join(" ")}>" if attrs_strs.any?

      "<#{tag_name}>"
    end
  end
end
