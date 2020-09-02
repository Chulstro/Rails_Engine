require 'csv'


task build_data: :environment do
  customer_data = 'lib/data/customers.csv'
  item_data = 'lib/data/items.csv'
  merchant_data = 'lib/data/merchants.csv'
  invoice_data = 'lib/data/invoices.csv'
  invoice_item_data = 'lib/data/invoice_items.csv'
  transaction_data = 'lib/data/transactions.csv'

  puts "Destroying previous data"

  InvoiceItem.destroy_all
  Transaction.destroy_all
  Invoice.destroy_all
  Item.destroy_all
  Merchant.destroy_all
  Customer.destroy_all


  puts 'Building new data'

  CSV.foreach(customer_data, headers: true) do |row|
    Customer.create(row.to_hash)
  end

  CSV.foreach(merchant_data, headers: true) do |row|
    Merchant.create(row.to_hash)
  end

  CSV.foreach(item_data, headers: true) do |row|
    Item.create(id: row['id'],
                name: row['name'],
                description: row['description'],
                merchant_id: row['merchant_id'],
                created_at: row['created_at'],
                updated_at: row['updated_at'],
                unit_price: row['unit_price'].insert(-3, '.').to_f)
  end

  CSV.foreach(invoice_data, headers: true) do |row|
    Invoice.create(row.to_hash)
  end

  CSV.foreach(invoice_item_data, headers: true) do |row|
     InvoiceItem.create(id: row['id'],
                  quantity: row['quantity'],
                  item_id: row['item_id'],
                  invoice_id: row['invoice_id'],
                  created_at: row['created_at'],
                  updated_at: row['updated_at'],
                  unit_price: row['unit_price'].insert(-3, '.').to_f)
  end

  CSV.foreach(transaction_data, headers: true) do |row|
    Transaction.create(row.to_hash)
  end

  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end

  puts "Database Complete"
end
