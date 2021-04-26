class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_new_message, only:[:new, :confirm]

  layout 'public'

  def new
    @order = Order.new
    @customer = current_customer
    @address = Address.new
    @radio_check1 = "checked"
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @sum = 0
    @order_details.each do |order_detail|
      @sum += (order_detail.price * 1.1 * order_detail.amount).floor
    end
  end

  def confirm
    @order = Order.new(order_params)
    @selected_pay = params[:order][:payment_method]
    select_radio = params[:order][:address_number]
    @selected_delivery = params[:order][:address_id]

    case select_radio
    when "1"
      if @selected_pay.present?
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
      else
        flash[:alert_pay] = "選択して下さい"
        @radio_check1 = "checked"
        render 'new'
      end
    when "2"
      if @selected_pay.present?
        if @selected_delivery.present?
          select_address = Address.find(@selected_delivery)
          @order.postal_code = select_address.postal_code
          @order.address = select_address.address
          @order.name = select_address.name
        else
          flash[:alert2] = "選択して下さい"
          @radio_check2 = "checked"
          render 'new'
        end
      else
        flash[:alert_pay] = "選択して下さい"
        @radio_check2 = "checked"
        if @selected_delivery.empty?
          flash[:alert2] = "選択して下さい"
        end
        render 'new'
      end
    when "3"
      new_postal_code = params[:order][:postal_code]
      new_address = params[:order][:address]
      new_name = params[:order][:name]
      if @selected_pay.present?
        @address = Address.new()
        @address.postal_code = new_postal_code
        @address.address = new_address
        @address.name = new_name
        @address.customer_id = current_customer.id
        if @address.save
          @order.postal_code = new_postal_code
          @order.address = new_address
          @order.name = new_name
        else
          flash[:alert3] = "空欄はダメだよ"
          @radio_check3 = "checked"
          render 'new'
        end
      else
        flash[:alert_pay] = "選択して下さい"
        if new_postal_code.empty? || new_address.empty? || new_name.empty?
          flash[:alert3] = "空欄はダメだよ"
        end
        @radio_check3 = "checked"
        render 'new'
      end
    end

    @cart_items = CartItem.where(customer_id: current_customer.id)
    @sum = 0
  end



  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!


    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.item_id = cart_item.item_id
      @order_details.amount = cart_item.amount
      @order_details.price = (cart_item.item.price*1.1).floor
      @order_details.order_id = @order.id
      @order_details.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  private

  def set_new_message
    @selected_pay = false
    @selected_delivery = false
    @radio_check1 = ""
    @radio_check2 = ""
    @radio_check3 = ""
    flash[:alert_pay] = false
    flash[:alert2] = false
    flash[:alert3] = false
  end

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost)

  end
end
