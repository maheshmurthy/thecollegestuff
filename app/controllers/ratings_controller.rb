class RatingsController < ApplicationController
  
  cache_sweeper :rating_sweeper,
                :only => [ :approve,
                           :create ]
  def sub_layout
    "ratings"
  end

  # GET /ratings
  # GET /ratings.xml
  def index
    unless (logged_in? && authorized?)
      redirect_back_or_default('/')
      return
    end
    @ratings = Rating.find(:all, :conditions => {:pending => true})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ratings }
    end
  end

  def approve
    @rating = Rating.find(params[:id])
    @rating.update_attribute :pending, "false"
    @ratings = Rating.find(:all, :conditions => {:pending => true})
    render :partial => "rating", :object => @ratings, :layout => false
  end
  
  # GET /ratings/1
  # GET /ratings/1.xml
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.xml
  def new
    @professor = Professor.find(params[:id])
    session[:professor] = @professor
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.xml
  def create
    unless simple_captcha_valid?
        flash[:notice] = 'Please make sure the entered the characters in the image correctly and try again.'
        respond_to do |format|
          format.html { render :action => "new" }
        end
    else
    @professor = session[:professor]
    @rating = Rating.new
    @rating.q1 = params[:q0].to_i
    @rating.q2 = params[:q1].to_i
    @rating.q3 = params[:q2].to_i
    @rating.q4 = params[:q3].to_i
    @rating.comments = params[:comments]
    @rating.college_id = @professor.college_id
    @rating.professor_id = @professor.id
    if @rating.comments == ""
      @rating.pending = false
    else
      @rating.pending = true
    end
    if params[:showname]
      @rating.showname = false
    else
      @rating.showname = true
    end
    user = User.find_by_id(session[:user_id])
    unless user.nil?
      @rating.login = user.login
    end
    @rating.avg = (@rating.q1 + @rating.q2 + @rating.q3 + @rating.q4) / 4.0
    respond_to do |format|
      if @rating.save
        flash[:notice] = 'Rating was successfully created.'
        format.html { redirect_to('/')}
        format.xml  { render :xml => @rating, :status => :created, :location => @rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.xml
  def update
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        flash[:notice] = 'Rating was successfully updated.'
        format.html { redirect_to(@rating) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.xml
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to(ratings_url) }
      format.xml  { head :ok }
    end
  end
end
