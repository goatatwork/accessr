class CreatePorts < ActiveRecord::Migration[6.1]
  def change
    create_table :ports do |t|
      t.integer :port_number
      t.string :name
      t.text :description
      t.references :portable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
