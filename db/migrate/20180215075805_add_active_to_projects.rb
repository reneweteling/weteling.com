class AddActiveToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :hours_active, :boolean, default: false, null: false
    add_column :projects, :site_active, :boolean, default: false, null: false
    add_column :projects, :description_about_the_company, :text
    add_column :projects, :description_my_role, :text

    create_table :projects_tags do |t|
      t.belongs_to :project
      t.belongs_to :tag
    end
  end
end
