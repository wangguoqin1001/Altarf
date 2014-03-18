class Order < ActiveRecord::Base
  attr_accessible :addr, :billing, :city, :coupon, :district, :invoice_title, :mobile, :need_invoice, :nickname, :payment, :phone, :postal, :productid, :province, :quantity, :username, :created_at, :updated_at
end
