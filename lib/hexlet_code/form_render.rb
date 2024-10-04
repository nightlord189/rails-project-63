# frozen_string_literal: true

autoload(:Tag, 'hexlet_code/tag')

class FormRender
  def self.render_html(form_builder)
    puts 'render_html'

    form_content = ''

    form_builder.inputs.each do |input|
      form_content += Tag.build('label', for: input.name) { input.name.capitalize } # label
      form_content += build_input(input)
    end

    form_content += Tag.build('input', type: 'submit', value: form_builder.submit_text)

    build_form(form_builder, form_content)
  end

  def self.build_form(form_builder, form_content)
    final_form_attributes = { action: form_builder.action,
                              method: form_builder.method }.merge(form_builder.form_attributes)
    Tag.build('form', final_form_attributes) { form_content }
  end

  def self.build_input(input)
    input_name = "#{input.attributes.fetch(:as, 'string').to_s.capitalize}Input"
    input_class = HexletCode::Inputs.const_get(input_name)
    input_instance = input_class.new(input.name, input.value, input.attributes)
    input_instance.build
  end
end
