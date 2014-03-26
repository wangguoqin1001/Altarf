class Membership < ActiveRecord::Base
  attr_accessible :addr, :city, :district, :email, :gender, :mobile, :nickname, :phone, :postal, :province, :username, :created_at, :updated_at
  has_many :membership_addresses
end
