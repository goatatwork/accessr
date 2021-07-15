class AddSubscriberIdToPorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ports, :subscriber_id, :string, null: true
  end
end
