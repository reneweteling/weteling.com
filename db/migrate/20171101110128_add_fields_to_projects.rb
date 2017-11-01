class AddFieldsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :title, :string
    add_column :projects, :subtitle, :string
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
    add_column :projects, :show, :boolean, default: false, null: false
    add_column :projects, :position, :integer, default: 0, null: false
    add_column :projects, :image, :string
  end
end
