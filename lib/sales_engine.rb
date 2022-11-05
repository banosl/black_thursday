require 'csv'
require_relative 'merchant_repository'
require_relative './item_repository'
require_relative './item'
require_relative './merchant'
require_relative './sales_analyst'
require_relative './invoice'
require_relative './invoice_repository'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new
    @invoices = InvoiceRepository.new
  end

  def self.from_csv(hash_path)
    sales_engine = new
    sales_engine.items.parse_data(hash_path[:items])
    sales_engine.merchants.parse_data(hash_path[:merchants])
    sales_engine
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
    # KR why is analyst an attribute value?
  end
end
