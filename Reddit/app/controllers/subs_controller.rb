class SubsController < ApplicationController
  before_action :redirect_if_not_moderator, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all

    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts

    render :show
  end

  def new
    @sub = Sub.new

    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description)
    end

    def redirect_if_not_moderator
      @sub = Sub.find(params[:id])
      redirect_to sub_url(@sub) unless @sub.moderator_id == current_user.id
    end
end
