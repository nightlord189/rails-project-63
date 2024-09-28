# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  def test_form
    result = HexletCode.form_for(nil)
    assert_equal "<form action=\"#\" method=\"post\"></form>", result
  end

  def test_form_with_url
    result = HexletCode.form_for(nil, "/users")
    assert_equal "<form action=\"/users\" method=\"post\"></form>", result
  end
end

class TestTag < Minitest::Test
  def test_br
    result = HexletCode::Tag.build("br")
    assert_equal "<br>", result
  end

  def test_input
    result = HexletCode::Tag.build("input", type: "submit", value: "Save")
    assert_equal '<input type="submit" value="Save">', result
  end

  def test_label
    result = HexletCode::Tag.build("label", for: "email") { "Email" }
    assert_equal '<label for="email">Email</label>', result
  end

  def test_label_without_attrs
    result = HexletCode::Tag.build("label") { "Email" }
    assert_equal "<label>Email</label>", result
  end
end
