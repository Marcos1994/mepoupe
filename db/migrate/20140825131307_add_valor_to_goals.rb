class AddValorToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :valor, :float
  end
end
