class PagesController < ApplicationController

  def help
    @title = "Help"
  end

  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      @feed_items_all = current_user.feed.all
      @feed_items = current_user.feed.search(params[:search]).paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
end
