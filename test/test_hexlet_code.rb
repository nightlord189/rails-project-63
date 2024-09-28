# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  def test_br
    result = HexletCode::Tag.build("br")
    assert_equal "<br>", result
  end

  def test_input
    result = HexletCode::Tag.build("input", type: "submit", value: "Save")
    assert_equal '<input type="submit" value="Save">', result
  end
end
