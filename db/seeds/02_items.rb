
magazines = [1113,5016]
magazines.each do |mag|
  FactoryGirl.create(:magazine, number: mag)
end

file = File.join('public/actualizations/first_import.csv')
CsvImporter::ItemsImporter.new.import_items(file, 'utf-8')
