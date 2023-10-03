json.array!(@referees) do |referee|
  json.extract! referee, :firstName, :lastName, :dateOfBirth, :country_id, :isActive
  json.url referee_url(referee, format: :json)
end
