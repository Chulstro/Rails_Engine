class Api::V1::Items::FindController < ApplicationController
  def show
    key = item_params.keys.first
    value = item_params.values.first
    render json: ItemSerializer.new(Item.find_by(key => value))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
