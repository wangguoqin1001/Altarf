require "securerandom"

class Coupon < ActiveRecord::Base
	attr_accessible :coupon, :discount, :percentage_off, :sku
	before_create :generate_uuid

	private
	def generate_uuid
		self.uuid = SecureRandom.uuid
	end
end
