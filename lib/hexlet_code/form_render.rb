# frozen_string_literal: true

require_relative 'inputs'

module HexletCode
  autoload(:Tag, 'hexlet_code/tag')

  class FormRender
    def self.render_html(form_builder)
      form_content = ''

      form_builder.form_body[:inputs].each do |input|
        form_content += HexletCode::Tag.build('label', for: input[:name]) { input[:name].capitalize } # label
        form_content += build_input(input)
      end

      submit_text = form_builder.form_body[:submit].fetch(:text, 'Save')
      form_content += HexletCode::Tag.build('input', type: 'submit', value: submit_text)

      build_form(form_builder, form_content)
    end

    def self.build_form(form_builder, form_content)
      HexletCode::Tag.build('form', form_builder.form_body[:form_options]) { form_content }
    end

    def self.build_input(input)
      input_name = "#{input[:attributes].fetch(:as, 'string').to_s.capitalize}Input"
      input_class = HexletCode::Inputs.const_get(input_name)
      input_instance = input_class.new(input[:name], input[:value], input[:attributes])
      input_instance.build
    end
  end
end
