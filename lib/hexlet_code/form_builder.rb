# frozen_string_literal: true

module HexletCode
  class FormBuilder
    attr_reader :form_body

    def initialize(entity, attributes = {})
      action = attributes.fetch(:url, '#')
      method = attributes.fetch(:method, 'post')

      @entity = entity

      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: { action:, method: }.merge(attributes.except(:url, :method))
      }
    end

    def input(name, attributes = {})
      value = @entity.public_send(name)
      @form_body[:inputs] << { name:, value:, attributes: }
    end

    def submit(submit_text = 'Save')
      @form_body[:submit][:text] = submit_text
    end
  end
end
