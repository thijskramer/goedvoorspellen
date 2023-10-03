class StatsController < ApplicationController
  def index
    players = Player.find_by_sql("select p.*, count(s.id) as punten from players p inner join scores s on s.player_id = p.id group by p.id order by punten desc limit 1")
    firstplayer = players.first
    @numgoals = firstplayer.wkgoals.count
    @topscorers = Player.find_by_sql("select p.*, count(s.id) as wkgoals from players p inner join scores s on s.player_id = p.id group by p.id having wkgoals = " + @numgoals.to_s + " order by wkgoals desc")
    #
    scoringteams = Team.all.sort {|x, y| y.wkgoals <=> x.wkgoals }
    firstteam = scoringteams.first
    @numteamgoals = firstteam.wkgoals
    @scoringteams = scoringteams.select { |x| x.wkgoals == @numteamgoals }


    #temp
    @referee = Referee.all.to_a.sort {|x, y| y.ranking <=> x.ranking }.first

    clubs = Club.find_by_sql("select c.*, count(p.id) numplayers from clubs c inner join players p on p.club_id = c.id where p.inSquad = 1 and p.country_id in (select country_id from teams t) group by c.id order by numplayers desc")
    numplayers = clubs.first.wkplayers.length
    @clubs = clubs.select{ |x| x.wkplayers.count == numplayers }

    teams_ordered_by_age = Team.find_by_sql("SELECT t.*, AVG(TIMESTAMPDIFF(DAY, p.dateOfBirth, CURDATE())) AS age FROM players p inner join teams t on p.country_id = t.country_id where p.country_id in (select country_id from teams) and p.inSquad = 1 group by p.country_id order by age").to_a
    @jongsteteam = teams_ordered_by_age.first
    @oudsteteam = teams_ordered_by_age.last

    @avggoals = (Match.sum(:homeScore).to_f + Match.sum(:awayScore).to_f) / Match.count(:homeScore)
    mostbooked = Team.find_by_sql("select t.*, COUNT(b.id) as cards from teams t inner join players p on p.country_id = t.country_id inner join bookings b on b.player_id = p.id group by p.country_id order by cards desc")
    @mostbookedteam = mostbooked.first
    
    mostexperiencedteams = Team.find_by_sql("select t.*, avg(p.caps) as avgcaps from teams t inner join players p on t.country_id = p.country_id where p.inSquad = 1 group by t.country_id order by avgcaps desc")
    @mostexperiencedteam = mostexperiencedteams.first

  end

  def topscorers
    @players = Player.find_by_sql("select p.*, count(s.id) as wkgoals from players p inner join scores s on s.player_id = p.id where s.is_own_goal = 0 group by p.id having wkgoals > 1 order by wkgoals desc")
  end

  def teamgoals
    @teams = Team.all.sort {|x, y| y.wkgoals <=> x.wkgoals }
  end

  def clubs
    @clubs = Club.find_by_sql("select c.*, count(p.id) numplayers from clubs c inner join players p on p.club_id = c.id where p.inSquad = 1 and p.country_id in (select country_id from teams t) group by c.id order by numplayers desc limit 50")
  end
  
end