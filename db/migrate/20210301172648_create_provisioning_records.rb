class CreateProvisioningRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :provisioning_records do |t|
      t.references :location, null: true, foreign_key: false
      t.references :port, null: true, foreign_key: false
      t.references :ip, null: true, foreign_key: false
      t.references :ont, null: true, foreign_key: false

      t.timestamps
    end
  end
end
