# HexletCode

[![Actions Status](https://github.com/nightlord189/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/nightlord189/rails-project-63/actions)

Gem for generating an html form. Test Project #1 by Ruby profession on hexlet.io.

# Example:
```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

HexletCode.form_for user do |f|
  f.input :name
  f.input :job, as: :text
end
```

will return
```html
<form action="#" method="post">
   <input name="name" type="text" value="rob">
   <textarea name="job" cols="20" rows="40">hexlet</textarea>
</form>
```
