class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices

  def self.name_search(name)
    where("LOWER(name) like ?", "%#{name}%").first
  end

  def self.all_name_search(name)
    where("LOWER(name) like ?", "%#{name}%")
  end

  def self.most_revenue(limit)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:id).where("transactions.result = 'success'")
    .order("revenue desc").limit(limit)
  end
end
