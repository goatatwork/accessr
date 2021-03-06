class AddSshUserToSwitches < ActiveRecord::Migration[6.1]
  def change
    add_column :switches, :ssh_user, :string
  end
end
