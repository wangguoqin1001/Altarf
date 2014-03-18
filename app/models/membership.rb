class Membership < ActiveRecord::Base
  attr_accessible :addr, :city, :district, :email, :gender, :mobile, :nickname, :phone, :postal, :province, :username
end
