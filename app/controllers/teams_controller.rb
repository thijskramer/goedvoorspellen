class TeamsController < ApplicationController
  before_action :set_team, only: [:show]

  def index
    #@teams = Team.all.sort{ |a, b| a.stillplaying <=> b.stillplaying }
    @teams = Team.all.sort{ |a, b| 
        if b.matches.count == a.matches.count
            a.group_id <=> b.group_id
        else 
            b.matches.count <=> a.matches.count 
        end
        }
  end

  def show
    @lastmatch = @team.matches.select { |m| m.startDate < DateTime.now }.sort { |a, b| b.startDate <=> a.startDate}.first
    @nextmatch = @team.matches.select { |m| m.startDate > DateTime.now }.sort { |a, b| a.startDate <=> b.startDate}.first
    query = "
        SELECT c.name, co.isoAlpha2Code, COUNT(p.id) AS players FROM clubs AS c 
        INNER JOIN players AS p ON c.id = p.club_id 
        INNER JOIN countries AS co ON co.id = c.country_id 
        WHERE p.country_id = " + @team.country_id.to_s + " 
            AND p.inSquad IS TRUE 
        GROUP BY c.name 
        ORDER BY COUNT(p.id) DESC"
    @suppliers = ActiveRecord::Base.connection.execute(query)
    # result.each(:as => :hash) do |row| 
    #    puts row["name"] 
    # end
    # @players.each do |p|

    # end
  end

  private
    def set_team
      @team = Team.friendly.find(params[:id])
    end
end


