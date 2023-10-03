json.array!(@coaches) do |coach|
  json.extract! coach, :firstName, :lastName, :country_id
  json.url coach_url(coach, format: :json)
end
