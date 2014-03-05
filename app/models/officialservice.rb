class OfficialService
	extend Savon::Model

	client wsdl: "http://210.13.83.247/ECLQzzWSTest/QZZOfficialService.asmx?WSDL",
		namespace: "http://tempuri.org/",
		convert_request_keys_to: :camelcase,
		soap_version: 2,
		logger: Rails.logger

	operations :add_member_info, :check_check_code, :create_dynamic_check_code,
		:del_member_info, :get_customer_list, :up_data_member_info, :test


	def self.addmemberinfo(customer)
		self.query_official_service(:add_member_info, {
			"customerStr" => customer.to_s
		})
	end


	def self.checkcheckcode(mobile, checkcode)
		self.query_official_service(:check_check_code, {
			"mobilephone" => mobile.to_s,
			"checkcode" => checkcode.to_s
		})
	end


	def self.checkdynamiccheckcode(mobile)
		self.query_official_service(:check_dynamic_check_code, {
			"mobilephone" => mobile.to_s
		})
	end


	def self.delmemberinfo(customer)
		self.query_official_service(:del_member_info, {
			:customer_code => customer.to_s
		})
	end


	def self.getcustomerlist(customers)
		self.query_official_service(:get_customer_list, {
			"customersStr" => customers.to_s
		})
	end


	def self.updatememberinfo(customer)
		self.query_official_service(:up_data_member_info, {
			"customerStr" => customer.to_s
		})
	end


	def self.test
		self.query_official_service(:test, {})
	end


	private

	def self.query_official_service(remote_method, remote_data)
		method_response = (remote_method.to_s + "_response").to_sym
		method_result = (remote_method.to_s + "_result").to_sym

		ret = send remote_method, message: remote_data
		ret.body[method_response][method_result]
	end

end
