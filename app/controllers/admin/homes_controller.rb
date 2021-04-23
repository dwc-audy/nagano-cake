class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

  def top
    @orders = Order.page(params[:page]).per(10)
  end

  def search
    @orders = Order.where(customer_id: params[:format]).page(params[:page]).per(10)
    render 'top'
  end

end
