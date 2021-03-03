class AddUpRateToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :up_rate, :integer, null: true
  end
end
