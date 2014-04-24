class OrderService
	extend Savon::Model

#	client wsdl: "http://210.13.83.247/ECLQzzWSTest/QZZOrderService.asmx?WSDL",
	client wsdl: "http://eclinkapi.800ts.com.cn/QZZOrderService.asmx?WSDL",
		namespace: "http://tempuri.org/",
		convert_request_keys_to: :camelcase,
		soap_version: 2,
		logger: Rails.logger,
		log: true

	operations :get_order_list, :get_singe_order, :updata_order


	Payments = { 1 => "CASH_ON_DELIVERY", 2 => "ALIPAY", 3 => "UNIONPAY" }


	def self.getorderlist(orders)
		self.query_order_service :get_order_list, {
			"ordersStr" => orders.to_s
		}
	end


	def self.getsingleorder(order, product, discount)
		self.query_order_service :get_singe_order, {
			"orderStr" => {
				"OrderID" => order[:id].to_s,
				"PayType" => Payments[order[:payment].to_i],
				"Ship" => 0,
				"CustomerCode" => order[:nickname].to_s,
				"Receiver" => order[:username].to_s,
				"MobilePhone" => order[:mobile].to_s,
				"TelPhone" => order[:phone].to_s,
				"Province" => order[:province].to_s,
				"City" => order[:city].to_s,
				"District" => order[:district].to_s,
				"PostCode" => order[:postal].to_s,
				"AddressDetail" => order[:addr].to_s,
				"IsAskInvoice" => !order[:need_invoice].to_i.zero?,
				"IsDiscount" => !order[:isdiscount].to_i.zero?,
				"InvoiceHeader" => order[:invoice_title].to_s,
				"InvoiceAddress" => order[:billing].to_s,
				"OrderStatus" => "ORDER_STATUS_PAY_WAIT",
				"PLU" => order[:productid].to_s,
				"ProductName" => product["name"],
				"ProductPrice" => product["price"],
				"ProductNumbers" => order[:quantity].to_s,
				"Discount" => "0", #order[:coupon].to_s,
				"Subtotal" => product["price"].to_f * order[:quantity].to_i,
				"Total" => product["price"].to_f * order[:quantity].to_i * discount.to_f
#				"OrderFrom" => nil,
#				"OrderWay" => nil,
#				"TransCompany" => nil,
#				"SendTime" => nil,
#				"BuyerRemark" => nil,
#				"SellerRemark" => nil,
#				"CustomerLevel" => nil,
#				"InvoiceType" => nil,
			}.to_json
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
