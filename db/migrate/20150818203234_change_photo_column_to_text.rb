class ChangePhotoColumnToText < ActiveRecord::Migration
  def change
    change_column :items, :photo, :text
  end
end
