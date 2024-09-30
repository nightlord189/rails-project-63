# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_form_user
    user = User.new name: "rob", job: "hexlet", gender: "m"

    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end

    expected = '<form action="#" method="post"><input name="name" type="text" value="rob">' \
               '<textarea name="job" cols="20" rows="40">hexlet</textarea></form>'

    assert_equal expected, result
  end

  def test_form_additional_attrs
    user = User.new name: "rob", job: "hexlet", gender: "m"

    result = HexletCode.form_for user do |f|
      f.input :name, class: "user-input"
      f.input :job, as: :text
    end

    expected = '<form action="#" method="post"><input name="name" type="text" value="rob" class="user-input">' \
    '<textarea name="job" cols="20" rows="40">hexlet</textarea></form>'

    assert_equal expected, result
  end

  def test_form_default_attrs
    user = User.new name: "rob", job: "hexlet", gender: "m"

    result = HexletCode.form_for user, url: "#" do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    expected = '<form action="#" method="post"><textarea name="job" cols="50" rows="50">hexlet</textarea></form>'

    assert_equal expected, result
  end

  def test_form_field_not_exists
    user = User.new name: "rob", job: "hexlet", gender: "m"

    assert_raises(NoMethodError) do
      HexletCode.form_for user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        # Поля age у пользователя нет
        f.input :age
      end
    end
  end

  def test_empty_form
    result = HexletCode.form_for(nil)
    assert_equal "<form action=\"#\" method=\"post\"></form>", result
  end

  def test_form_with_url
    result = HexletCode.form_for(nil, url: "/users")
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
