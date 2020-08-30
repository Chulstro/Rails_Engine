class Customer < ApplicationRecord
  validates_presences_of :first_name, :last_name
  has_many :invoices
end
