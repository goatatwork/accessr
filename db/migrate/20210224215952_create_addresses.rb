class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal_code
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
