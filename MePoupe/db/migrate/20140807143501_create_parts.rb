class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.float :valor
      t.date :data
      t.integer :confirmacao

      t.timestamps
    end
  end
end
