class AddDisabledAtToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :disabled_at, :datetime, null: true
  end
end
