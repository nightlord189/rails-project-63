# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode - main module for the form generator
module HexletCode
  class Error < StandardError; end

  def self.form_for(obj, options = {})
    action = !options.key?(:url) ? "#" : options[:url]
    Tag.build("form", action: action, method: "post")

    builder = FormBuilder.new(obj, action)
    yield(builder) if block_given?

    builder.build
  end

  # FormBuilder - builds a form
  class FormBuilder
    attr_reader :action

    def initialize(obj, action)
      @action = action
      @obj = obj
      @form_content = ""
      @submit_text = ""
    end

    def input(name, attrs = {})
      puts "input #{name} #{attrs}"

      @form_content += Tag.build("label", for: name) { name.capitalize }

      value = @obj.public_send(name)

      tag_attrs = { "name": name }

      case attrs[:as]
      when :text
        build_textarea(value, tag_attrs, attrs)
      when nil
        build_input(value, tag_attrs, attrs)
      else
        raise "Unknown input type: #{attrs[:as]}"
      end
    end

    def submit(submit_text = "")
      @submit_text = submit_text
    end

    def build
      @submit_text = "Save" if @submit_text == ""
      @form_content += Tag.build("input", type: "submit", value: @submit_text)
      Tag.build("form", action: action, method: "post") { @form_content }
    end

    private

    def build_input(value, tag_attrs, attrs = {})
      tag_attrs["type"] = "text"
      tag_attrs["value"] = value
      tag_attrs = HexletCode.merge_tag_attributes tag_attrs, attrs
      @form_content += Tag.build("input", tag_attrs)
    end

    def build_textarea(value, tag_attrs, attrs = {})
      tag_attrs = tag_attrs.merge({ "cols": 20, "rows": 40 })
      tag_attrs = HexletCode.merge_tag_attributes tag_attrs, attrs
      @form_content += Tag.build("textarea", tag_attrs) { value }
    end
  end

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

  def self.merge_tag_attributes(current_attrs, all_attrs)
    all_attrs.each do |key, value|
      next if key == :as

      current_attrs[key] = value
    end
    current_attrs
  end
end
