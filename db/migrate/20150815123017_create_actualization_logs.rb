class CreateActualizationLogs < ActiveRecord::Migration
  def change
    create_table :actualization_logs do |t|
      t.string :status
      t.integer :items_count
      t.text :error

      t.timestamps null: false
    end
  end
end
