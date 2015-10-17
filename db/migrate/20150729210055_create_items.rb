class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :number
      t.string :name
      t.integer :small_wrap
      t.integer :big_wrap
      t.string :photo

      t.timestamps null: false
    end
  end
end
