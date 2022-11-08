require 'csv'
require_relative './invoice_item'
require_relative 'repository'

class InvoiceItemRepository < Repository
  def new_obj(attributes)
    new_obj_class(attributes, InvoiceItem)
  end

  def find_all_by_item_id(id)
    @repo.select { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @repo.select { |invoice_item| invoice_item.invoice_id == id }
  end

  def find_all_by_date(date)
    # test = date.to_a.drop(3)
    # 4.times {test.pop}
    # date = Date.new(*test.reverse)

    invoice_items = @repo.find_all do |invoice_item|
      require 'pry'; binding.pry
      date_sanitize(date) === date_sanitize(invoice_item.created_at)
      # Date.parse(date.to_s) === Date.parse(invoice_item.created_at.to_s)
    end
    require 'pry'
    binding.pry
  end

  def date_sanitize(date)
    test = date.to_a.drop(3)
    4.times { test.pop }
    Date.new(*test.reverse)
  end
end
