class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_card, :set_item
  def new
    if @card.blnak?
      redirect_to new_card_path
    else
    Pay.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_informaiton = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.ap_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    Payjp::charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy',
    ) 
  end
  private
  def set_card
    @card = Card.find_by(user_id: currnt_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
