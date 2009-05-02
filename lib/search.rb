# This is an add-on to the ActiveRecord::Base class.  It allows simple searching to be
# accomplished by using, for example, @movies = Movie.search("text")

module ActiveRecord
  class Base
# Allow the user to set the default searchable fields
def self.searches_on(*args)
      if not args.empty? and args.first != :all
        @searchable_fields = args.collect { |f| f.to_s }
      end
    end
    # Return the default set of fields to search on
    def self.searchable_fields(tables = nil, klass = self)
        # If the model has declared what it searches_on, then use that...
        return @searchable_fields unless @searchable_fields.nil?

        # ... otherwise, use all text/varchar fields as the default
        fields = []
      tables ||= []
      string_columns = klass.columns.select { |c| c.type == :text or c.type == :string }
      fields = string_columns.collect { |c| klass.table_name + "." + c.name }

      if not tables.empty?
        tables.each do |table|
          klass = eval table.to_s.classify
          fields += searchable_fields([], klass)
        end
      end
      
      return fields
    end

    def self.search(text = nil, options = {})
          options.assert_valid_keys(:only, :except, :case, :include,
                                  :join_include, :conditions, :offset, :limit, :order)
                                        case_insensitive = true unless options[:case] == :sensitive
          fields = options[:only] || searchable_fields(options[:include])
          fields -= options[:except] if not options[:except].nil?
        
        condition_list = []
      unless text.nil?
        text_condition = if case_insensitive
          fields.collect { |f| "UCASE(#{f}) LIKE #{sanitize('%'+text.upcase+'%')}" }.join " OR "
        else
          fields.collect { |f| "#{f} LIKE #{sanitize('%'+text+'%')}" }.join " OR "
        end
        condition_list << "(" + text_condition + ")"
      end
      condition_list << "#{options[:conditions]}" if options[:conditions]
      conditions = condition_list.join " AND "
      conditions = nil if conditions.empty?

      includes = (options[:include] || []) + (options[:join_include] || [])
      includes = nil if includes.size == 0
      
      find :all, :include => includes, :conditions => conditions,
           :offset => options[:offset], :limit => options[:limit], :order => options[:order]
    end
  end
end


