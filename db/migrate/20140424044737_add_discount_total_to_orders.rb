class AddDiscountTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount, :float
    add_column :orders, :total, :float
  end
end
