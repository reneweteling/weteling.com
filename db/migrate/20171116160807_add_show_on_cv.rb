class AddShowOnCv < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :cv_active, :boolean, default: false, null: false
  end
end
