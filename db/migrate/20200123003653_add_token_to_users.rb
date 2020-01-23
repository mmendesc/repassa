class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :token, :string
    add_column :managers, :token, :string
  end
end
