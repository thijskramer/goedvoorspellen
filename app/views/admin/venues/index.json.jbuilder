json.array!(@venues) do |venue|
  json.extract! venue, :name, :city, :latitude, :longitude, :capacity, :wikipediaUrl
  json.url venue_url(venue, format: :json)
end
