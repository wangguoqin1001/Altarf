class AddressesController < ApplicationController

	respond_to :json, :xml, :html

	# GET /addresses
	def index
		@addresses = Address.all
		respond_with @addresses
	end

	# GET /addresses/1
	def show
		@address = Address.find params[:id]
		respond_with @address
	end

	# GET /addresses/new
	def new
		@address = Address.new
		respond_with @address
	end

	# GET /addresses/1/edit
	def edit
		@address = Address.find params[:id]
		respond_with @address
	end

	# POST /addresses
	def create
		@address = Address.new params[:address]
		@address.save
		respond_with @address
	end

	# PUT /addresses/1
	def update
		@address = Address.find params[:id]
		@address.update_attributes params[:address]
		respond_with @address
	end

	# DELETE /addresses/1
	def destroy
		@address = Address.find params[:id]
		@address.destroy
		respond_with @address
	end
end
