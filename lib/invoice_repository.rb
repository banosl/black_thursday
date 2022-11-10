require 'csv'
require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository
  def new_obj(attributes)
    new_obj_class(attributes, Invoice)
  end

  def find_all_by_customer_id(customer_id)
    @repo.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @repo.select do |invoice|
      invoice.status == status.to_sym
    end
  end

  def find_all_by_invoice_id(id)
    @repo.select { |invoice| invoice.id == id }
  end
end
