class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :uuid
      t.string :sku
      t.string :coupon
      t.float :discount
      t.float :percentage_off

      t.timestamps
    end
  end
end
