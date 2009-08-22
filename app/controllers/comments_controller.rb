class CommentsController < ApplicationController
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
    @comment.approved = true
    @comment.save
    
    redirect_to event_path(@comment.event)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
    redirect_to event_path(@comment.event)
  end
end
