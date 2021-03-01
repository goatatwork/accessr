class CreateDhcpServers < ActiveRecord::Migration[6.1]
  def change
    create_table :dhcp_servers do |t|
      t.string :name
      t.string :server_type

      t.timestamps
    end
  end
end
