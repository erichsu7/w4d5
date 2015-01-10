class PostSubsController < ApplicationController
  def create
    @post_sub = PostSub.new(post_sub_params)

    if @post_sub.save
      redirect_to post_url(@post_sub.post)
    else
      flash[:errors] = @post_sub.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @post_sub = PostSub.find(params[:id])
    @post_sub.destroy
    redirect_to :back
  end

  private

    def post_sub_params
      params.require(:post_sub).permit(:post_id, :sub_id)
    end
end
