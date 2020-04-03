class UsersController < ApplicationController
  def portfolio
    @user = current_user
    @user_coins = current_user.coins
  end

  def friends
    @friendships = current_user.friends
  end

  def search
    if params[:search_params].blank?
      flash.now[:danger] = "You Entered an empty string"
    else
      @users = User.search(params[:search_params])
      @users = current_user.except_current_user(@users)
      flash.now[:danger] = "No users found" if @users.blank?
    end
      respond_to do |format|
        format.js  { render partial: 'friends/result' }
      end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:notice] = "Friend was successfully added"
    else
      flash[:danger] = "There was something wrong with the friend request"
    end
    redirect_to friends_path
  end

  def show
    @user = User.find(params[:id])
    @user_coins = @user.coins
  end


end
