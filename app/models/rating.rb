class Rating < ActiveRecord::Base
    belongs_to :professor
    belongs_to :user
end
