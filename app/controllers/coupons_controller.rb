class CouponsController < ApplicationController

	respond_to :json, :xml, :html

	before_action :checkadmin, :except => [:checkcoupon]


	# GET /coupons
	def index
		@coupons = Coupon.all
		respond_with @coupons
	end


	# GET /coupons/1
	def show
		@coupon = Coupon.find params[:id]
		respond_with @coupon
	end


	# GET /coupons/new
	def new
		@coupon = Coupon.new
		respond_with @coupon
	end


	# GET /coupons/1/edit
	def edit
		@coupon = Coupon.find params[:id]
	end


	# POST /coupons
	def create
		@coupon = Coupon.new params[:coupon]
		@coupon.save
		respond_with @coupon
	end


	# PUT /coupons/1
	def update
		@coupon = Coupon.find params[:id]
		@coupon.update_attributes params[:coupon]
		respond_with @coupon
	end


	# DELETE /coupons/1
	def destroy
		@coupon = Coupon.find params[:id]
		@coupon.destroy
		respond_with @coupon
	end


	# GET /coupons/checkcoupon
	def checkcoupon
		@coupon = Coupon.find :first, :conditions => { :coupon => params[:coupon], :sku => params[:sku] }
		respond_with @coupon
	end


	private

	def checkadmin
		if not refinery_user?
			respond_with ret = { :status => 0 }, :location => nil, :status => :unauthorized and return
		end
	end
end
