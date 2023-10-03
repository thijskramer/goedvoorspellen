class RankingsController < ApplicationController
  def index
    #  userPageStr = params[:p]
    #  userpage = 1 if userPageStr.nil?
    #  unless userPageStr.nil?
    #     userpage = userPageStr.to_i if userPageStr.match(/^\d+$/)
    # end

     @total_poules = Poule.count
     # @pouleranking = Poule.order(points: :desc).limit(50).offset(0)
     @pouleranking = Poule.order(points: :desc).all

     # items_per_page = 50
     # @total_users = User.valid.count
     # @curr_page = userpage
     # @total_pages = (@total_users.to_f / items_per_page.to_f).ceil
     # if @curr_page > @total_pages 
     #    @curr_page = @total_pages
     # end
     # offset = (@curr_page - 1) * items_per_page
     @userranking = User.valid.order(points: :desc)
     # @userranking = User.order(points: :desc).valid.limit(items_per_page).offset(offset)
     
  end
end
