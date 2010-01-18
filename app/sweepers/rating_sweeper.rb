class RatingSweeper < ActionController::Caching::Sweeper
  observe Rating

  def after_create(rating)
    expire_professor_page(rating.professor_id)
  end

  def after_update(rating)
    expire_professor_page(rating.professor_id)
  end

  private

  def expire_professor_page(professorId)
    expire_page :controller => "professors", :action => "show", :id => professorId
  end
end
