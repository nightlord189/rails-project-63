# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new name: "rob", job: "hexlet", gender: "m"
  end

  def test_custom_submit_text
    result = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job
      f.submit "Wow"
    end

    assert_equal read_fixture("custom_submit_text.html"), result
  end

  def test_form_additional_attrs
    result = HexletCode.form_for @user do |f|
      f.input :name, class: "user-input"
      f.input :job, as: :text
    end

    assert_equal read_fixture("additional_attributes.html"), result
  end

  def test_form_default_attrs
    result = HexletCode.form_for @user, url: "#" do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    assert_equal read_fixture("default_attributes.html"), result
  end

  def test_form_field_not_exists
    assert_raises(NoMethodError) do
      HexletCode.form_for @user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        # There is no "age" field
        f.input :age
      end
    end
  end

  def test_empty_form
    result = HexletCode.form_for(nil)
    assert_equal read_fixture("empty_form.html"), result
  end

  def test_form_with_attrs
    result = HexletCode.form_for(nil, method: "get", class: "hexlet-form")
    assert_equal read_fixture("form_with_attributes.html"), result
  end

  def test_form_with_url
    result = HexletCode.form_for(nil, url: "/users")
    assert_equal read_fixture("form_with_url.html"), result
  end
end

class TestTag < Minitest::Test
  def test_br
    result = Tag.build("br")
    assert_equal "<br>", result
  end

  def test_input
    result = Tag.build("input", type: "submit", value: "Save")
    assert_equal '<input type="submit" value="Save">', result
  end

  def test_label
    result = Tag.build("label", for: "email") { "Email" }
    assert_equal '<label for="email">Email</label>', result
  end

  def test_label_without_attrs
    result = Tag.build("label") { "Email" }
    assert_equal "<label>Email</label>", result
  end
end
