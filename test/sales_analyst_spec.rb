require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  let(:sales_engine) do
    SalesEngine.from_csv({
                           items: './data/items.csv',
                           merchants: './data/merchants.csv'
                         })
                        #  let(:sales_analyst) { sales_engine.analyst }
                         
  end

  it 'exists' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_instance_of(SalesAnalyst)
  end

  it 'checks average items per merchant' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'checks average items per merchant standard deviation' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "returns merchants with high item counts" do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count[0]).to be_a(Merchant)

  end

  it 'checks average item price for merchant)' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)

  end
end
