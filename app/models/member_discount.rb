class MemberDiscount
	extend Savon::Model

	client wsdl: "http://210.13.83.247/ECLQzzWSTest/MemberDiscountService.asmx?WSDL",
		namespace: "http://tempuri.org/",
		convert_request_keys_to: :camelcase,
		soap_version: 2,
		logger: Rails.logger

	operations :hello_world, :member_discount, :membr_level


	def self.helloworld
		self.query_member_discount(:hello_world, {})
	end


	def self.memberdiscount(usercode)
		self.query_member_discount(:member_discount, {
			"userCode" => usercode.to_s
		})
	end


	def self.memberlevel(usercode)
		self.query_member_discount(:membr_level, {
			"userCode" => usercode.to_s
		})
	end


	private

	def self.query_member_discount(remote_method, remote_data)
		method_response = (remote_method.to_s + "_response").to_sym
		method_result = (remote_method.to_s + "_result").to_sym

		ret = send remote_method, message: remote_data
		Hash.from_xml ret.body[method_response][method_result]
	end

end
