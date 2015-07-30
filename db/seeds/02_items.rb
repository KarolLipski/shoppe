
category_ids = [3,4,5,6,7,8,9,10, 12,13,14,15]

category_ids.each do |cat_id|
  30.times do
    FactoryGirl.create(:item, category_id: cat_id)
  end

end