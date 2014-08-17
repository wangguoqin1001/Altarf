$(function() {
	$("body").delegate ("#wechat", "mouseover", function(){
		$("#wechatimg").show();			
	});
	$("body").delegate ("#wechat", "mouseout", function(){		
		$("#wechatimg").hide();			
	});

	$("body").delegate (".img-blank-pro1-inside-1", "mouseover", function(){		
		$(".pop").fadeToggle('fast');
	});
	$("body").delegate (".pop", "mouseout", function(){
		$(".pop").hide();
	});

	$("body").delegate (".img-blank-pro1-inside-3", "mouseover", function(){		
		$(".pop2").fadeToggle('fast');
	});
	$("body").delegate (".pop2", "mouseout", function(){
		$(".pop2").hide();
	});

	$("body").delegate (".history_txt02", "click", function(){
		History.pushState (null, null, "/气之购/订单详情"+$(this).html().replace('订单：','?orderId='));
	});
	$("body").delegate (".history_txt04", "click", function(){
		History.pushState (null, null, "/气之购/订单详情"+$(this).parent().find('.history_txt02').html().replace('订单：','?orderId='));
	});

	$("body").delegate (".saveinformation", "click", function(){
		var sku = $(this).parent().find ('#productid').val();
		History.pushState (null, null, "/气之购/预订单?sku="+sku);
	});

})
