class Public::OrdersController < ApplicationController
  
  layout 'public'
  
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    if params[:back]
      render :new
    else @order.save!
      redirect_to orders_complete_path
    end

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @sum = 0
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_number]=="1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_number]=="2"

    elsif params[:order][:address_number]=="3"
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @order.postal_code = params[:order][:postal_code]
      @order.customer_id = current_customer.id
    end

    @cart_items = CartItem.where(customer_id: current_customer.id)
    @sum = 0
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!

    @cart_items = CartItem.where(customer_id: current_customer.id)
    
    @cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @order_details = OrderDetail.new
      @order_details.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_details.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @order_details.price = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
      @order_details.order_id = @order.id #注文商品に注文idを紐付け
      @order_details.save #注文商品を保存
    end
    
    @cart_items.destroy_all #カートの中身を削除
    redirect_to orders_complete_path #thanksに遷移

  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost)
  end
end
