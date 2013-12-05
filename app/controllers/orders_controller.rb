class OrdersController < ApplicationController

	respond_to :json, :xml, :html

	before_filter :checkcaptcha, :only => [:create]


	# GET /orders
	def index
		@orders = Order.find :all, :conditions => { :nickname => session[:nickname] }
		respond_with @orders
	end


	# GET /orders/1
	def show
		@order = Order.find params[:id]
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
		respond_with @order
	end


	# POST /orders
	def create
		@order = Order.new params[:order]
		@order.save
		respond_with @order
	end


	# PUT /orders/1
	def update
		@order = Order.find params[:id]
		@order.update_attributes params[:order]
		respond_with @order
	end


	# DELETE /orders/1
	def destroy
		@order = Order.find params[:id]
		@order.destroy
		respond_with @order
	end
end
