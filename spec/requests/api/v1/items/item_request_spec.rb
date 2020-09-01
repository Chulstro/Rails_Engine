require 'rails_helper'

RSpec.describe "Items API", type: :request do
  it "can return a list of items" do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(items["data"].size).to eq(3)
    expect(items["data"][0]["id"]).to eq("#{item_1.id}")
    expect(items["data"][1]["id"]).to eq("#{item_2.id}")
    expect(items["data"][2]["id"]).to eq("#{item_3.id}")
  end

  it "can return a single item" do
    item_1 = create(:item)
    # item_1.invoice.create(:invoice)

    get "/api/v1/items/#{item_1.id}"

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["name"]).to eq(item_1.name)
    expect(item["data"]["attributes"]["description"]).to eq(item_1.description)
    expect(item["data"]["attributes"]["unit_price"]).to eq(item_1.unit_price)
    expect(item["data"]["relationships"]["merchant"]["data"]["id"]).to eq("#{item_1.merchant.id}")
  end

  it "can create a new item" do
    merchant = create(:merchant)
    merchant.items.create(name: "Jeans", description: "Not Tasty", unit_price: 34.76, merchant: merchant)
    item_params = {name: "Cookie", description: "Yummy", unit_price: 23.78, merchant_id: merchant.id}
    post "/api/v1/items", params: item_params

    item = JSON.parse(response.body)
    item_object = Item.last

    expect(item['data']['id']).to eq("#{item_object.id}")
    expect(item['data']['attributes']['name']).to eq(item_object.name)
    expect(item['data']['attributes']['description']).to eq(item_object.description)
    expect(item['data']['attributes']['unit_price']).to eq(item_object.unit_price)
    expect(item['data']['relationships']['merchant']['data']['id']).to eq("#{merchant.id}")
  end

  it "can update an item" do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Jeans", description: "Not Tasty", unit_price: 34.76, merchant: merchant)
    item_params = {name: "Cookie", description: "Yummy", unit_price: 23.78, merchant_id: merchant.id}

    patch "/api/v1/items/#{item_1.id}", params: item_params

    item = JSON.parse(response.body)
    item_object = Item.find(item_1.id)

    expect(item['data']['id']).to eq("#{item_object.id}")
    expect(item['data']['attributes']['name']).to eq(item_params[:name])
    expect(item['data']['attributes']['description']).to eq(item_params[:description])
    expect(item['data']['attributes']['unit_price']).to eq(item_params[:unit_price])
  end

  it "can delete and item" do
    merchant = create(:merchant)
    item_1 = merchant.items.create(name: "Jeans", description: "Not Tasty", unit_price: 34.76, merchant: merchant)

    delete "/api/v1/items/#{item_1.id}"

    expect(response.body).to be_empty
    expect(response.status).to eq(204)
  end
end
