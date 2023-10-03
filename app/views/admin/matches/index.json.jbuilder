json.array!(@matches) do |match|
  json.extract! match, :number, :matchtype_id, :hometeam_id, :awayteam_id, :homePlaceholder, :awayPlaceholder, :homeScore, :awayScore, :stadium_id, :referee_id, :startDate, :startDateUtcOffset
  json.url match_url(match, format: :json)
end
