class ProfessorsController < ApplicationController

    def sub_layout
      "professors"
    end

    def index
      unless (logged_in? && authorized?)
        redirect_back_or_default('/')
        return
      end
      @professors = Professor.find(:all, :conditions => {:review => true})

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @ratings }
      end

    end

    def new
        @professor = Professor.new
        @college = College.find_by_id params[:id]
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
        @professor = Professor.new(params[:professor])

        # Capitalize the first character of each string in prof name
        @professor.firstName = @professor.firstName.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
        @professor.lastName = @professor.lastName.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
        @professor.department = @professor.department.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }

        @professor.college_id = params[:college_id]
        @professor.review = true
        @college = College.find_by_id params[:college_id]
        respond_to do |format|
            if simple_captcha_valid?
              if @professor.save
                flash[:notice] = 'Successfully saved'
                format.html {redirect_to(@professor) }
              else
                format.html { render :action => "new", :id => params[:college_id] }
              end
            else
              flash[:notice] = "Please enter the characters in the image correctly and try again."
              format.html { render :action => "new", :id => params[:college_id]  }
            end
        end
    end

    def show
        @professor = Professor.find(params[:id])
        # Grab all the ratings of this professor
        #@ratings = Rating.find(:all, :conditions => {:professor_id => @professor.id, :pending => 1}, :order => 'created_at desc')
        @ratings = Rating.paginate :per_page => 10, :page => params[:page],
                                           :conditions => {:professor_id => @professor.id},
                                           :order => 'created_at desc'

        # Initialize rating so that student can rate right after seeing prof info.
        @rating = Rating.new
        respond_to do |format|
            format.html
        end
    end
end
