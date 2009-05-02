class HomeController < ApplicationController

    protect_from_forgery :only => [:create, :update, :destroy] 
    auto_complete_for :college, :name
    def sub_layout
      "home"
    end

    def about
    end

    def index 
        if params[:name]
            if params[:name].strip.length != 0
#                @colleges = College.search params[:name].strip
              @colleges = College.paginate :per_page => 10, :page => params[:page],
                                           :conditions => ['name like ?', "%#{params[:name].strip}%"],
                                           :order => 'name'
            end
        end
    end

    def search  
        if params[:name]
            if params[:name].strip.length != 0
#                @colleges = College.search params[:name].strip
              @colleges = College.paginate :per_page => 10, :page => params[:page],
                                           :conditions => ['name like ?', "%#{params[:name].strip}%"],
                                           :order => 'name',
                                           :group => 'name'
            end
        end
    render :layout => false
    end
end
