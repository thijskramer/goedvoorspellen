json.array!(@clubs) do |club|
  json.extract! club, :name, :country_id
  json.url club_url(club, format: :json)
end
