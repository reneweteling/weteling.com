

class CreateActiveAdminComments < ActiveRecord::Migration[5.1]
  def self.up
    create_table :active_admin_comments do |t|
      t.string :namespace
      t.text   :body
      t.string :resource_id,   null: false
      t.string :resource_type, null: false
      t.references :author, polymorphic: true
      t.timestamps
    end
    add_index :active_admin_comments, [:namespace]

    add_index :active_admin_comments, [:resource_type, :resource_id]

    add_column :hours, :sno_hours, :decimal, precision: 4, scale: 2, null: false, default: 0
    add_reference :clients, :default_rate, references: :rates, index: true
  end

  def self.down
    drop_table :active_admin_comments
  end
end
