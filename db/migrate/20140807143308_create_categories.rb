class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :titulo
      t.string :cor
      t.text :descricao

      t.timestamps
    end
  end
end
