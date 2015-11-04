class AddOdbSymbolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reciver_sym, :string, after: :contractor_sym
  end
end
