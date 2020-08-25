class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
  end

  def create
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name)
  end

end
