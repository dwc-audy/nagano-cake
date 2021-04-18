class Public::CartItemsController < ApplicationController


  def index
    @cart_item = CartItem.find(params[:item_id])
  end

  def create
    session[:cart_items] = [] unless session[:cart_items]
    session[:cart_items] << params[:item_id]
    redirect_to cart_items_path
  end


end
