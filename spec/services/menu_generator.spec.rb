require 'rails_helper'

describe MenuGenerator do
  it 'finds active offer on init' do
    offer = double('Offer')
    expect(Offer).to receive(:active).and_return(offer)
    generator = MenuGenerator.new
    expect(generator.offer).to eq offer
  end

  it 'returns set of offer categories ids' do
    root_cat = FactoryGirl.create(:category_root)
    cat = FactoryGirl.create(:category)
    cat2 = FactoryGirl.create(:category, parent: root_cat)
    generator = MenuGenerator.new
    expect(Category).to receive(:all_for_offer).and_return([root_cat,cat])
    expect(generator.offer_ids).to eq(([root_cat.id,cat.id,cat.parent.id]).to_set)
  end

  context 'magazine categories' do
    before(:each) do
      @category = FactoryGirl.create(:category_root)
      @generator = MenuGenerator.new
      @categories = @generator.magazine_categories
    end
    it 'returns array with root categories' do
      expect(@categories.length).to eq 1
    end
    it 'returned array element structure contain categories and subcategories' do
      expect(@categories[0][:category]).to eq @category
      expect(@categories[0][:subcategories]).to eq @category.subcategories
    end
  end

  context 'offer categories' do
    before(:each) do
      @category = FactoryGirl.create(:category_root)
    end
    it 'returns array with root categories' do
      generator = MenuGenerator.new
      expect(generator).to receive(:offer_ids).and_return([@category.id].to_set)
      categories = generator.offer_categories
      expect(categories.length).to eq 1
    end
    it 'filter category to offer categories' do
      generator = MenuGenerator.new
      expect(generator).to receive(:offer_ids).and_return(['abc'].to_set)
      categories = generator.offer_categories
      expect(categories.length).to eq 0
    end
    it 'returned array element structure contain categories and subcategories' do
      generator = MenuGenerator.new
      expect(generator).to receive(:offer_ids).and_return([@category.id].to_set)
      categories = generator.offer_categories
      expect(categories[0][:category]).to eq @category
      expect(categories[0][:subcategories]).to eq @category.subcategories
    end
  end

end