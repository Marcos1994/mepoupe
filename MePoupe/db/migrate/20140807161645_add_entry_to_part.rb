class AddEntryToPart < ActiveRecord::Migration
  def change
    add_reference :parts, :entry, index: true
  end
end
