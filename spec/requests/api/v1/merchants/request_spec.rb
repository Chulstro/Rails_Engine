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
end
