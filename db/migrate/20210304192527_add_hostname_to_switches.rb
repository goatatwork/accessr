class AddHostnameToSwitches < ActiveRecord::Migration[6.1]
  def change
    add_column :switches, :hostname, :string
  end
end
