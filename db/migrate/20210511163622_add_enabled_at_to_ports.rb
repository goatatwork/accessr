class AddEnabledAtToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :enabled_at, :datetime, null: true
  end
end
