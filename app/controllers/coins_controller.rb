class CoinsController < ApplicationController

  def search
    if params[:currency].present?
      @coin = Coin.new_coin(params[:currency])
        if @coin
          render 'users/portfolio'
        else
          flash[:danger] = "You Entered an inncorrect code"
          redirect_to portfolio_path
        end
    else
      flash[:danger] = "You Entered an empty string"
      redirect_to portfolio_path
    end
  end
end
