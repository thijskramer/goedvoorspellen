class GroupsController < ApplicationController
  before_action :set_group, only: [:show]

  def index
    @groups = Group.all
  end

  def show
    @match_ids = @group.matches.collect { |x| x.id }
    match_idstring = @match_ids.join(',')
    players = Player.find_by_sql("SELECT DISTINCT p.* FROM players p INNER JOIN scores s on p.id = s.player_id WHERE s.match_id IN (" + match_idstring + ") AND s.is_own_goal = 0")
    @players_that_scored = players.sort { |x,y| 
      if y.groupgoals(@match_ids).length == x.groupgoals(@match_ids).length 
        x.lastName <=> y.lastName
      else 
        y.groupgoals(@match_ids).length <=> x.groupgoals(@match_ids).length 
      end
    } 
    @lastmatch = @group.matches.select { |m| m.startDate < DateTime.now }.sort { |a, b| b.startDate <=> a.startDate}.first
    @nextmatch = @group.matches.select { |m| m.startDate > DateTime.now }.sort { |a, b| a.startDate <=> b.startDate}.first
  end

  private
  def set_group
    @group = Group.friendly.find(params[:id])
  end
end
