class CreateDanceStyles < ActiveRecord::Migration[7.0]
  def change
    create_table :dance_styles do |t|
      t.string :name, null: false
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
