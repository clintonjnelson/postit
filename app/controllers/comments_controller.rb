class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #SAVE THROUGH THE ASSOCIATION TO AVOID PASSING KEYS!!!!
    @comment = @post.comments.build(params.require(:comment).permit(:body))

    if @comment.save
      flash[:success] = "Comment Saved!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end
