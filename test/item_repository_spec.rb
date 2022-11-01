require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
  it 'returns all known item instances' do
    expect(ItemRepository.all).to eq([])
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.all[0]).to be_instance_of(Item)
  end

  it 'finds by ID' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_by_id(1)).to be_instance_of(Item)
    expect(ItemRepository.find_by_id(45)).to eq(nil)
  end

  it 'finds by name' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_by_name('Pencil')).to be_instance_of(Item)
    expect(ItemRepository.find_by_name('Marker')).to eq(nil)
  end

  it 'finds all by description' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_all_with_description('You can use it to write things')[0]).to be_instance_of(Item)
    expect(ItemRepository.find_all_with_description('Marker')).to eq([])
    expect(ItemRepository.find_all_with_description('Pencil')).to eq([])
  end

  it 'finds all by price' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_all_by_price(10.99)[0]).to be_instance_of(Item)
    expect(ItemRepository.find_all_by_price(20)).to eq([])
    expect(ItemRepository.find_all_by_price(0)).to eq([])
  end

  it 'finds all by price in range' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_all_by_price_in_range((10..11))[0]).to be_instance_of(Item)
    expect(ItemRepository.find_all_by_price_in_range((0..3))).to eq([])
  end

  it 'finds all by price in range' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_all_by_merchant_id(2)[0]).to be_instance_of(Item)
    expect(ItemRepository.find_all_by_merchant_id(87)).to eq([])
  end

  it 'creates new instance with attributes' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    i2 = ItemRepository.create({

                                 name: 'Pencil',
                                 description: 'You can use it to write things',
                                 unit_price: BigDecimal(10.99, 4),
                                 created_at: Time.now,
                                 updated_at: Time.now,
                                 merchant_id: 2
                               })
    expect(i2).to be_instance_of(Item)
    expect(i2.id).to eq(2)
  end
end
