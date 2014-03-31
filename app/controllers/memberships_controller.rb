#encoding: utf-8
require 'digest/sha2'
require 'openssl/cipher'
require 'base64'

class MembershipsController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :checkcaptcha, :only => [:create, :login]


	# GET /memberships
	def index
		if not refinery_user?
			respond_with ret = nil, :location => nil do |format|
				format.html { redirect_to "/" }
			end and return
		end

		@memberships = Membership.all
		respond_with @memberships do |format|
			format.json { render :json => @memberships.to_json(:include => :addresses) }
			format.xml { render :xml => @memberships.to_xml(:include => :addresses) }
		end
	end


	# GET /memberships/1
	def show
		if refinery_user?
			@membership = Membership.find params[:id]
		else
			@membership = Membership.find :first, :conditions => { :nickname => session[:nickname] }
		end

		respond_with @membership do |format|
			format.json { render :json => @membership.to_json(:include => :addresses) }
			format.xml { render :xml => @membership.to_xml(:include => :addresses) }
		end
	end


	# GET /memberships/new
	def new
		@membership = Membership.new
		respond_with @membership
	end


	# GET /memberships/1/edit
	def edit
		if refinery_user?
			@membership = Membership.find params[:id]
		else
			@membership = Membership.find :first, :conditions => { :nickname => session[:nickname] }
		end

		respond_with @membership
	end


	# POST /memberships
	def create
		@membership = Membership.find :first, :conditions => { :nickname => params[:membership][:nickname] }
		if @membership
			respond_with ret = { :status => 0, :description => "User exist" }, :location => nil, :status => :forbidden and return
		end

		cipher = OpenSSL::Cipher::Cipher.new 'DES3'
		cipher.encrypt
		cipher.key = Altarf::Application.config.membership_secret_token

		iv = Digest::SHA256.new
		iv.update params[:membership][:nickname]
		cipher.iv = iv.hexdigest

		result = cipher.update params[:membership][:password]
		result << cipher.final
		pswd = Base64.strict_encode64 result
		params[:membership].delete :password

		@membership = Membership.new params[:membership]
		@membership.password = pswd.to_s
		@membership.save

		ret = OfficialService.addmemberinfo(params[:membership])
		if not ret["item"]["is_success"] == "True"
			Rails.logger.info ret.to_json
		end

		@membership[:status] = 1
		respond_with @membership
	end


	# PUT /memberships/1
	def update
		cipher = OpenSSL::Cipher::Cipher.new 'DES3'
		cipher.encrypt
		cipher.key = Altarf::Application.config.membership_secret_token

		iv = Digest::SHA256.new
		iv.update params[:membership][:nickname]
		cipher.iv = iv.hexdigest

		result = cipher.update params[:membership][:password]
		result << cipher.final
		pswd = Base64.strict_encode64 result

		if refinery_user?
			@membership = Membership.find params[:id]
		else
			@membership = Membership.find :first, :conditions => { :nickname => session[:nickname] }
		end

		@membership.update_attributes params[:membership]
		@membership.password = pswd.to_s

		ret = OfficialService.updatememberinfo params[:membership]
		if not ret["item"]["is_success"] == "True"
			Rails.logger.info ret.to_json
		end

		session[:nickname] = params[:nickname]
		respond_with @membership
	end


	# DELETE /memberships/1
	def destroy
		if refinery_user?
			@membership = Membership.find params[:id]
		else
			@membership = Membership.find :first, :conditions => { :nickname => session[:nickname] }
		end

		@membership.destroy
		respond_with @membership
	end


	# GET /memberships/login
	# POST /memberships/login
	def login
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

			hash = Digest::SHA256.new
			hash.update clearpswd
			hash.update params[:captcha]

		rescue
			Rails.logger.error $!.backtrace
			hash = Digest::SHA256.new
		end

		if hash.hexdigest == params[:password]
			session[:nickname] = params[:nickname]
			respond_with ret = { :status => 1 }, :location => nil, :status => :accepted and return
		else
			session[:nickname] = nil
			respond_with ret = { :status => 0, :description => "Wrong password" }, :location => nil, :status => :unauthorized and return
		end
	end


	# GET /memberships/getcode
	def getcode
		ret = OfficialService.createdynamiccheckcode params[:mobile]
		if not ret["item"]["is_success"] == "True"
			Rails.logger.info ret.to_json
		end

		respond_with ret, :location => nil and return
	end


	private

	def checkcaptcha
		if not simple_captcha_valid?
			respond_with ret = { :status => 2 }, :location => nil, :status => :forbidden and return
		end
	end


	def checkcode(mobile, code)
		ret = OfficialService.checkcheckcode mobile, code
		if not ret["item"]["is_success"] == "True"
			Rails.logger.info ret.to_json
		end

		return ret["item"]["return"]
	end

end
