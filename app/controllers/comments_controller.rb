class CommentsController < ApplicationController
  before_action :require_logged_in

  def create
    #This is possible due to association - so it passes it's foreign_key info
    @post = Post.find(params[:post_id])
    #SAVE THROUGH THE ASSOCIATION TO AVOID EXPLICITLY SETTING KEYS!!!!
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    if @comment.save
      flash[:success] = "Comment Saved!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end
