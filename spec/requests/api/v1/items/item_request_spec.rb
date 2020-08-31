require 'rails_helper'

RSpec.describe "Items API", type: :request do
  it "can return a list of items" do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].size).to eq(3)
    expect(items["data"][0]["id"]).to eq("#{item_1.id}")
    expect(items["data"][1]["id"]).to eq("#{item_2.id}")
    expect(items["data"][2]["id"]).to eq("#{item_3.id}")
  end

  # it "can return a single item" do
  #   item_1 = create(:item)
  # end
end
