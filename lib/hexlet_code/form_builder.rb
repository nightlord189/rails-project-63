# frozen_string_literal: true

require_relative 'util'
require_relative 'inputs/base_input'
require_relative 'inputs/string_input'
require_relative 'inputs/text_input'

# FormBuilder - builds a form
class FormBuilder
  attr_reader :action, :method, :form_attributes, :submit_text, :inputs

  def initialize(entity, attributes = {})
    action = if attributes.key?(:url)
               attributes[:url]
             elsif attributes.key?(:action)
               attributes[:action]
             else
               '#'
             end
    method = attributes.key?(:method) ? attributes[:method] : 'post'
    filtered_attributes = exclude_keys_from_hash(attributes, :url)

    @entity = entity

    @action = action
    @method = method
    @form_attributes = filtered_attributes
    @submit_text = 'Save'
    @inputs = []
  end

  def input(name, attributes = {})
    puts "input #{name} #{attributes}"

    value = @entity.public_send(name)
    inputs << Input.new(name, value, attributes)
  end

  def submit(submit_text = 'Save')
    @submit_text = submit_text
  end
end

class Input
  attr_accessor :name, :value, :attributes

  def initialize(name, value, attributes = {})
    @name = name
    @value = value
    @attributes = attributes
  end
end
