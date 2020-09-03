require 'rails_helper'

RSpec.describe "When sending an merchants finder request" do
  it 'finds a match to its parameters' do
    merchant_1 = Merchant.create(name: "Quasimodo")
    merchant_2 = Merchant.create(name: "Banihana")
    create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant_2.name}"
    merchant = JSON.parse(response.body)

    expect(merchant['data']['id']).to eq("#{merchant_2.id}")
    expect(merchant['data']['attributes']['name']).to eq("#{merchant_2.name}")

    get "/api/v1/merchants/find?name=MOD"
    merchant2 = JSON.parse(response.body)

    expect(merchant2['data']['id']).to eq("#{merchant_1.id}")
    expect(merchant2['data']['attributes']['name']).to eq("#{merchant_1.name}")
  end
end
