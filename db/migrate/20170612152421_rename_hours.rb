class RenameHours < ActiveRecord::Migration[5.1]
  def change
    rename_column :hours, :hours, :total_hours
    rename_column :hours, :sno_hours, :total_sno_hours
  end
end
