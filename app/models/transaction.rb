class Transaction < ApplicationRecord
  validates_presences_of :credit_card_number, :result
  belongs_to :invoice
end
