module RatingsHelper
    def avgRating(ratings)
        sumOfAverages = 0
        if ratings.empty?
            return 0
        end
        ratings.each do |rating|
            sumOfAverages += rating.avg
        end
        (sumOfAverages/@ratings.size).round(2)
    end

    def getQuestion(index, level)
        case index
        when 0
            content = case level
            when 1: "I didn't understand anything he/she teached"
            when 2: "I barely understood the class"
            when 3: "He/She's alright, I kinda get it"
            when 4: "He/She communicates reasonably well"
            when 5: "His/Her communication skills are top notch"
            end
        when 1
            content = case level
            when 1: "He/she has no clue about the subject"
            when 2: "He/she knows bare minimum about the subject"
            when 3: "He/she has reasonable knowledge of the subject"
            when 4: "Very knowledgeable about the subject"
            when 5: "He/She is expert in that subject"
            end
        when 2
            content = case level
            when 1: "I hardly saw him/her in the department"
            when 2: "Not too enthusiastic in clarifying doubts"
            when 3: "Does an ok job"
            when 4: "Does a good job in clarifying doubts"
            when 5: "Goes above and beyond to help students"
            end
        when 3
            content = case level
            when 1: "Hardly anything was covered"
            when 2: "Covered some parts of it"
            when 3: "Covered a decent amount"
            when 4: "Did a pretty good job of covering the syallabus"
            when 5: "The entire syllabus was covered well ontime"
            end
        end
    end

    def getHeading(index)
        heading = case index
        when 0: "Communication Skills"
        when 1: "Knowledge"
        when 2: "Helpful/Accessible"
        when 3: "Syllabus Coverage"
        when 4: "Comments"
        end
    end
end
