class SearchesController < ApplicationController
  respond_to :html, :json

  def show
    @search = Search.new(params["text"]).solr_search
    jump_to_match = params["jump_to_match"]

    respond_to do |format|
      format.html
        if jump_to_match == "true" and @search.results.count > 0
          redirect_to @search.results[0] and return
        end
      format.json do
        @results = @search.results.collect{|result| result[:class_name] = result.class.name}
        render :json => @search.results
      end
    end
  end
end
