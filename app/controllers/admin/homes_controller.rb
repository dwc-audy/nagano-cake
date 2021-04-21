class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  layout 'admin'

  def top
    @orders = Order.all
  end

  def search
    @orders = Order.where(customer_id: params[:format])
    render 'top'
  end

end
