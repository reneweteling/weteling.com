# Rates were a separate table referenced by hours and clients. Store the
# amount directly: a default rate per project, and the actual rate per hour.
class ReplaceRatesWithValues < ActiveRecord::Migration[8.1]
  def up
    add_column :projects, :default_rate, :decimal, precision: 8, scale: 2
    add_column :hours, :rate, :decimal, precision: 8, scale: 2

    execute <<~SQL
      UPDATE hours SET rate = rates.rate
      FROM rates WHERE rates.id = hours.rate_id
    SQL

    execute <<~SQL
      UPDATE projects SET default_rate = rates.rate
      FROM clients JOIN rates ON rates.id = clients.default_rate_id
      WHERE clients.id = projects.client_id
    SQL

    change_column_null :hours, :rate, false

    remove_reference :hours, :rate, foreign_key: true, index: true, type: :integer
    remove_reference :clients, :default_rate, index: true
    drop_table :rates
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
