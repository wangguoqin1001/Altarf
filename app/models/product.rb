class Product
	include HTTParty
	base_uri 'https://libra.qzzstore.scs.im'
	default_params :token => Altarf::Application.config.libra_api_token
	ssl_version :TLSv1


	def self.all
		get("/api/variants", { :verify => false })["variants"]
	end


	def self.find(sku)
		get("/api/variants", {
			:verify => false,
			:query => {
				:q => {
					:sku_eq => sku
				}
			}
		})["variants"][0]
	end


	def self.picture(uri)
		get("/spree/products/" + uri, { :verify => false})
	end
end
