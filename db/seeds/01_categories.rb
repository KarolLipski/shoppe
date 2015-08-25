# encoding: UTF-8

def create_with_child(params, parent_id)
  category = Category.create(:id => params['id'], :name => params['name'], :parent_id => parent_id)
  params['children'].each do |param|
    create_with_child(param, category.id)
  end if params['children']
end

categories = [
  {'id' => 1001, 'name' => 'Pojazdy', 'children' => [
      {'id' => 1, 'name' => 'Na radio'},
      {'id' => 2, 'name' => 'Na baterie'},
      {'id' => 3, 'name' => 'Autka'},
      {'id' => 4, 'name' => 'Motory i Statki'},
      {'id' => 5, 'name' => 'Czołgi Helikoptery Samoloty'},
      {'id' => 6, 'name' => 'Traktory i budowlane'},
      {'id' => 7, 'name' => 'Kolejki, Tory'},
      {'id' => 45, 'name' => 'Zestawy Aut'},
      ]},
  {'id' => 1002, 'name' => 'Lalki', 'children' => [
      {'id' => 10, 'name' => 'Funkcyjne'},
      {'id' => 11, 'name' => 'Lalki'},
      {'id' => 12, 'name' => 'Akcesoria'},
      {'id' => 13, 'name' => 'Przytulanki'},
    ]},
  {'id' => 1005, 'name' => 'Zabawki Pluszowe', 'children' => [
      {'id' => 31, 'name' => 'Funkcyjne'},
      {'id' => 32, 'name' => 'Walentynka'},
      {'id' => 33, 'name' => 'Świąteczne'},
      {'id' => 30, 'name' => 'Zwykłe'},
  ]},
  {'id' => 25, 'name' => 'Zabawki Drewniane'},
  {'id' => 24, 'name' => 'Zabawki Edukacyjne'},
  {'id' => 9, 'name' => 'Dla Najmłodszych'},
  {'id' => 8, 'name' => 'Muzyczne'},
  {'id' => 1003, 'name' => 'Zestawy', 'children' => [
      {'id' => 14, 'name' => 'Lekarskie'},
      {'id' => 15, 'name' => 'Kuchenne'},
      {'id' => 16, 'name' => 'Piękności'},
      {'id' => 44, 'name' => 'Koraliki'},
      {'id' => 28, 'name' => 'Narzędzi'},
      {'id' => 17, 'name' => 'Wojskowe Pirackie Rycerzy'},
    ]},
  {'id' => 22, 'name' => 'Klocki'},
  {'id' => 65756, 'name' => 'Klocki Sluban'},
  {'id' => 23, 'name' => 'Koniki'},
  {'id' => 18, 'name' => 'Zwierzęta'},
  {'id' => 19, 'name' => 'Domki i mebelki'},
  {'id' => 27, 'name' => 'Małe AGD'},
  {'id' => 20, 'name' => 'Figurki i roboty'},
  {'id' => 21, 'name' => 'Pistolety i miecze'},
  {'id' => 41, 'name' => 'Pistolety na wodę'},
  {'id' => 26, 'name' => 'Gry'},
  {'id' => 43, 'name' => 'Świecące i żelowe'},
  {'id' => 29, 'name' => 'Modele do sklejania'},
  {'id' => 36, 'name' => 'Wózki'},
  {'id' => 34, 'name' => 'Trójkołowce Hulajnogi Chodziki'},

  {'id' => 1004, 'name' => 'Artykuły Sportowe', 'children' => [
      {'id' => 37, 'name' => 'Piłki'},
      {'id' => 38, 'name' => 'Lyżworolki'},
      {'id' => 39, 'name' => 'Pozostałe'},
  ]},
  {'id' => 35, 'name' => 'Plecaki'},
  {'id' => 40, 'name' => 'Karnawał'},
  {'id' => 42, 'name' => 'Inne'},
  {'id' => 46, 'name' => 'Święta'},


















]


categories.each do |main|
  create_with_child(main,nil)
end