# frozen_string_literal: true

require_relative 'util'
require_relative 'inputs/base_input'
require_relative 'inputs/string_input'
require_relative 'inputs/text_input'
autoload(:Tag, 'hexlet_code/tag.rb')

# FormBuilder - builds a form
class FormBuilder
  def initialize(entity, form_attrs)
    @form_attrs = FormBuilder.transform_form_attrs(form_attrs)
    @entity= entity
    @form_content = ''
    @submit_text = ''
  end

  def self.transform_form_attrs(all_attrs)
    action = if all_attrs.key?(:url)
               all_attrs[:url]
             elsif all_attrs.key?(:action)
               all_attrs[:action]
             else
               '#'
             end

    method = all_attrs.key?(:method) ? all_attrs[:method] : 'post'

    form_attrs = { action:, method: }
    all_attrs.each do |key, value|
      next if [:url].include?(key)

      form_attrs[key] = value
    end

    form_attrs
  end

  def input(name, attributes = {})
    puts "input #{name} #{attributes}"

    value = @entity.public_send(name)

    @form_content += Tag.build('label', for: name) { name.capitalize }

    input_name = "#{attributes.fetch(:as, 'string').to_s.capitalize}Input"
    input_class = HexletCode::Inputs.const_get(input_name)
    input_instance = input_class.new(name, value, attributes)
    @form_content += input_instance.build
  end

  def submit(submit_text = '')
    @submit_text = submit_text
  end

  def build
    @submit_text = 'Save' if @submit_text == ''
    @form_content += Tag.build('input', type: 'submit', value: @submit_text)
    Tag.build('form', @form_attrs) { @form_content }
  end
end
