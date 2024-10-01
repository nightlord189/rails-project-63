# frozen_string_literal: true

def merge_tag_attributes(current_attrs, all_attrs)
  all_attrs.each do |key, value|
    next if key == :as

    current_attrs[key] = value
  end
  current_attrs
end
