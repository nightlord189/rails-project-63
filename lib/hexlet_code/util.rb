# frozen_string_literal: true

def merge_tag_attributes(current_attrs, all_attrs)
  all_attrs.each do |key, value|
    next if key == :as

    current_attrs[key] = value
  end
  current_attrs
end

def exclude_keys_from_hash(hash, *keys_to_exclude)
  result = {}
  hash.each do |key, value|
    result[key] = value unless keys_to_exclude.include?(key)
  end
  result
end
