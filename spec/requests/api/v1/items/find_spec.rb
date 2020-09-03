require 'rails_helper'

RSpec.describe "When sending an items finder request" do
  it 'finds a match to its parameters' do
    merchant_1 = Merchant.create(name: "Hell")
    item_1 = merchant_1.items.create(name: "Furby", description: "Evil hell Gremlin", unit_price: 6.66)
    item_2 = merchant_1.items.create(name: "Sorbet", description: "Fruity", unit_price: 87.54)
    item_3 = create(:item)

    get "/api/v1/items/find?name=BET"
    item = JSON.parse(response.body)

    expect(item['data']['id']).to eq("#{item_2.id}")
    expect(item['data']['attributes']['name']).to eq("#{item_2.name}")
    expect(item['data']['attributes']['description']).to eq(item_2.description)
    expect(item['data']['attributes']['unit_price']).to eq(item_2.unit_price)

    get "/api/v1/items/find?description=REML"
    item = JSON.parse(response.body)

    expect(item['data']['id']).to eq("#{item_1.id}")
    expect(item['data']['attributes']['name']).to eq("#{item_1.name}")
    expect(item['data']['attributes']['description']).to eq(item_1.description)
    expect(item['data']['attributes']['unit_price']).to eq(item_1.unit_price)

    get "/api/v1/items/find?unit_price=#{item_3.unit_price}"
    item = JSON.parse(response.body)

    expect(item['data']['id']).to eq("#{item_3.id}")
    expect(item['data']['attributes']['name']).to eq("#{item_3.name}")
    expect(item['data']['attributes']['description']).to eq(item_3.description)
    expect(item['data']['attributes']['unit_price']).to eq(item_3.unit_price)
  end

  it 'finds multiple matches to its parameters' do
    merchant_1 = Merchant.create(name: "Hell")
    item_1 = merchant_1.items.create(name: "Furby", description: "Evil hell Gremlin", unit_price: 6.66)
    item_2 = merchant_1.items.create(name: "Sorbet", description: "Fruity at the Kremlin", unit_price: 87.54)
    item_3 = merchant_1.items.create(name: "Betsies", description: "Moo moo", unit_price: 87.54)

    get "/api/v1/items/find_all?name=BET"
    item = JSON.parse(response.body)

    expect(item['data'][0]['id']).to eq("#{item_2.id}")
    expect(item['data'][0]['attributes']['name']).to eq("#{item_2.name}")
    expect(item['data'][0]['attributes']['description']).to eq(item_2.description)
    expect(item['data'][0]['attributes']['unit_price']).to eq(item_2.unit_price)
    expect(item['data'][1]['id']).to eq("#{item_3.id}")
    expect(item['data'][1]['attributes']['name']).to eq("#{item_3.name}")
    expect(item['data'][1]['attributes']['description']).to eq(item_3.description)
    expect(item['data'][1]['attributes']['unit_price']).to eq(item_3.unit_price)

    get "/api/v1/items/find_all?description=REML"
    item = JSON.parse(response.body)

    expect(item['data'][0]['id']).to eq("#{item_1.id}")
    expect(item['data'][0]['attributes']['name']).to eq("#{item_1.name}")
    expect(item['data'][0]['attributes']['description']).to eq(item_1.description)
    expect(item['data'][0]['attributes']['unit_price']).to eq(item_1.unit_price)
    expect(item['data'][1]['id']).to eq("#{item_2.id}")
    expect(item['data'][1]['attributes']['name']).to eq("#{item_2.name}")
    expect(item['data'][1]['attributes']['description']).to eq(item_2.description)
    expect(item['data'][1]['attributes']['unit_price']).to eq(item_2.unit_price)

    get "/api/v1/items/find_all?unit_price=#{item_3.unit_price}"
    item = JSON.parse(response.body)

    expect(item['data'][0]['id']).to eq("#{item_2.id}")
    expect(item['data'][0]['attributes']['name']).to eq("#{item_2.name}")
    expect(item['data'][0]['attributes']['description']).to eq(item_2.description)
    expect(item['data'][0]['attributes']['unit_price']).to eq(item_2.unit_price)
    expect(item['data'][1]['id']).to eq("#{item_3.id}")
    expect(item['data'][1]['attributes']['name']).to eq("#{item_3.name}")
    expect(item['data'][1]['attributes']['description']).to eq(item_3.description)
    expect(item['data'][1]['attributes']['unit_price']).to eq(item_3.unit_price)
  end
end
