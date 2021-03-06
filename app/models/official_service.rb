class OfficialService
	extend Savon::Model

	client wsdl: "http://210.13.83.247/ECLQzzWS/QZZOfficialService.asmx?WSDL",
#	client wsdl: "http://eclinkapi.800ts.com.cn/QZZOfficialService.asmx?WSDL",
		namespace: "http://tempuri.org/",
		convert_request_keys_to: :camelcase,
		soap_version: 2,
		logger: Rails.logger,
		log: true

	operations :add_member_info, :check_check_code, :create_dynamic_check_code,
		:del_member_info, :get_customer_list, :up_data_member_info, :test


	def self.addmemberinfo(membership)
		self.query_official_service :add_member_info, {
			"customerStr" => {
				"CustomerID" => membership[:nickname].to_s,
				"CustomerCode" => membership[:nickname].to_s,
				"MobilePhone" => membership[:mobile].to_s,
				"Sex" => membership[:gender].to_s,
				"CustomerName" => membership[:username].to_s,
				"TelPhone" => membership[:phone].to_s,
				"Email" => membership[:email].to_s,
				"PostAddress" => membership[:province].to_s + membership[:city].to_s + membership[:district].to_s + membership[:addr].to_s
			}.to_json
		}
	end


	def self.checkcheckcode(mobile, checkcode)
		self.query_official_service :check_check_code, {
			"mobilephone" => mobile.to_s,
			"checkcode" => checkcode.to_s
		}
	end


	def self.createdynamiccheckcode(mobile)
		self.query_official_service :create_dynamic_check_code, {
			"mobilephone" => mobile.to_s
		}
	end


	def self.delmemberinfo(customer)
		self.query_official_service :del_member_info, {
			:customer_code => customer.to_s
		}
	end


	def self.getcustomerlist(customers)
		self.query_official_service :get_customer_list, {
			"customersStr" => customers.to_s
		}
	end


	def self.updatememberinfo(membership)
		self.query_official_service :up_data_member_info, {
			"customerStr" => {
				"CustomerID" => membership[:nickname].to_s,
				"CustomerCode" => membership[:nickname].to_s,
				"MobilePhone" => membership[:mobile].to_s,
				"Sex" => membership[:gender].to_s,
				"CustomerName" => membership[:username].to_s,
				"TelPhone" => membership[:phone].to_s,
				"Email" => membership[:email].to_s,
				"PostAddress" => membership[:province].to_s + membership[:city].to_s + membership[:district].to_s + membership[:addr].to_s
			}.to_json
		}
	end


	def self.test
		self.query_official_service(:test, {})
	end


	private

	def self.query_official_service(remote_method, remote_data)
		method_response = (remote_method.to_s + "_response").to_sym
		method_result = (remote_method.to_s + "_result").to_sym

		ret = send remote_method, message: remote_data
		Hash.from_xml ret.body[method_response][method_result]
	end

end
