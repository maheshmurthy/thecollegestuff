module HomeHelper
    def getTopProfessorList
        # select top 10 professors who have atleast 5 comments
        # which are approved
#        Rails.cache.fetch('topProfessorList', :expires => 3600) { Professor.find(:all, :limit => 10)}
        Professor.find(:all, :joins => :ratings, :group => 'professor_id having count(ratings.id) > 2', :conditions => 'ratings.pending = false', :order => 'avg(ratings.avg) desc', :limit => 10)
    end

    def getTopCollegeList
        # select top 10 colleges ordered by average of profs
        # where each prof
        # has atleast 5 comments which are approved

        College.find(:all, :joins => :professors, :group => 'id having count(professors.id) > 1', :limit => 10)
#        professors=Professor.find(:all, :joins => :ratings, :group => 'professor_id having count(ratings.id) > 2', :conditions => 'ratings.pending = false', :order => 'avg(ratings.avg) desc')

#        collegeList={} 
#        colleges.each do |college|
#            logger.info "Came here"
#            college.professors.each do |prof|
#              logger.info "Came here as well"
#                  logger.info "*****************************************************************"
#                if professors.include?(prof)
#                    logger.info prof.ratings
#                    logger.info college
#                   collegeList[college] << prof.ratings 
#                end
#                  logger.info "*****************************************************************"
#            end
#        end
#
#        finalList=
#        collegeList.each do |college,ratings|
#           arrayN=[]
#           ratings.each do |rate| arrayN << rate.avg end
#           logger.info arrayN.inject(0){|sum,x| sum+x}/arrayN.length
#           finalList[arrayN.inject(0){|sum,x| sum+x}/arrayN.length] = college
#        end
#
#        newList = finalList.sort
#        if(newList.length < 10)
#            finalList.values
#        else
#        end
    end
end
