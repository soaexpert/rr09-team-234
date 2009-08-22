class CommentsController < ApplicationController
  before_filter :require_login
  
  def create
    @comment = Comment.new(params[:comment])
    
    if @comment.save
      flash[:notice] = "Thanks for the comment"
      redirect_to event_path(@comment.event)
    else
      flash[:notice] = "It was not possible to create your comment"
      render event_path(@comment.event)
    end
  end
  
  def approve
    @comment = Comment.find(params[:id])
    if @comment.event.owner == current_user
      @comment.approved = true
      @comment.save
      flash[:notice] = "This comment was approved"
    else
      flash[:notice] = "You do not have permission to realize that operation"
    end
    
    redirect_to event_path(@comment.event)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.event.owner == current_user
      @comment.destroy
      flash[:notice] = "That comment was deleted"
    else
      flash[:notice] = "You do not have permission to realize that operation"
    end
    
    redirect_to event_path(@comment.event)
  end
end
