class SearchesController < ApplicationController
  def show
    @search = Search.new(params["text"])
  end
end
