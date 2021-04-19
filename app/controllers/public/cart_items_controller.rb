class Public::CartItemsController < ApplicationController

  layout 'public'


  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
  end

  def create
    @cart_item =CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find_by(id: @cart_item.item_id)
      redirect_to item_path(@item), flash: {alert: '※個数を選択して下さい'}
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end


end
