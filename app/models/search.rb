class Search
  attr_reader :solr_search

  def initialize(text)
    @solr_search = Sunspot.search Convention, Event, Space, Profile do
      fulltext text
    end
  end
end
