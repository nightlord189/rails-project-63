# frozen_string_literal: true

require_relative "tag"
require_relative "util"

# FormBuilder - builds a form
class FormBuilder
  def initialize(obj, form_attrs)
    @form_attrs = FormBuilder.transform_form_attrs(form_attrs)
    @obj = obj
    @form_content = ""
    @submit_text = ""
  end

  def self.transform_form_attrs(all_attrs)
    action = if all_attrs.key?(:url)
               all_attrs[:url]
             elsif all_attrs.key?(:action)
               all_attrs[:action]
             else
               "#"
             end

    method = all_attrs.key?(:method) ? all_attrs[:method] : "post"

    form_attrs = { action: action, method: method }
    all_attrs.each do |key, value|
      next if [:url].include?(key)

      form_attrs[key] = value
    end

    form_attrs
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
    Tag.build("form", @form_attrs) { @form_content }
  end

  private

  def build_input(value, tag_attrs, attrs = {})
    tag_attrs["type"] = "text"
    tag_attrs["value"] = value
    tag_attrs = merge_tag_attributes tag_attrs, attrs
    @form_content += Tag.build("input", tag_attrs)
  end

  def build_textarea(value, tag_attrs, attrs = {})
    tag_attrs = tag_attrs.merge({ "cols": 20, "rows": 40 })
    tag_attrs = merge_tag_attributes tag_attrs, attrs
    @form_content += Tag.build("textarea", tag_attrs) { value }
  end
end
