json.array!(@teams) do |team|
  json.extract! team, :country_id, :FIFAranking, :associationFull, :associationAbbreviation, :coach_id
  json.url team_url(team, format: :json)
end
