class ChangeOrderProductId < ActiveRecord::Migration
  def change
    change_column :orders, :productid, :string
  end
end
