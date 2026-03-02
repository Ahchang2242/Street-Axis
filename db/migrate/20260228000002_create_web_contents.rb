class CreateWebContents < ActiveRecord::Migration[7.0]
  def change
    create_table :web_contents do |t|
      t.string :title, null: false
      t.string :slug, null: false, unique: true
      t.text :content
      t.text :summary
      t.string :content_type, default: 'page'
      t.boolean :is_published, default: false
      t.datetime :published_at
      t.integer :position, default: 0
      t.string :meta_title
      t.text :meta_description
      t.string :meta_keywords
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :web_contents, :slug
    add_index :web_contents, :content_type
    add_index :web_contents, :is_published
  end
end
