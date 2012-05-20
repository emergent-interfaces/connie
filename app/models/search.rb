class Search
  def initialize(text)
    @solr_search = Event.search do
      fulltext text
    end
  end

  def results
    @solr_search.results
  end
end
