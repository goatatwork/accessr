class RemoveSwitchInformedFromPorts < ActiveRecord::Migration[6.1]
  def change
    change_table :ports do |table|
      table.remove :switch_informed
    end
  end
end
