# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "hexlet_code"

require "minitest/autorun"

def read_fixture(name)
  result = File.read(File.join(__dir__, "fixtures", name))
  result.gsub("\n", "").gsub("\t", "").gsub("  ", "")
end
