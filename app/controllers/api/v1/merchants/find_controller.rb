class Api::V1::Merchants::FindController < ApplicationController
  def show
    value = params[:name].downcase
    render json: MerchantSerializer.new(Merchant.name_search(value))
  end
end
