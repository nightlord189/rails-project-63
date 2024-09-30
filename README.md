# HexletCode

[![Actions Status](https://github.com/nightlord189/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/nightlord189/rails-project-63/actions)

Gem for generating an html form. Test Project #1 by Ruby profession on hexlet.io.

# Example:
```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

HexletCode.form_for user, url: '/action' do |f|
  f.input :name
  f.input :job, as: :text
  f.submit 'Send'
end
```

will return
```html
<form action="/action" method="post">
    <label for="name">Name</label>
    <input name="name" type="text" value="rob">
    <label for="job">Job</label>
    <textarea name="job" cols="20" rows="40">hexlet</textarea>
    <input type="submit" value="Send">
</form>
```
You can customize:
+ inputs and its options
+ url of the form
+ text of the Submit button
