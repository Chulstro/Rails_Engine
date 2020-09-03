require 'rails_helper'

RSpec.describe "Merchants API", type: :request do
  it "can return a list of merchants" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(merchants["data"].size).to eq(3)
    expect(merchants["data"][0]["id"]).to eq("#{merchant_1.id}")
    expect(merchants["data"][1]["id"]).to eq("#{merchant_2.id}")
    expect(merchants["data"][2]["id"]).to eq("#{merchant_3.id}")
  end

  it "can return a single merchant" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/#{merchant_1.id}"

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["name"]).to eq(merchant_1.name)
  end

  it "can create a new merchant" do
    merchant = create(:merchant)
    merchant_params = {name: "Cookie"}
    post "/api/v1/merchants", params: merchant_params

    merchant = JSON.parse(response.body)
    merchant_object = Merchant.last

    expect(merchant['data']['id']).to eq("#{merchant_object.id}")
    expect(merchant['data']['attributes']['name']).to eq(merchant_object.name)
  end

  it "can update an merchant" do
    merchant_1 = create(:merchant)
    merchant_params = {name: "Cookie"}

    patch "/api/v1/merchants/#{merchant_1.id}", params: merchant_params

    merchant = JSON.parse(response.body)
    merchant_object = Merchant.find(merchant_1.id)

    expect(merchant['data']['id']).to eq("#{merchant_object.id}")
    expect(merchant['data']['attributes']['name']).to eq(merchant_params[:name])
  end

  it "can delete and merchant" do
    merchant_1 = create(:merchant)

    delete "/api/v1/merchants/#{merchant_1.id}"

    expect(response.body).to be_empty
    expect(response.status).to eq(204)
  end

  it 'can get merchants items back' do
    merchant_1 = create(:merchant)
    item_1 = merchant_1.items.create(name: "Pancake", description: "Good", unit_price: 56.78)
    item_2 = merchant_1.items.create(name: "Waffle", description: "Better", unit_price: 987.54)

    get "/api/v1/merchants/#{merchant_1.id}/items"
    items = JSON.parse(response.body)

    expect(items['data'][0]['id']).to eq("#{item_1.id}")
    expect(items['data'][1]['id']).to eq("#{item_2.id}")
  end
end
