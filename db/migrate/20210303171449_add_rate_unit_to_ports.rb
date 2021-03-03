class AddRateUnitToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :rate_unit, :string, default: 'kb'
  end
end
