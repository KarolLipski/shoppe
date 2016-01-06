# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  number      :string(255)
#  name        :string(255)
#  small_wrap  :integer
#  big_wrap    :integer
#  photo       :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  barcode     :string(13)
#

require 'rails_helper'

RSpec.describe Item, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:item)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:item, name: nil)).not_to be_valid
  end

  it 'is invalid without number' do
    expect(FactoryGirl.build(:item, number: nil)).not_to be_valid
  end

  it 'is invalid without small_wrap' do
    expect(FactoryGirl.build(:item, small_wrap: nil)).not_to be_valid
  end

  it 'is invalid without big_wrap' do
    expect(FactoryGirl.build(:item, big_wrap: nil)).not_to be_valid
  end

  it 'big_wrap should be only number' do
    expect(FactoryGirl.build(:item, big_wrap: 'abc')).not_to be_valid
    expect(FactoryGirl.build(:item, big_wrap: 123)).to be_valid
  end

  it 'small_wrap should be only number' do
    expect(FactoryGirl.build(:item, small_wrap: 'abc')).not_to be_valid
    expect(FactoryGirl.build(:item, small_wrap: 123)).to be_valid
  end

  it 'wraps should not be less than 0' do
    expect(FactoryGirl.build(:item, small_wrap: -2)).not_to be_valid
    expect(FactoryGirl.build(:item, big_wrap: -3)).not_to be_valid
    expect(FactoryGirl.build(:item, small_wrap: 0)).to be_valid
  end

  it 'fixes name' do
    name_to_fix1 = 'Wieża'
    name_to_fix2 = 'KLOCKI DZIEWCZ E CE RESTAURACJ'

    item1 = FactoryGirl.build(:item, name: name_to_fix1)
    item1.fix_name
    expect(item1.name).to eq 'Wieża'

    item2 = FactoryGirl.build(:item, name: name_to_fix2)
    item2.fix_name
    expect(item2.name).to eq 'Klocki dziewczece restauracj'

  end

  context 'update photos' do
    before(:each) do
      @item = FactoryGirl.create(:item, number: 'test1')
    end
    context 'when file exist and photo is null' do
      it 'updates photo column' do
        @item.update_column(:photo, nil)
        @item.update_photo
        expect(@item.photo.filename).to eq('test1.jpg')
      end
    end
    context 'when photo in not null' do
      it 'doesnt update photo' do
        @item.number = 'test2'
        @item.update_photo
        expect(@item.photo.filename).to eq('test1.jpg')
      end
    end
  end

  context 'scopes' do
    it 'active scope returns only items where qunatity > 0' do
      quantities = [0,10]
      quantities.each do |quantity|
        item = FactoryGirl.create(:item)
        magazine = FactoryGirl.create(:magazine)
        FactoryGirl.create(:stored_item, magazine: magazine, item: item, quantity: quantity)
      end

      expect(Item.active.length).to eq(1)
    end

    it 'with_photo scope returns only items with photo' do
      FactoryGirl.create(:item)
      FactoryGirl.create(:item).update_column(:photo, nil)

      expect(Item.with_photo.size).to eq(1)
    end
  end


  context 'calculation' do
    before(:each) do
      @item = FactoryGirl.build(:item)
      @stored_item1 = FactoryGirl.build(:stored_item, magazine_id: 1 , item_id: 1, quantity: 11, price: 22.50)
      @stored_item2 = FactoryGirl.build(:stored_item, magazine_id: 1 , item_id: 1, quantity: 12, price: 30.50)
      @stored_item3 = FactoryGirl.build(:stored_item, magazine_id: 1 , item_id: 1, quantity: 13, price: 28.50)
      @item.stored_items << [@stored_item1, @stored_item2, @stored_item3]
    end
    it 'price is biggest price from all magazines' do
      expect(@item.price).to eq(30.50)
    end
    it 'quantity is sum from all magazines' do
      expect(@item.quantity).to eq(36)
    end
  end

  context 'search' do
    before(:each) do
      @item = FactoryGirl.create(:stored_item)
    end
    it 'returns items when number matched' do
      expect(Item.search('23456').length).to eq(1)
    end
    it 'returns items when name matched' do
      expect(Item.search('Wózek').length).to eq(1)
    end
    it 'returns items with 0 quantity' do
      FactoryGirl.create(:stored_item, quantity:0)
      expect(Item.search('Wózek').length).to eq(2)
    end
    it 'returns items ordered by add_date' do
      item = FactoryGirl.create(:item,created_at: 2.days.from_now)
      expect(Item.search('Wózek').first.id).to eq(item.id)
    end
    it 'doesnt returns items when number or name matched' do
      expect(Item.search('xxx').length).to eq(0)
    end
  end

  context 'generate barcode' do
    it 'generates proper barcode' do
      item = FactoryGirl.build(:item, number: "2120067823")
      item.generate_barcode
      expect(item.barcode).to eq "5900851678234"
    end
    it 'create barcode before save' do
      item = FactoryGirl.build(:item, number: "1720036450")
      item.save
      expect(item.barcode).to eq "5900851364502"
    end
  end


end
