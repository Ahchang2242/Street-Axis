class CreateContactInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_infos do |t|
      t.string :address
      t.string :phone
      t.string :email
      t.string :business_hours

      t.timestamps
    end
  end
end
