class Api::V1::Merchants::FindController < ApplicationController
  def index
    value = params[:name]
    render json: MerchantSerializer.new(Merchant.all_name_search(value))
  end

  def show
    value = params[:name]
    render json: MerchantSerializer.new(Merchant.name_search(value))
  end
end
