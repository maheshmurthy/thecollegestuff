require_dependency "search"

class College < ActiveRecord::Base
    validates_presence_of :name, :city, :state
    validates_uniqueness_of :name, :scope => [:city, :state], :message => 'The college entry you are trying to add already exists. Please check the name and try again.'
    has_many :professors
    has_many :ratings
    searches_on :name
end
