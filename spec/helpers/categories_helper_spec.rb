require 'rails_helper'

RSpec.describe CategoriesHelper, type: :helper do

  context 'name' do
    context 'when category has parrent' do
      it 'renders parent name and category name' do
        cat = FactoryGirl.create(:category)
        expect(helper.category_heading_name(cat)).to eq("#{cat.parent.name}: #{cat.name}")
      end
    end
    context 'when category has no parrent' do
      it 'renders only category name' do
        cat = FactoryGirl.create(:category_root)
        expect(helper.category_heading_name(cat)).to eq("#{cat.name}")
      end
    end
  end
end