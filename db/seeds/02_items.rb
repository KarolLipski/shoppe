
category_ids = [3,4,5,6,7,8,9,10, 12,13,14,15]

magazine_1 = FactoryGirl.create(:magazine)
magazine_2 = FactoryGirl.create(:magazine, number: 2114)

category_ids.each do |cat_id|
  30.times do
    item = FactoryGirl.create(:item, category_id: cat_id)
    stored_item_1 = FactoryGirl.create(:stored_item, magazine: magazine_1, item: item, quantity: 10, price: 9.99)
    stored_item_2 = FactoryGirl.create(:stored_item, magazine: magazine_2, item: item, quantity: 20, price: 10.99)
  end

end