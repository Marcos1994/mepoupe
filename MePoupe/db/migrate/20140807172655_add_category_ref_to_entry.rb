class AddCategoryRefToEntry < ActiveRecord::Migration
  def change
    add_reference :entries, :category, index: true
  end
end
