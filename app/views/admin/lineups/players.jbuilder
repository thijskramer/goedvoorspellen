json.set! :homeplayers do
  json.array! @homeplayers do |player|
	  json.name player.fullname
	  json.id player.id
	  json.team_id @match.hometeam_id
	  json.position player.positionId
	  json.isPlaying @lineups.include?(player.id)
	  json.number player.number
	end
end
json.set! :awayplayers do
  json.array! @awayplayers do |player|
	  json.name player.fullname
	  json.id player.id
	  json.team_id @match.awayteam_id
	  json.position player.positionId
	  json.isPlaying @lineups.include?(player.id)
	  json.number player.number
	end
end
json.set! :homeTeamName, @match.hometeam.name
json.set! :awayTeamName, @match.awayteam.name