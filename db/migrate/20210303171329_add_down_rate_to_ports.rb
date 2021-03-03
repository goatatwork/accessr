class AddDownRateToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :down_rate, :integer, null: true
  end
end
