class ProductsController < ApplicationController

	respond_to :json, :xml, :html


	# GET /products
	def index
		@products = Product.all
		respond_with @products
	end


	# GET /products/1
	def show
		@product = Product.find params[:id]
		respond_with @product
	end
end
