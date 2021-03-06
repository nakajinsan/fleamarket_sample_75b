class PurchaseController < ApplicationController
  require 'payjp'

  def index
    card = current_user.credit_card
    if card.blank?
      redirect_to new_card_path
      flash[:notice] = 'クレジットカード登録が必要です'
    else
    @send_information = SendInformation.where(user_id: current_user.id).first
    @item = Item.find(params[:item_id])
    card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @initial_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  
end
