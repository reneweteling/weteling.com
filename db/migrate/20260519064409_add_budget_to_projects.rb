class AddBudgetToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :budget, :decimal, precision: 10, scale: 2
  end
end
