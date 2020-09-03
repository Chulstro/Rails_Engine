class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.name_search(name)
    where("LOWER(name) like ?", "%#{name}%").first
  end

  def self.all_name_search(name)
    where("LOWER(name) like ?", "%#{name}%")
  end
end
