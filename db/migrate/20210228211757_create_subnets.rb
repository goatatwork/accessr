class CreateSubnets < ActiveRecord::Migration[6.1]
  def change
    create_table :subnets do |t|
      t.string :name
      t.string :network_address
      t.integer :cidr
      t.references :shared_network, null: false, foreign_key: true

      t.timestamps
    end
  end
end
