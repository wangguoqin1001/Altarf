class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :nickname
      t.string :password
      t.string :username
      t.integer :gender
      t.string :mobile
      t.string :phone
      t.string :email
      t.string :province
      t.string :city
      t.string :district
      t.integer :postal
      t.string :addr

      t.timestamps
    end
  end
end
