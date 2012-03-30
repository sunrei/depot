class StoreController < ApplicationController
  ORDER_FIELDS = ['price', 'author', 'title']

  def index
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    @count = session[:counter] if session[:counter] > 5
    if(ORDER_FIELDS.include? params[:order_by])
      @products = Product.reorder(  params[:order_by] + " " + (params[:order] == 'asc' ? "ASC" : "DESC")).all
    else
      @products = Product.all
    end
    @cart = current_cart
  end
end
