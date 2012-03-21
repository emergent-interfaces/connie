class TagGroupsController < ApplicationController
  def index
    @tag_groups = TagGroup.all
  end
end
