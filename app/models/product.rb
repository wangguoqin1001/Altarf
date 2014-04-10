class Product
	include HTTParty
	base_uri 'https://libra.qzzstore.com'
	default_params :token => Altarf::Application.config.libra_api_token


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
end
