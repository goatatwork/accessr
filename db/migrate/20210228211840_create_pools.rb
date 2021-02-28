class CreatePools < ActiveRecord::Migration[6.1]
  def change
    create_table :pools do |t|
      t.string :name
      t.string :start_ip
      t.string :end_ip
      t.references :subnet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
