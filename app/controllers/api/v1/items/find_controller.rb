class Api::V1::Items::FindController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find_and_deliver(item_params))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
