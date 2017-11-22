class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.integer :pagetype, null: false, default: 0
      t.text :content, null: false, default: ""

      t.timestamps
    end
  end
end
