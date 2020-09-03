require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe 'relationships' do
    it {should have_many(:invoice_items)}
    it {should belong_to(:merchant)}
  end

  describe 'methods' do
    before :each do
      create(:item, description: "Out of this World")
      create(:item, name: "Belok the Unkind", unit_price: 98.80)
      create(:item, name: "Beloved Food", unit_price: 98.80)
      create(:item, description: "His absolute favorite")
    end

    it '.find_and_deliver' do
      name_param ={}
      name_param["name"] = "OVED"
      item = Item.find_and_deliver(name_param)
      expect(item.name).to eq("Beloved Food")

      desc_param = {}
      desc_param['description'] = "HiS"
      item = Item.find_and_deliver(desc_param)
      expect(item.description).to eq("Out of this World")

      num_param = {}
      num_param['unit_price'] = 98.80
      item = Item.find_and_deliver(num_param)
      expect(item.name).to eq("Belok the Unkind")
    end

    it '.find_and_deliver_all' do
      name_param = {}
      name_param["name"] = "BeLo"
      items = Item.find_and_deliver_all(name_param)
      expect(items[0].name).to eq("Belok the Unkind")
      expect(items[1].name).to eq("Beloved Food")

      desc_param = {}
      desc_param['description'] = "HiS"
      items = Item.find_and_deliver_all(desc_param)
      expect(items[0].description).to eq("Out of this World")
      expect(items[1].description).to eq("His absolute favorite")

      num_param = {}
      num_param['unit_price'] = 98.80
      items = Item.find_and_deliver_all(num_param)
      expect(items[0].name).to eq("Belok the Unkind")
      expect(items[1].name).to eq("Beloved Food")
    end
  end
end
