json.array!(@countries) do |country|
  json.extract! country, :name, :dutchName, :isoAlpha2Code, :isoAlpha3Code, :isoNumericCode, :FIFAcode
  json.url country_url(country, format: :json)
end
