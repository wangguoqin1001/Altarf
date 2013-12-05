class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :productid
      t.integer :quantity
      t.string :coupon
      t.integer :payment
      t.string :nickname
      t.string :mobile
      t.string :phone
      t.string :province
      t.string :city
      t.string :district
      t.integer :postal
      t.string :addr
      t.integer :need_invoice
      t.string :invoice_title
      t.string :billing
      t.string :username

      t.timestamps
    end
  end
end
