class AddPasswordToUsers < ActiveRecord::Migration
  # 7.1.2 A Password Migration
  def change
    add_column :users, :encrypted_password, :string
  end
end
