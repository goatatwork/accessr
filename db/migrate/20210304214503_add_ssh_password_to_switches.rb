class AddSshPasswordToSwitches < ActiveRecord::Migration[6.1]
  def change
    add_column :switches, :ssh_password, :string
  end
end
