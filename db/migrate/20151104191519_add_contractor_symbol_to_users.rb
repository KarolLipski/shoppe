class AddContractorSymbolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contractor_sym, :string, after: :name
  end
end
