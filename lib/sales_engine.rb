require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_item'
require_relative 'transaction_repository'
require_relative 'transaction'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new
    @invoices = InvoiceRepository.new
    @invoice_items = InvoiceItemRepository.new
    @transactions = TransactionRepository.new
    @customers = CustomerRepository.new
  end

  def self.from_csv(hash_path)
    sales_engine = new
    sales_engine.items.parse_data(hash_path[:items], Item)
    sales_engine.merchants.parse_data(hash_path[:merchants], Merchant)
    sales_engine.invoices.parse_data(hash_path[:invoices], Invoice)
    sales_engine.invoice_items.parse_data(hash_path[:invoice_items], InvoiceItem)
    sales_engine.transactions.parse_data(hash_path[:transactions], Transaction)
    sales_engine.customers.parse_data(hash_path[:customers], Customer)
    sales_engine
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
  end
end
