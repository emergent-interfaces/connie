class SearchesController < ApplicationController
  respond_to :html, :json

  def show
    @search = Search.new(params["text"])
    puts @search.results

    respond_to do |format|
      format.html
      format.json { render :json => @search.results }
    end
  end
end
