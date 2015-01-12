class PostsController < ApplicationController

  before_action :redirect_if_not_moderator_or_author, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
    @subs = @post.subs
    @comments = @post.comments.includes(:child_comments).where(parent_comment_id: nil)
    render :show
  end

  def new
    # @subs = Sub.all
    @post = Post.new

    render :new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      @post.sub_ids = params[:post][:sub_ids]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all.sort
    @post = Post.find(params[:id])

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      @post.sub_ids = params[:post][:sub_ids]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :sub_ids)
  end

  def redirect_if_not_moderator_or_author
    @post = Post.find(params[:id])
    unless current_user.id == @post.author_id ||
            @post.subs.any?{ |sub| sub.moderator_id == current_user.id }
      redirect_to post_url(@post)
    end
  end

  def vote(direction)
    @post = Post.find(params[:id])
    @vote = Vote.find_by(voteable_id: @post.id, voteable_type: "Post", user_id: current_user.id)

    if @vote
      @vote.update(value: direction)
    else
      @post.votes.create!(user_id: current_user.id, value: direction)
    end

    redirect_to :back
  end
end
