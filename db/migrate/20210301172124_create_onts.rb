class CreateOnts < ActiveRecord::Migration[6.1]
  def change
    create_table :onts do |t|
      t.string :name
      t.string :manufacturer
      t.string :model

      t.timestamps
    end
  end
end
