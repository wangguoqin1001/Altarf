#encoding: utf-8
require 'digest/sha2'
require 'openssl/cipher'
require 'base64'

class ApiMembershipsController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :checkadmin, :except => [:login]

	skip_before_filter :verify_authenticity_token

	Admins = ["admin", "zombiesir"]


	# GET /memberships
	def index
		@memberships = Membership.all
		respond_with @memberships
	end


	# GET /memberships/1
	def show
		if params[:id].to_i == 0
			@membership = Membership.find :first, :conditions => { :nickname => params[:nickname] }
		else
			@membership = Membership.find params[:id]
		end

		respond_with @membership
	end


	# GET /memberships/new
	def new
		@membership = Membership.new
		respond_with @membership
	end


	# GET /memberships/1/edit
	def edit
		if params[:id].to_i == 0
			@membership = Membership.find :first, :conditions => { :nickname => params[:nickname] }
		else
			@membership = Membership.find params[:id]
		end

		respond_with @membership
	end


	# POST /memberships
	def create
		@membership = Membership.find :first, :conditions => { :nickname => params[:membership][:nickname] }
		if @membership
			respond_with ret = { :status => 0, :description => "User exist" }, :location => nil, :status => :forbidden and return
		end

		@membership = Membership.new params[:membership]
		@membership.save

		@membership[:status] = 1
		respond_with @membership
	end


	# PUT /memberships/1
	def update
		if params[:id].to_i == 0
			@membership = Membership.find :first, :conditions => { :nickname => params[:nickname] }
		else
			@membership = Membership.find params[:id]
		end

		@membership.update_attributes params[:membership]

		session[:nickname] = params[:nickname]
		respond_with @membership
	end


	# DELETE /memberships/1
	def destroy
		if params[:id].to_i == 0
			@membership = Membership.find :first, :conditions => { :nickname => params[:nickname] }
		else
			@membership = Membership.find params[:id]
		end

		@membership.destroy
		respond_with @membership
	end


	# GET /memberships/login
	def login
		if not Admins.include? params[:nickname]
			respond_with ret = { :status => 0, :description => "Not permitted" }, :location => nil, :status => :forbidden and return
		end

		@membership = Membership.find :first, :conditions => { :nickname => params[:nickname] }
		if not @membership
			respond_with ret = { :status => 0, :description => "No such user" }, :location => nil, :status => :unauthorized and return
		end

		begin
			pswd = Base64.strict_decode64 @membership[:password]

			cipher = OpenSSL::Cipher::Cipher.new 'DES3'
			cipher.decrypt
			cipher.key = Altarf::Application.config.membership_secret_token

			iv = Digest::SHA256.new
			iv.update params[:nickname]
			cipher.iv = iv.hexdigest

			clearpswd = cipher.update pswd
			clearpswd << cipher.final
		rescue
			Rails.logger.error $!.backtrace
			respond_with ret = { :status => 0, :description => "Wrong password" }, :location => nil, :status => :unauthorized and return
		end

		if clearpswd == params[:password]
			session[:nickname] = "admin"
			respond_with ret = { :status => 1 }, :location => nil, :status => :accepted and return
		else
			session[:nickname] = nil
			respond_with ret = { :status => 0, :description => "Wrong password" }, :location => nil, :status => :unauthorized and return
		end
	end


	private

	def checkadmin
		return
		if not session[:nickname] == "admin"
			respond_with ret = { :status => 2 }, :location => nil, :status => :forbidden and return
		end
	end

end
