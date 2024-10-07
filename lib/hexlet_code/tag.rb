# frozen_string_literal: true

module HexletCode
  class Tag
    SINGLE_TAGS = %w[input img br].freeze

    def self.build(tag_name, attrs = {})
      attrs_strs = []
      attrs.each do |key, value|
        attrs_strs << "#{key}=\"#{value}\""
      end

      attrs_content = attrs_strs.any? ? " #{attrs_strs.join(' ')}" : ''

      content = block_given? ? yield : ''

      return "<#{tag_name}#{attrs_content}>" if SINGLE_TAGS.include?(tag_name)

      "<#{tag_name}#{attrs_content}>#{content}</#{tag_name}>"
    end
  end
end
