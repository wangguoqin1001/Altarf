class OrdersController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :checkcaptcha, :only => [:create]


	# GET /orders
	def index
		if refinery_user? or session[:nickname] == "admin"
			@orders = Order.all
		else
			@orders = Order.find :all, :conditions => { :nickname => session[:nickname] }
		end

		respond_with @orders
	end


	# GET /orders/1
	def show
		@order = Order.find params[:id]

		if not refinery_user? and not session[:nickname] == "admin"
			if not session[:nickname] or not session[:nickname] == @order[:nickname]
				respond_with ret = nil, :location => nil do |format|
					format.html { redirect_to "/" }
				end and return
			end
		end

		respond_with @order
	end


	# GET /orders/new
	def new
		@order = Order.new
		respond_with @order
	end


	# GET /orders/1/edit
	def edit
		@order = Order.find params[:id]

		if not refinery_user? and not session[:nickname] == "admin"
			if not session[:nickname] or not session[:nickname] == @order[:nickname]
				respond_with ret = nil, :location => nil do |format|
					format.html { redirect_to "/" }
				end and return
			end
		end

		respond_with @order
	end


	# POST /orders
	def create
		@order = Order.new params[:order]

		if session[:nickname]
			if not session[:nickname] == "admin"
				@order[:nickname] = session[:nickname]
			end
		else
			respond_with ret = nil, :location => nil do |format|
				format.html { redirect_to "/" }
			end and return
		end

		@order.save
		@order[:status] = 1
		respond_with @order
	end


	# PUT /orders/1
	def update
		@order = Order.find params[:id]

		if not refinery_user? and not session[:nickname] == "admin"
			if not session[:nickname] or not session[:nickname] == @order[:nickname]
				respond_with ret = nil, :location => nil do |format|
					format.html { redirect_to "/" }
				end and return
			end
		end

		@order.update_attributes params[:order]
		respond_with @order
	end


	# DELETE /orders/1
	def destroy
		@order = Order.find params[:id]

		if not refinery_user? and not session[:nickname] == "admin"
			if not session[:nickname] or not session[:nickname] == @order[:nickname]
				respond_with ret = nil, :location => nil do |format|
					format.html { redirect_to "/" }
				end and return
			end
		end

		@order.destroy
		respond_with @order
	end


	private

	def checkcaptcha
		if not simple_captcha_valid? and not session[:nickname] == "admin"
			respond_with ret = { :status => 2 }, :location => nil and return
		end
	end

end
