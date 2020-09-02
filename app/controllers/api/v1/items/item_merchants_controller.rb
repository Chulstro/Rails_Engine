class Api::V1::Items::ItemMerchantsController < ApplicationController
  def show
    item = Item.find(params[:id])
    render json: MerchantSerializer.new(item.merchant)
  end
end
