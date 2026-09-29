class CreateApps < ActiveRecord::Migration[8.1]
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :platform
      t.string :tagline_nl
      t.string :tagline_en
      t.text :description_nl
      t.text :description_en
      t.string :image
      t.integer :position, default: 0, null: false
      t.boolean :active, default: true, null: false
      t.timestamps
    end
  end
end
