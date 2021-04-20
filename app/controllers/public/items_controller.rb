class Public::ItemsController < ApplicationController

  layout 'public'

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end
  
  def search
    @items = Item.where(genre_id: params[:format])
    render 'index'
  end
end
