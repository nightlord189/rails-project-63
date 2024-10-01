# frozen_string_literal: true

# Tag - builds an HTML tag
class Tag
  def self.build(tag_name, attrs = {})
    attrs_strs = []
    attrs.each do |key, value|
      attrs_strs << "#{key}=\"#{value}\""
    end

    attrs_content = attrs_strs.any? ? " #{attrs_strs.join(" ")}" : ""

    content = block_given? ? yield : ""

    return "<#{tag_name}#{attrs_content}>" if single_tag?(tag_name)

    "<#{tag_name}#{attrs_content}>#{content}</#{tag_name}>"
  end

  def self.single_tag?(tag_name)
    %w[br img input].include? tag_name
  end
end
