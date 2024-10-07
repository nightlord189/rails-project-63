# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode - main module for the form generator
module HexletCode
  autoload(:FormBuilder, 'hexlet_code/form_builder')
  autoload(:FormRender, 'hexlet_code/form_render')
  autoload(:Tag, 'hexlet_code/tag')

  class Error < StandardError; end

  def self.form_for(entity, options = {})
    builder = FormBuilder.new(entity, options)
    yield(builder) if block_given?

    FormRender.render_html(builder)
  end
end
