class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role, foreign_key: true
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :registration_ip, :string
    add_column :users, :online_status, :string, default: 'offline'
  end
end
