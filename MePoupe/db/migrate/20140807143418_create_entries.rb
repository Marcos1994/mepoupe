class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :titulo
      t.text :descricao
      t.integer :tipo
      t.integer :periodicidade

      t.timestamps
    end
  end
end
