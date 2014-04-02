class Product
	include HTTParty
	base_uri 'libra.qzzstore.com'

	Token = { :token => Altarf::Application.config.libra_api_token }


	def self.all
		get("/api/variants", { :query => Token })["variants"]
	end


	def self.find(sku)
		get("/api/variants", {
			:query => {
				:q => {
					:sku_eq => sku
				}
			}.merge(Token)
		})["variants"][0]
	end
end
