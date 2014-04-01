// JavaScript Document
function sendmobile() {
	if ($('#mobile').val().length != 11) {
		alert ("请输入您的手机号码");
		return;
	}
	$.ajax ({
		url:		"/membership/verifymobile.json",
		xhrFields: { withCredentials: true },
		type:		"POST",
		dataType:	"json",
		data:		{ mobile: $('#mobile').val() }
	}).done (function (resp) {
		if (parseInt (resp.status) == 1) {
			if (resp.return_value != null)
				$('#telidentification').val (resp.return_value);
			else
				alert ("验证码已发到您的手机，请注意查收");
		} else {
			if (resp.description != null)
				alert (resp.description);
			else
				alert ("请求失败，请再检查一遍您的输入并稍候再试");
		}
	}).fail (function() {
		alert ("请求发送失败，请稍候再试");
	});
}
function login() {
	if ($('#account').val().length == 0) {
		alert ("请输入您的用户名");
		return;
	}else if ($('#password').val().length == 0) {
		alert ("请输入您的密码");
		return;
	}else if ($('#captcha').val().length == 0) {
		alert ("请输入您的验证码");
		return;
	} 
	$.ajax ({
		url:		"/memberships/login.json",
		type:		"POST",
		dataType:	"json",
		data:		{
			nickname:		$('#account').val(),
			password:		$.sha256 (
								$.sha256 ($('#account').val() + $('#password').val())
								+ $('#captcha').val()),
			captcha:		$('#captcha').val(),
			captcha_key:	$('#captcha_key').val()
		}
	}).done (function (resp) {
		if (parseInt (resp.status) == 1)
			//location.reload();
			location.href = "/气之购/在线订购";
		else if (parseInt (resp.status) == 2) {
			$(".authenticationtd").load ('/%E6%B0%94%E4%B9%8B%E5%AE%B6/%E6%88%91%E7%9A%84%E5%B8%90%E6%88%B7 .simple_captcha');
			$('#loginerr').html ("验证码错误");
		} else {
			$(".authenticationtd").load ('/%E6%B0%94%E4%B9%8B%E5%AE%B6/%E6%88%91%E7%9A%84%E5%B8%90%E6%88%B7 .simple_captcha');
			$('#loginerr').html ("登录信息错误");
		}
	}).fail (function() {
		$('#loginerr').html ("请求发送失败，请稍候再试");
	});
}

function register() {
	 if ($('#username').val().length <6 || $('#username').val().length >12) {
		alert ("请输入6-12位的用户名");
		return;
	 }else if ($('#password').val().length <6 || $('#password').val().length >12) {
		alert ("请输入6-12位的密码");
		return;
	 } else if ($('#identification').val().length == 0) {
		alert ("请再次输入您的密码");
		return;
	 } else if ($('#identification').val() != $('#password').val()) {
		alert ("两次输入的密码不同");
		return;
	 } else if ($('#name').val().length == 0){
	 	alert ("请输入您的姓名");
		return;
	 } else if ($('#mobile').val().length == 0){
	 	alert ("请输入您的手机号码");
		return;
	 }else if ($('#mobile').val().length != 11){
	 	alert ("请输入您的手机号码");
		return;
	 }else if ($('#telephone03').val().length == 0){
	 	alert ("请输入您的电话号码");
		return;
	 } else if ($('#email').val().length == 0){
	 	alert ("请输入您的邮箱");
		return;
	 } else if ($('#province').val().length == 0){
	 	alert ("请输入收件人的省");
		return;
	 } else if ($('#city').val().length == 0){
	 	alert ("请输入收件人的市");
		return;
	 } else if ($('#district').val().length == 0){
	 	alert ("请输入收件人的县/区");
		return;
	 } else if ($('#postalcode').val().length == 0){
	 	alert ("请输入收件人的邮编");
		return;
	 } else if ($('#address').val().length == 0){
	 	alert ("请输入收件人的具体地址");
		return;
	 } else if ($('#captcha').val().length == 0){
	 	alert ("请输入您的验证码");
		return;
	 } 
	 
	var membership = { 
		"addr" : $('#address').val(),
		"city" : $('#city').val(),
		"district" : $('#district').val(),
		"email" : $('#email').val(),
		"gender" : $('#sex option:selected').val(),
		"mobile" : $('#mobile').val(),
		"nickname" : $('#username').val(),
		"password" : $.sha256 ($('#username').val() + $('#password').val()),
		"phone" : $('#telephone01').val() + '-' + $('#telephone02').val() + '-' + $('#telephone03').val(),
		"postal" : $('#postalcode').val(),
		"province" : $('#province').val(),
		"username" : $('#name').val()
	}
	
	$.ajax ({
		url:		"/memberships.json",
		type:		"POST",
		dataType:	"json",
		data:		{
			membership : membership,
			captcha:		$('#captcha').val(),
			captcha_key:	$('#captcha_key').val()
		}
	}).done (function (resp) {
		if (parseInt (resp.status) == 1)
			location.href = "/气之家/注册成功";
		else {
			if (resp.description != null)
				alert (resp.description);
			else
				alert ("请求失败，请再检查一遍您的输入并稍候再试");
		}
	}).fail (function() {
		alert ("请求发送失败，请稍候再试");
	});
}

function loadUserData(){
	$.ajax ({
			url: "/memberships/1.json",
			type: "GET",
			dataType: "json",
		}).done (function (resp) {
			$('#address').val(resp.addr);
			$('#city').val(resp.city);
			$('#district').val(resp.district);
			$('#mobile').val(resp.mobile);
			$('#member_id').val(resp.id);
			var telephone = resp.phone.split("-");
			$('#telephone01').val(telephone[0]);
			$('#telephone02').val(telephone[1]);
			$('#telephone03').val(telephone[2]);
			$('#postalcode').val(resp.postal);
			$('#province').val(resp.province);
			$('#consignee_name').val(resp.username);
		});
}

function order() {
	 if ($('#product_name').val().length == 0) {
		alert ("请输入商品名称");
		return;
	 }else if ($('#num').val().length == 0) {
		alert ("请输入您的订购数量");
		return;
	 } else if ($('#price').val().length == 0) {
		alert ("请输入单价");
		return;
	 } else if ($('#coupon').val().length == 0) {
		alert ("请输入优惠折扣");
		return;
	 } else if ($('#member_id').val().length == 0) {
		alert ("请输入您的会员编号");
		return;
	 } else if ($('#consignee_name').val().length == 0) {
		alert ("请输入收件人姓名");
		return;
	 } else if ($('#mobile').val().length == 0) {
		alert ("请输入收件人手机号码");
		return;
	 } else if ($('#telephone03').val().length == 0) {
		alert ("请输入收件人固话号码");
		return;
	 } else if ($('#province').val().length == 0){
	 	alert ("请输入收件人的省");
		return;
	 } else if ($('#city').val().length == 0){
	 	alert ("请输入收件人的市");
		return;
	 } else if ($('#district').val().length == 0){
	 	alert ("请输入收件人的县/区");
		return;
	 } else if ($('#postalcode').val().length == 0){
	 	alert ("请输入收件人的邮编");
		return;
	 } else if ($('#address').val().length == 0){
	 	alert ("请输入收件人的具体地址");
		return;
	 } else if ($('#invoice').val().length == 0){
	 	alert ("请输入是否需要发票");
		return;
	 } else if ($('#invoice_head').val().length == 0){
	 	alert ("请输入发票抬头");
		return;
	 } else if ($('#invoice_address').val().length == 0){
	 	alert ("请输入发票地址");
		return;
	 } else if ($('#captcha').val().length == 0) {
		alert ("请输入您的验证码");
		return;
	}
	
	var order = { 
		"addr" : $('#address').val(),
		"billing" : $('#invoice_address').val(),
		"city" : $('#city').val(),
		"coupon" : $('#coupon').val(),
		"district" : $('#district').val(),
		"invoice_title" : $('#invoice_head').val(),
		"mobile" : $('#mobile').val(),
		"need_invoice" : $('#invoice').val(),
		"payment" : $('#payment option:selected').val(),
		"phone" : $('#telephone01').val() + '-' + $('#telephone02').val() + '-' + $('#telephone03').val(),
		"postal" : $('#postalcode').val(),
		"productid" : $('#product_name').val(),
		"province" : $('#province').val(),
		"quantity" : $('#num').val(),
		"username" : $('#consignee_name').val()
	}
	
	$.ajax ({
		url:		"/orders.json",
		type:		"POST",
		dataType:	"json",
		data:		{
			order : order,
			captcha:		$('#captcha').val(),
			captcha_key:	$('#captcha_key').val()
		}
	}).done (function (resp) {
		if (parseInt (resp.status) == 1)
			location.href = "/气之购/订单生成";
		else {
			if (resp.description != null)
				alert (resp.description);
			else
				alert ("请求失败，请再检查一遍您的输入并稍候再试");
		}
	}).fail (function() {
		alert ("请求发送失败，请稍候再试");
	});
}

function gotobuy(){
	location.href = "/气之购/预订单"
}
