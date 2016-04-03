class AddLogTypeToActualizationLog < ActiveRecord::Migration
  def change
    add_column :actualization_logs, :log_type, :string
  end
end
