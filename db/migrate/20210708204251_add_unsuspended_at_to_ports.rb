class AddUnsuspendedAtToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :unsuspended_at, :datetime, null: true
  end
end
