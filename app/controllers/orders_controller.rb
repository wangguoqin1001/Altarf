class OrdersController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :checkcaptcha, :only => [:create]


	# GET /orders
	def index
		if refinery_user?
			@orders = Order.all
		else
			@orders = Order.find :all, :conditions => { :nickname => session[:nickname] }
		end

		respond_with @orders
	end


	# GET /orders/1
	def show
		@order = Order.find params[:id]

		if not refinery_user?
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

		if not refinery_user?
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
		@order = Order.new params[:order].except(:discount)

		if session[:nickname]
			@order[:nickname] = session[:nickname]
		else
			respond_with ret = nil, :location => nil do |format|
				format.html { redirect_to "/" }
			end and return
		end

		@product = Product.find @order[:productid].to_s
		@discount = MemberDiscount.memberdiscount @order[:nickname], 100

		@order[:discount] = @discount
		@order[:total] = @product["price"].to_f * @order[:quantity].to_i * @discount.to_f

		@order.save

		@order[:isdiscount] = params[:order][:discount]

		ret = OrderService.getsingleorder @order, @product, @discount
		if not ret["item"]["is_success"] == "True"
			Rails.logger.info ret.to_json
		end

		session[:orderid] = @order[:id]

		@order[:status] = 1
		respond_with @order
	end


	# PUT /orders/1
	def update
		@order = Order.find params[:id]

		if not refinery_user?
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

		if not refinery_user?
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
		if not simple_captcha_valid?
			respond_with ret = { :status => 2 }, :location => nil, :status => :forbidden and return
		end
	end

end
