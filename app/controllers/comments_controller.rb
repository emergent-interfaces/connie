class CommentsController < ApplicationController
  def new
    @commentable = Comment.find(params[:parent_id]).commentable if params[:parent_id]
    @parent = Comment.find(params[:parent_id]) if params[:parent_id]
    @comment = Comment.build_from(@commentable, current_user.id, "")
    @comment.subject = "Re: #{@parent.subject}"
    @comment.parent = @parent
  end

  def create
    @comment = Comment.new(params[:comment])
    @commentable = @comment.commentable

    if @comment.save!
      redirect_to @commentable
    else
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy
    redirect_to @commentable
  end
end