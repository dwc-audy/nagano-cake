class Public::HomesController < ApplicationController



  layout 'public'

  def top
    @genres = Genre.all
    @items = Item.limit(4).order(" created_at DESC ")
  end


  def about
    @items = Item.all
  end
end
