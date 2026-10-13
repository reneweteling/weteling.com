class MoveTafelRushNextToHeadsUp < ActiveRecord::Migration[8.1]
  def up
    App.find_by(name: 'Tafel Rush')&.insert_at(2)
  end

  def down
    App.find_by(name: 'Tafel Rush')&.move_to_bottom
  end
end
