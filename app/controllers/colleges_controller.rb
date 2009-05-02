class CollegesController < ApplicationController
    
    def sub_layout
      "colleges"
    end

    def new
        @college = College.new
        if logged_in?
        respond_to do |format|
            format.html 
        end
        else
          store_location
          redirect_to_login_page
        end
    end

    def create
        @college = College.new(params[:college])
        @college.name = @college.name.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
        @college.city = @college.city.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
        @college.state = @college.state.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
        @college.review = true

        respond_to do |format|
            if simple_captcha_valid?
              if @college.save
                flash[:notice] = 'Successfully saved'
                format.html {redirect_to(@college) }
              else
                format.html { render :action => "new" }
              end
            else
              flash[:notice] = "Please enter the characters in the image correctly and try again."
              format.html { render :action => "new" }
            end
        end
    end

    def all
        @colleges= College.paginate :per_page => 15, :page => params[:page], :order => 'name asc'
        respond_to do |format|
            format.html
        end
    end

    def show
        @college = College.find(params[:id])

        @professorList = Professor.find(:all, :conditions => {:college_id => @college.id}, :order => 'firstName asc')

        respond_to do |format|
            format.html
        end
    end
end
