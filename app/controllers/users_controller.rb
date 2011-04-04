class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    redirect_to(root_path) if signed_in?
    @user = User.new
    @title = "Sign up"
  end

  def reset
    @user.password = ""
    @user.password_confirmation = ""
  end

  def create
    redirect_to(root_path) if signed_in?
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      reset
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])   mporei na paravleu8ei gti o user exei dilo8ei sto
    #                                 sessions_helper user == current_user
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      reset
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id
      flash[:notice] = "You can't destroy yourself."
      redirect_to users_path
    else
      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      if current_user == nil
        redirect_to(signin_path)
      else
      redirect_to(root_path) unless current_user.admin?
      end
    end

end
