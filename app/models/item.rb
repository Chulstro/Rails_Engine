class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_and_deliver(data_hash)
    value = data_hash.values[0]
    if data_hash.keys[0] == "name"
      where("LOWER(name) like ?", "%#{value.downcase}%").first
    elsif data_hash.keys[0] == "description"
      where("LOWER(description) like ?", "%#{value.downcase}%").first
    elsif data_hash.keys[0] == "unit_price"
      find_by(unit_price: value)
    end
  end

  def self.find_and_deliver_all(data_hash)
    value = data_hash.values[0]
    if data_hash.keys[0] == "name"
      where("LOWER(name) like ?", "%#{value.downcase}%")
    elsif data_hash.keys[0] == "description"
      where("LOWER(description) like ?", "%#{value.downcase}%")
    elsif data_hash.keys[0] == "unit_price"
      where(unit_price: value)
    end 
  end
end
