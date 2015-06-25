# encoding: UTF-8

def create_witch_child(params, parent_id)
  category = Category.create(:id => params['id'], :name => params['name'], :parent_id => parent_id)
  params['children'].each do |param|
    create_witch_child(param, category.id)
  end if params['children']
end

categories = [
  {'id' => 2, 'name' => 'Pojazdy', 'children' => [
  {'id' => 3, 'name' => 'Na radio'},
  {'id' => 4, 'name' => 'Na baterie'},
  {'id' => 5, 'name' => 'Autka'},
  {'id' => 6, 'name' => 'Motory i Statki'},
  {'id' => 7, 'name' => 'Czołgi Helikoptery Samoloty'},
  {'id' => 8, 'name' => 'Traktory i budowlane'},
  {'id' => 9, 'name' => 'Kolejki, Tory'},
  {'id' => 10, 'name' => 'Zestawy Aut'},
      ]},
  {'id' => 11, 'name' => 'Lalki', 'children' => [
  {'id' => 12, 'name' => 'Funkcyjne'},
  {'id' => 13, 'name' => 'Lalki'},
  {'id' => 14, 'name' => 'Akcesoria'},
  {'id' => 15, 'name' => 'Przytulanki'},
    ]}
]


categories.each do |main|
  create_witch_child(main,nil)
end