class CreateOperationLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :operation_logs do |t|
      t.references :user, foreign_key: true
      t.string :action, null: false
      t.string :resource_type
      t.integer :resource_id
      t.text :details
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
    add_index :operation_logs, [:resource_type, :resource_id]
    add_index :operation_logs, :action
    add_index :operation_logs, :created_at
  end
end
