require 'rails_helper'

RSpec.describe "When sending an merchants finder request" do
  it 'finds a match to its parameters' do
    create(:merchant)
    merchant_2 = create(:merchant)
    create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant_2.name}"
    merchant = JSON.parse(response.body)

    expect(merchant['data']['id']).to eq("#{merchant_2.id}")
    expect(merchant['data']['attributes']['name']).to eq("#{merchant_2.name}")

  end
end
