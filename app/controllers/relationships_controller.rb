class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:followed_id])
    @current_user = current_user
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    UserMailer.follow_confirmation(@user,@current_user).deliver
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    @current_user = current_user
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    UserMailer.unfollow_confirmation(@user,@current_user).deliver
  end
end

