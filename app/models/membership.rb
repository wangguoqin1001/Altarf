class Membership < ActiveRecord::Base
  attr_accessible :addr, :city, :district, :email, :gender, :mobile, :nickname, :password, :phone, :postal, :province, :username
end
