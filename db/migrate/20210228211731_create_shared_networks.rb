class CreateSharedNetworks < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_networks do |t|
      t.string :name
      t.string :relayed_from_ip
      t.references :dhcp_server, null: false, foreign_key: true

      t.timestamps
    end
  end
end
