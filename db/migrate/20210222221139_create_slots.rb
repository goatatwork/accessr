class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.integer :slot_number
      t.string :name
      t.text :description
      t.switch :references

      t.timestamps
    end
  end
end
