# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  parent_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  items_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Category, type: :model do

  it 'has valid factory' do
    expect(FactoryGirl.build(:category)).to be_valid
  end

  it 'has valid category_root factory' do
    expect(FactoryGirl.build(:category_root)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:category, name: nil)).not_to be_valid
  end

  context 'counter cache items' do
    before(:each) do
      @stored_item = FactoryGirl.create(:stored_item)
      @item = @stored_item.item
      @category = @item.category
    end
    context 'count_items' do
      it 'counts number of active items in category' do
        expect(@category.count_items).to eq(1)
      end
      it 'doesnt count same items from different magazines' do
        @category.items << FactoryGirl.create(:item)
        expect(@category.count_items).to eq(1)
      end
      it 'doesnt count items with 0 quantity' do
        item = FactoryGirl.create(:item,category_id: @category.id)
        stored = FactoryGirl.create(:stored_item, item_id: item.id, quantity: 0)
        expect(@category.count_items).to eq(1)
        stored.update(quantity: 1)
        expect(@category.count_items).to eq(2)
      end
      it 'doesnt count items without photo' do
        @item.update_column(:photo, nil)
        expect(@category.count_items).to eq(0)
      end
    end
    context 'update items_count' do
      it 'updates items_count column' do
        @category.update_items_counter
        expect(@category.reload.items_count).to eq(1)
      end
      it 'updates parent items_count' do
        @category.update_parent_counter
        expect(@category.parent.items_count).to eq(1)
      end
    end
  end
end
