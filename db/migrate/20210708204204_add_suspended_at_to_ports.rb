class AddSuspendedAtToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :suspended_at, :datetime, null: true
  end
end
