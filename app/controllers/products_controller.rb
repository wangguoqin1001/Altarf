require 'uri'

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


	# GET /products/picture
	def picture
		@picture = Product.picture URI.escape(params.delete(:uri) + "?#{params.except(:action, :controller).to_query}")
		send_data @picture, :type => 'image/png', :filename => 'picture.png', :disposition => 'inline'
	end
end
