class AddDescriptionCvToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :description_cv, :text, null: false, default: ""
  end
end
