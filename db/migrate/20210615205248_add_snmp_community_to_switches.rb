class AddSnmpCommunityToSwitches < ActiveRecord::Migration[6.1]
  def change
    add_column :switches, :snmp_community, :string, null: true
  end
end
