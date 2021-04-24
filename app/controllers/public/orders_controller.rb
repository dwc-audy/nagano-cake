class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  layout 'public'

  def new
    @order = Order.new
    @customer = current_customer
    @address = Address.new
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


      if params[:order][:address_number]=="1"

        if params[:order][:payment_method] != ""
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.last_name + current_customer.first_name
        else
          flash[:ale] = "空欄はダメだよ"
          redirect_to new_order_path
        end

      elsif params[:order][:address_number]=="2"

        if params[:order][:payment_method] != ""
          @order.postal_code = Address.find(params[:order][:address_id]).postal_code
          @order.address = Address.find(params[:order][:address_id]).address
          @order.name = Address.find(params[:order][:address_id]).name
        else
          flash[:ale] = "空欄はダメだよ"
          redirect_to new_order_path
        end

      elsif params[:order][:address_number]=="3"

        if params[:order][:payment_method] != ""

            @address = Address.new()
            @address.address = params[:order][:address]
            @address.name = params[:order][:name]
            @address.postal_code = params[:order][:postal_code]
            @address.customer_id = current_customer.id
            @address.save!

          if params[:order][:address] != "" && params[:order][:name] != "" && params[:order][:postal_code] != ""
            @order.address = params[:order][:address]
            @order.name = params[:order][:name]
            @order.postal_code = params[:order][:postal_code]
            @order.customer_id = current_customer.id
          else
            flash[:alert] = "空欄はダメだよ"
            redirect_to new_order_path
          end

        else
          flash[:ale] = "空欄はダメだよ"
          redirect_to new_order_path
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
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost)

  end
end
