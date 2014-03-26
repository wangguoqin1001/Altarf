class CreateMembershipAddresses < ActiveRecord::Migration
  def change
    create_table :membership_addresses do |t|
      t.integer :membership_id
      t.string :username
      t.string :mobile
      t.string :phone
      t.string :province
      t.string :city
      t.string :district
      t.integer :postal
      t.string :addr

      t.timestamps
    end
  end
end
