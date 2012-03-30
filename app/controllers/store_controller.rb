class StoreController < ApplicationController
  def index
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @count = session[:counter] if session[:counter] > 5
    @products = Product.all
    @cart = current_cart
  end
end
