require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it{should validate_presence_of(:name)}
  end

  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:items)}
  end

  describe "methods" do
    before :each do
      create(:merchant)
      create(:merchant, name: "Fossette")
      create(:merchant, name: "Stossel")
      create(:merchant)
    end

    it '.name_search' do
      name = "Osse"
      merchant = Merchant.name_search(name)
      expect(merchant.name).to eq("Fossette")
    end

    it '.all_name_search' do
      name = 'OsSe'
      merchants = Merchant.all_name_search(name)
      expect(merchants[0].name).to eq("Fossette")
      expect(merchants[1].name).to eq("Stossel")
    end

    it '.most_revenue' do
      Merchant.destroy_all
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_1 = merchant_1.items.create(name: "Food", description: "Tasty", unit_price: 80.90)
      item_2 = merchant_1.items.create(name: "Brian's specialty dog toy", description: "Fun for Furries", unit_price: 34.90)
      item_3 = merchant_2.items.create(name: "Clothes", description: "Warm", unit_price: 30.08)
      item_4 = merchant_3.items.create(name: "Car", description: "Expensive", unit_price: 3000.08)
      invoice_1 = customer_1.invoices.create(status: 'shipped', merchant_id: merchant_1.id)
      invoice_2 = customer_1.invoices.create(status: 'shipped', merchant_id: merchant_2.id)
      invoice_3 = customer_1.invoices.create(status: 'shipped', merchant_id: merchant_3.id)
      invoice_1.invoice_items.create(item_id: item_1.id, quantity: 10, unit_price: item_1.unit_price)
      invoice_1.invoice_items.create(item_id: item_2.id, quantity: 14, unit_price: item_2.unit_price)
      invoice_2.invoice_items.create(item_id: item_3.id, quantity: 15, unit_price: item_3.unit_price)
      invoice_3.invoice_items.create(item_id: item_4.id, quantity: 5, unit_price: item_4.unit_price)
      invoice_1.transactions.create(credit_card_number: "3454368332567807", result: "success")
      invoice_2.transactions.create(credit_card_number: "6987979879855863", result: "failed")
      invoice_3.transactions.create(credit_card_number: "3264545983649463", result: "success")

      merchants = Merchant.most_revenue("2")

      expect(merchants[0].id).to eq(merchant_3.id)
      expect(merchants[1].id).to eq(merchant_1.id)
    end
  end
end
