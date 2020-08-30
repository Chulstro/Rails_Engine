class InvoiceItem < ApplicationRecord
  validates_presences_of :quantity, :unit_price
  belongs_to :item
  belongs_to :invoice
end
