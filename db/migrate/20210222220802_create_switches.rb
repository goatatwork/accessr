class CreateSwitches < ActiveRecord::Migration[6.1]
  def change
    create_table :switches do |t|
      t.string :name
      t.string :manufacturer
      t.string :model
      t.string :management_ip

      t.timestamps
    end
  end
end
