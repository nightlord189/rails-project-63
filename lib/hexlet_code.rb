# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode - main module for the form generator
module HexletCode
  autoload(:FormBuilder, 'hexlet_code/form_builder')

  class Error < StandardError; end

  def self.form_for(entity, options = {})
    builder = FormBuilder.new(entity, options)
    yield(builder) if block_given?

    builder.build
  end
end
