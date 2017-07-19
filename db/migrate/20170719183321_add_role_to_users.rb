class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 0

    create_table :projects_users do |t|
      t.belongs_to :project, null: false
      t.belongs_to :user, null: false
    end
  end
end
