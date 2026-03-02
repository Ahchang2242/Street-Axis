class CreateWebModules < ActiveRecord::Migration[7.0]
  def change
    create_table :web_modules do |t|
      t.string :name, null: false
      t.string :identifier, null: false, unique: true
      t.text :description
      t.boolean :is_active, default: true
      t.json :config
      t.integer :position, default: 0
      t.integer :usage_count, default: 0

      t.timestamps
    end
  end
end
