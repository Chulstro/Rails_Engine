class Api::V1::Items::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create(JSON.parse(params[:item]))
    render json: ItemSerializer.new(item)
  end

  def update
    item = Item.find(params[:id])
    item.update(JSON.parse(params[:item]))
    render json: ItemSerializer.new(item)
  end

end
