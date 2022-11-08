require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine, :items, :merchants, :invoices

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = sales_engine.items.all
    @merchants = sales_engine.merchants.all
    @invoices = sales_engine.invoices.all
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(diff_items_per_merchant / (merchants.count - 1)).round(2)
  end

  def diff_items_per_merchant
    merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      sum + (merchant_items.count - average_items_per_merchant)**2
    end
  end

  def merchants_with_high_item_count
    double = average_items_per_merchant_standard_deviation * 2
    merchants.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > double
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    if items.empty?
      BigDecimal(0)
    else
      price = items.sum do |item|
        item.unit_price
      end
      (price / items.count).round(2)
    end
  end

  def average_average_price_per_merchant
    total_price = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.sum
    (total_price / merchants.count).round(2)
  end

  def golden_items
    prices = items.map { |item| item.unit_price }
    avg = (prices.sum / prices.count).round(2)
    std_dev = Math.sqrt(total_diff(prices, avg) / (prices.length - 1)).round(2)
    items.find_all do |item|
      item.unit_price.to_f >= avg + (std_dev * 2)
    end
  end

  def total_diff(prices, avg)
    prices.inject(0) do |sum, price|
      sum + (price - avg)**2
    end.round(2)
  end

  def average_invoices_per_merchant
    (@invoices.count / @merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = merchants_invoices.inject(0) do |sum, invoice|
      sum += (invoice.count - mean)**2
    end
    Math.sqrt(sum / (merchants.length - 1)).round(2)
  end

  def merchants_invoices
    @merchants.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id)
    end
  end

  def invoice_paid_in_full?(invoice_id)
    # KR refactor using find_by_id
    purchases = sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    if purchases.empty?
      false
    else
      purchases.first.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.sum { |invoice_item| invoice_item.quantity * invoice_item.unit_price }
  end

  def total_revenue_by_date(date)
    invoices_by_date = sales_engine.invoices.all.find_all do |invoice|
      date.strftime('%B %d, %Y') == invoice.created_at.strftime('%B %d, %Y')
    end
    invoice_items_by_date = sales_engine.invoice_items.find_all_by_invoice_id(invoices_by_date[0].id)
    invoice_items_by_date.sum { |invoice| invoice.unit_price * invoice.quantity }
  end

  def merchants_with_only_one_item
    grouped_items = items.group_by { |item| item.merchant_id }
    # require 'pry'; binding.pry
    merchant_collection = grouped_items.transform_keys { |merchant_id| sales_engine.merchants.find_by_id(merchant_id) }
    merchant_collection.keep_if { |_merch, items| items.count == 1 }
    merchant_collection.keys
  end

  def merchants_with_only_one_item_registered_in_month(month)

    merchants_created_in_month = merchants.select do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end

    grouped_items = items.group_by { |item| item.merchant_id }
    grouped_items.transform_keys! do |merchant_id|
      sales_engine.merchants.find_by_id(merchant_id)
    end

    answer = grouped_items.keep_if do |merchant, items|
      merchants_created_in_month.include?(merchant)
    end
    answer.keep_if { |_merch, items| items.count == 1 }

    answer.keys
  end
end
