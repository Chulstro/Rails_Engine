class Merchant < ApplicationRecord
  validates_presences_of :name
  has_many :invoices
  has_many :items
end
