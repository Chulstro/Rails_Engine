class Api::V1::Merchants::FindController < ApplicationController
  def show
    key = merchant_params.keys.first
    value = merchant_params.values.first
    render json: MerchantSerializer.new(Merchant.find_by(key => value))
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
