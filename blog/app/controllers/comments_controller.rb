class CommentsController < ApplicationController
   # http_basic_authenticate_with :name => "dhh", :password => "secret", :only => :destroy
  def create
    @myblog = Myblog.find(params[:myblog_id])
    @comment = @myblog.comments.create(params[:comment])
    redirect_to myblog_path(@myblog)
  end
  
  def destroy
     @myblog = Myblog.find(params[:myblog_id])
     @comment = @myblog.comments.find(params[:id])
     @comment.destroy
     redirect_to myblog_path(@myblog)
   end
end
