class CreateSwitchConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :switch_configs do |t|
      t.string :name
      t.boolean :active
      t.references :switch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
