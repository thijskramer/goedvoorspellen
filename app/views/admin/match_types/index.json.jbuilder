json.array!(@match_types) do |match_type|
  json.extract! match_type, :name
  json.url match_type_url(match_type, format: :json)
end
