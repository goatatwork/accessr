class AddSwitchInformedToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :switch_informed, :timestamp, null: true
  end
end
