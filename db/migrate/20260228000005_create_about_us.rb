class CreateAboutUs < ActiveRecord::Migration[7.0]
  def change
    create_table :about_us do |t|
      t.text :mission
      t.text :teaching_philosophy
      t.string :image

      t.timestamps
    end
  end
end
