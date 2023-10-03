class Participation < ActiveRecord::Base
    belongs_to :poule
    belongs_to :user
end
