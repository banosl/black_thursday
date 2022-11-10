require 'rspec'
require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists and has attributes' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation = invoice_repo1.create({
                                          id: 1,
                                          customer_id: 1,
                                          merchant_id: 12_335_938,
                                          status: 'pending',
                                          created_at: Time.now,
                                          updated_at: Time.now
                                        })

    expect(invoice_repo1).to be_instance_of(InvoiceRepository)
    expect(inv_creation).to be_instance_of(Invoice)
    expect(inv_creation.id).to eq(1)
    expect(inv_creation.customer_id).to eq(1)
    expect(inv_creation.merchant_id).to eq(12_335_938)
    expect(inv_creation.status).to eq(:pending)
    expect(inv_creation.created_at).to be_instance_of(Time)
    expect(inv_creation.updated_at).to be_instance_of(Time)
  end

  it 'the repository can return an array of all invoices' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation2 = invoice_repo1.create({
                                           id: 3,
                                           customer_id: 5,
                                           merchant_id: 12_333_135_231,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation3 = invoice_repo1.create({
                                           id: 6,
                                           customer_id: 8,
                                           merchant_id: 1_233_635,
                                           status: 'shipped',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(invoice_repo1.all).to eq([inv_creation1, inv_creation2, inv_creation3])
  end

  it 'repository can find the invoices by id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(invoice_repo1.find_by_id(1)).to be_instance_of(Invoice)
    expect(invoice_repo1.find_by_id(625)).to be_nil
  end

  it 'repository can find all invoices by customer id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation2 = invoice_repo1.create({
                                           id: 3,
                                           customer_id: 5,
                                           merchant_id: 12_333_135_231,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation3 = invoice_repo1.create({
                                           id: 6,
                                           customer_id: 5,
                                           merchant_id: 1_233_635,
                                           status: 'shipped',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(invoice_repo1.find_all_by_customer_id(1)).to eq([inv_creation1])
    expect(invoice_repo1.find_all_by_customer_id(5)).to eq([inv_creation2, inv_creation3])
    expect(invoice_repo1.find_all_by_customer_id(18)).to eq([])
  end

  it 'repository can find all invoices by merchant id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation2 = invoice_repo1.create({
                                           id: 3,
                                           customer_id: 5,
                                           merchant_id: 12_333_135_231,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation3 = invoice_repo1.create({
                                           id: 6,
                                           customer_id: 17,
                                           merchant_id: 12_335_938,
                                           status: 'shipped',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(invoice_repo1.find_all_by_merchant_id(12_335_938)).to eq([inv_creation1, inv_creation3])
    expect(invoice_repo1.find_all_by_merchant_id(12_333_135_231)).to eq([inv_creation2])
    expect(invoice_repo1.find_all_by_merchant_id(76_245_265)).to eq([])
  end

  it 'repository can find all invoices by shipment status' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation2 = invoice_repo1.create({
                                           id: 3,
                                           customer_id: 5,
                                           merchant_id: 12_333_135_231,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation3 = invoice_repo1.create({
                                           id: 6,
                                           customer_id: 17,
                                           merchant_id: 12_335_938,
                                           status: 'shipped',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(invoice_repo1.find_all_by_status('pending')).to eq([inv_creation1, inv_creation2])
    expect(invoice_repo1.find_all_by_status('shipped')).to eq([inv_creation3])
    expect(invoice_repo1.find_all_by_status('only Joseph knows')).to eq([])
  end

  it 'repository can update the status of an invoice' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(inv_creation1.status).to eq(:pending)

    invoice_repo1.update(1, status: :shipped)
    expect(inv_creation1.status).to eq(:shipped)
  end

  it 'repository can delete invoices by id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation2 = invoice_repo1.create({
                                           id: 3,
                                           customer_id: 5,
                                           merchant_id: 12_333_135_231,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(inv_creation1).to be_instance_of(Invoice)
    invoice_repo1.delete(1)
    expect(invoice_repo1.all).not_to include(inv_creation1)
  end

  it '#find_all_by_invoice_id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create({
                                           id: 1,
                                           customer_id: 1,
                                           merchant_id: 12_335_938,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    inv_creation2 = invoice_repo1.create({
                                           id: 3,
                                           customer_id: 5,
                                           merchant_id: 12_333_135_231,
                                           status: 'pending',
                                           created_at: Time.now,
                                           updated_at: Time.now
                                         })
    expect(invoice_repo1.find_all_by_invoice_id(3)).to eq([inv_creation2])
  end
end
