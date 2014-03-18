class OrderService
	extend Savon::Model

	client wsdl: "http://210.13.83.247/ECLQzzWSTest/QZZOrderService.asmx?WSDL",
		namespace: "http://tempuri.org/",
		convert_request_keys_to: :camelcase,
		soap_version: 2,
		logger: Rails.logger

	operations :get_order_list, :get_singe_order, :updata_order


	def self.getorderlist(orders)
		self.query_order_service(:get_order_list, {
			"ordersStr" => orders.to_s
		})
	end


	def self.getsingleorder(order)
		self.query_order_service(:get_singe_order, {
			"orderStr" => order.to_s,
		})
	end


	def self.updateorder(order)
		self.query_order_service(:updata_order, {
			"orderStr" => order.to_s
		})
	end


	private

	def self.query_order_service(remote_method, remote_data)
		method_response = (remote_method.to_s + "_response").to_sym
		method_result = (remote_method.to_s + "_result").to_sym

		ret = send remote_method, message: remote_data
		ret.body[method_response][method_result]
	end

end
