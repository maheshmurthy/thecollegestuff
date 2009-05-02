class Professor < ActiveRecord::Base
    belongs_to :college
    validates_presence_of :firstName, :department, :college_id
    validates_uniqueness_of :firstName, :scope => [:lastName, :college_id, :department], :message => 'The professor you are trying to add already exists for the department. Please check the name and try again'
    validates_uniqueness_of :lastName, :scope => [:firstName, :college_id, :department], :message => 'The professor you are trying to add already exists for the department. Please check the name and try again'
    has_many :ratings

    def self.all_cached
       Professor.find(:all, :joins => :ratings, :group => 'professor_id having count(ratings.id) > 2', :conditions => 'ratings.pending = 0', :order => 'avg(ratings.avg) desc', :limit => 10) 
    end
end
