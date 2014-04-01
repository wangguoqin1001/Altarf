class OrderService
	extend Savon::Model

	client wsdl: "http://210.13.83.247/ECLQzzWSTest/QZZOrderService.asmx?WSDL",
		namespace: "http://tempuri.org/",
		convert_request_keys_to: :camelcase,
		soap_version: 2,
		logger: Rails.logger

	operations :get_order_list, :get_singe_order, :updata_order


	def self.getorderlist(orders)
		self.query_order_service :get_order_list, {
			"ordersStr" => orders.to_s
		}
	end


	def self.getsingleorder(order)
		self.query_order_service :get_singe_order, {
			"orderStr" => {
				:order_i_d => order[:id].to_s,
				:pay_type => order[:payment].to_s,
				:customer_code => order[:nickname].to_s,
				:receiver => order[:username].to_s,
				:mobile_phone => order[:mobile].to_s,
				:tel_phone => order[:phone].to_s,
				:province => order[:province].to_s,
				:city => order[:city].to_s,
				:district => order[:district].to_s,
				:post_code => order[:postal].to_s,
				:address_detail => order[:addr].to_s,
				:is_ask_invoice => order[:need_invoice].to_s,
				:invoice_header => order[:invoice_title].to_s,
				:invoice_address => order[:billing].to_s,
				:p_l_u => "03010005",#order[:productid].to_s,
				:product_name => "product",
				:product_price => 500,
				:product_numbers => order[:quantity].to_s,
				:discount => order[:coupon].to_s,
				:subtotal => 500,
				:total => 500
			}.to_xml(skip_instruct: true, skip_types: true, camelize: true, root: "order")
		}
	end


	def self.updateorder(order)
		self.query_order_service :updata_order, {
			"orderStr" => order.to_s
		}
	end


	private

	def self.query_order_service(remote_method, remote_data)
		method_response = (remote_method.to_s + "_response").to_sym
		method_result = (remote_method.to_s + "_result").to_sym

		ret = send remote_method, message: remote_data
		Hash.from_xml ret.body[method_response][method_result]
	end

end
