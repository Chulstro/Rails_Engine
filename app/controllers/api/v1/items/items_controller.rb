class Api::V1::Items::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item)
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private

  def item_params
    params.permit(:name, :description, :merchant_id, :unit_price)
  end
end
