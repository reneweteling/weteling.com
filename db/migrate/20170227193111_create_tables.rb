class CreateTables < ActiveRecord::Migration[5.0]
  def change

    create_table :clients do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :name, null: false
      t.string :first_name
      t.string :last_name
      t.string :department
      t.string :address
      t.string :postalcode
      t.string :city
      t.string :country
      t.string :email
      t.string :iban
      t.string :bic
      t.string :iban_name
      t.string :coc_no
      t.string :tax_no
      t.timestamps
    end

    create_table :projects do |t|
      t.belongs_to :client, foreign_key: true, null: false
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    create_table :rates do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :name, null: false
      t.text :description
      t.decimal :rate, precision: 5, scale: 2
      t.timestamps
    end

    create_table :hours do |t|
      t.belongs_to :project, foreign_key: true, null: false
      t.belongs_to :rate, foreign_key: true, null: false
      t.date :date, null: false
      t.decimal :hours, precision: 4, scale: 2, null: false, default: 0
      t.text :description, null: false
      t.timestamps
    end

  end
end
