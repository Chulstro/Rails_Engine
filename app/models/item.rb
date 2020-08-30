class Item < ApplicationRecord
  validates_presences_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
end
