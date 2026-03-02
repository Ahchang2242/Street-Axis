class AddImageToContactInfos < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_infos, :image, :string
  end
end
