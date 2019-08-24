require "securerandom"

class Coupon < ActiveRecord::Base
	before_create :generate_uuid

	private
	def generate_uuid
		self.uuid = SecureRandom.uuid
	end

	def coupon_params
		params.require(:coupon).permit(:coupon, :discount, :percentage_off, :sku)
	end
end
