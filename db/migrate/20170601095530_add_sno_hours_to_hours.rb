class AddSnoHoursToHours < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :default_rate, references: :rates, index: true
  end
end
