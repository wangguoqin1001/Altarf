class Address < ActiveRecord::Base
  attr_accessible :addr, :city, :district, :membership_id, :mobile, :phone, :postal, :province, :username
  belongs_to :membership
end
