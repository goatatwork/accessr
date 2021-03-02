class CreateProvisioningRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :provisioning_records do |t|
      t.references :location, null: true, foreign_key: true
      t.references :port, null: true, foreign_key: true
      t.references :ip, null: true, foreign_key: true
      t.references :ont, null: true, foreign_key: true

      t.timestamps
    end
  end
end
