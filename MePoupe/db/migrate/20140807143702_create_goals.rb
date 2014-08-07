class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :titulo
      t.text :descricao
      t.date :inicio
      t.date :fim
      t.integer :estado

      t.timestamps
    end
  end
end
