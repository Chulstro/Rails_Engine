class Api::V1::Items::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
end
