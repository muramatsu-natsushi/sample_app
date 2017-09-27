class MicropostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
     Micropost.find(params[:id]).delete
     flash[:success] = "micropost destroyed."
     redirect_to request_referer
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end
end
