class AddressesController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :load_membership


	# GET /addresses
	def index
		@addresses = @membership.addresses.all
		respond_with @addresses
	end

	# GET /addresses/1
	def show
		@address = @membership.addresses.find params[:id]
		respond_with @address
	end

	# GET /addresses/new
	def new
		@address = @membership.addresses.new
		respond_with @address
	end

	# GET /addresses/1/edit
	def edit
		@address = @membership.addresses.find params[:id]
		respond_with @address
	end

	# POST /addresses
	def create
		@address = @membership.addresses.new params[:address]
		@address.save
		respond_with @address
	end

	# PUT /addresses/1
	def update
		@address = @membership.addresses.find params[:id]
		@address.update_attributes params[:address]
		respond_with @address
	end

	# DELETE /addresses/1
	def destroy
		@address = @membership.addresses.find params[:id]
		@address.destroy
		respond_with @address
	end


	private

	def load_membership
		if refinery_user?
			@membership = Membership.find params[:membership_id]
		else
			@membership = Membership.find :first, :conditions => { :nickname => session[:nickname] }
		end
	end
end
