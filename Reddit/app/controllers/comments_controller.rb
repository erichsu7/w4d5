class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post

    render :show
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new

    render :new
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment_url(@comment.post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to post_url(@post)
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :parent_comment_id)
    end

    def vote(direction)
      @comment = Comment.find(params[:id])
      @vote = Vote.find_by(voteable_id: @comment.id, voteable_type: "Comment", user_id: current_user.id)

      if @vote
        @vote.update(value: direction)
      else
        @comment.votes.create!(user_id: current_user.id, value: direction)
      end

      redirect_to :back
    end
end
