class Public::ItemsController < ApplicationController

  layout 'public'

  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end
end
