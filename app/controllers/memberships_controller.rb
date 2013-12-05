class MembershipsController < ApplicationController

	respond_to :json, :xml, :html

	# GET /memberships
	def index
		@memberships = Membership.all
		respond_with @memberships
	end

	# GET /memberships/1
	def show
		@membership = Membership.find params[:id]
		respond_with @membership
	end

	# GET /memberships/new
	def new
		@membership = Membership.new
		respond_with @membership
	end

	# GET /memberships/1/edit
	def edit
		@membership = Membership.find params[:id]
		respond_with @membership
	end

	# POST /memberships
	def create
		@membership = Membership.new params[:membership]
		@membership.save
		respond_with @membership
	end

	# PUT /memberships/1
	def update
		@membership = Membership.find params[:id]
		@membership.update_attributes params[:membership]
		respond_with @membership
	end

	# DELETE /memberships/1
	def destroy
		@membership = Membership.find params[:id]
		@membership.destroy
		respond_with @membership
	end
end
