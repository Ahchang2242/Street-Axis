class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :date
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
