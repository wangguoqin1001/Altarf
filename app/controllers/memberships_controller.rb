class MembershipsController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :checkcaptcha


	# GET /memberships
	def index
		if not refinery_user?
			respond_with ret = nil, :location => nil do |format|
				format.html { redirect_to "/" }
			end and return
		end

		@memberships = Membership.all
		respond_with @memberships
	end


	# GET /memberships/1
	def show
		@membership = Membership.find session[:nickname]
		respond_with @membership
	end


	# GET /memberships/new
	def new
		@membership = Membership.new
		respond_with @membership
	end


	# GET /memberships/1/edit
	def edit
		@membership = Membership.find session[:nickname]
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
		@membership = Membership.find session[:nickname]
		@membership.update_attributes params[:membership]
		respond_with @membership
	end


	# DELETE /memberships/1
	def destroy
		@membership = Membership.find params[:nickname]
		@membership.destroy
		respond_with @membership
	end


	private

	def checkcaptcha
		if not simple_captcha_valid?
			respond_with ret = { :status => 2 }, :location => nil and return
		end
	end

end
