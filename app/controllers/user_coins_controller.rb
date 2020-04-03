class UserCoinsController < ApplicationController
  def create
    coin = Coin.find_by_code(params[:coin_code])
    if coin.blank?
      coin = Coin.new_coin(params[:coin_code])
      coin.save
    end
    @user_coin = UserCoin.create(user: current_user, coin: coin)
    flash[:success] = "You add #{coin.name} to your favourite"
    redirect_to portfolio_path
  end

  def destroy
    coin = Coin.find(params[:id])
    @user_coin = UserCoin.where(user_id: current_user.id, coin_id: coin.id).first
    @user_coin.destroy
    flash[:danger] = "Coin was successfully removed from portfolio"
    redirect_to portfolio_path
  end

end
