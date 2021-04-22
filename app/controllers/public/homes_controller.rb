class Public::HomesController < ApplicationController



  layout 'public'

  def top
    @genres = Genre.all
    @items = Item.limit(8).order(" created_at DESC ")
  end


  def about
  end
end
