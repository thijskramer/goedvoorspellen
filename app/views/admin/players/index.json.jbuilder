json.array!(@players) do |player|
  json.extract! player, :firstName, :lastName, :country_id, :position, :club_id, :number, :isCaptain, :isViceCaptain, :caps, :goals, :dateOfBirth, :inSquad
  json.url player_url(player, format: :json)
end
