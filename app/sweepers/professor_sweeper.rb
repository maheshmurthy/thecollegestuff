class ProfessorSweeper < ActionController::Caching::Sweeper

  observe Professor

  def after_create(professor)
    expire_college_page(profesor.college_id)
  end

  private

  def expire_college_page(collegeId)
    expire_page :controller => "colleges", :action => "show", :id => collegeId 
  end

end
