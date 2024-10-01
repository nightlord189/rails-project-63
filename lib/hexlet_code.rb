# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/form_builder'

# HexletCode - main module for the form generator
module HexletCode
  class Error < StandardError; end

  def self.form_for(obj, options = {})
    builder = FormBuilder.new(obj, options)
    yield(builder) if block_given?

    builder.build
  end
end
