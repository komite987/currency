class CoinsController < ApplicationController

  def search
    if params[:currency].blank?
      flash.now[:danger] = "You Entered an empty string"
    else
      @coin = Coin.new_coin(params[:currency])
      flash.now[:danger] = "You Entered an inncorrect code" if !@coin
    end
      respond_to do |format|
        format.js  { render partial: 'users/result' }
      end
  end
end
