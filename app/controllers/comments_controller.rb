class CommentsController < ApplicationController
  before_action :require_logged_in

  def vote
    post = Post.find_by(slug: params[:post_id])
    @comment = Comment.find(params[:id])
    vote = Vote.create(votable: @comment, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        if vote.valid?
          flash[:success] = 'Vote counted.'
        else
          flash[:error] = "You've already voted on that commment."
        end
        redirect_to :back
      end

      #Alternate approach rendering partial of vote.js.erb in shared instead of on view
      format.js do
        if !vote.valid?
          render 'shared/vote_error', locals: { type: "comment"}
        end
      end
    end
  end

  def create
    #This is possible due to association - so it passes it's foreign_key info
    @post = Post.find_by(slug: params[:post_id])
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
