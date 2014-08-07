class AddCategoryRefToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :category, index: true
  end
end
