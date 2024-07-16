class FilterRecords
  def initialize(relation)
    @relation = relation
  end

  def call(params = nil)
    params.blank? ? @relation.all : search_filters(@relation, params)
  end

  def search_filters(relation, params)
    title, content = params[:title], params[:content]
    relation = filter_by_title(relation, title) if title
    relation = content_filter(content) if content
    relation
  end

  def filter_by_title(relation, value)
    relation.where('title ilike ?', "%#{value}%")
            .order(title: :desc)
  end

  def content_filter(words)
    query = <<-SQL
    SELECT
    MATCH(content) AGAINST(#{words} IN NATURAL LANGUAGE MODE) AS content
    FROM notes
    WHERE MATCH(content) AGAINST(#{words} IN NATURAL LANGUAGE MODE)
    ORDER BY title DESC;
    SQL
    ActiveRecord::Base.connection.execute(query).to_a
  end
end
