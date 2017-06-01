class AddSnoHoursToHours < ActiveRecord::Migration[5.1]
  def change
    add_column :hours, :sno_hours, :decimal, precision: 4, scale: 2, null: false, default: 0
    add_reference :clients, :default_rate, references: :retes, index: true, foreign_key: true
  end
end
