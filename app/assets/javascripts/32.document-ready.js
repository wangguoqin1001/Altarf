function product2_ready() {
	$.ajax ({
			url: "/products.json",
			type: "GET",
			dataType: "json",
	}).done (function (resp)
	{
		for(var j=0;j<resp.length;j++)
		{
			if('0001' == resp[j].sku)
			{
				var product_url = resp[j].images[0] == null? "" :resp[j].images[0].urls.product;
				if ($('#product0001_pic').length)
				{
					$('#product0001_pic').prop ('src',product_url.replace('/spree/products/','/products/picture/'));
					$('#product1Price').html(resp[j].price+'元');
				}
				continue;
			}
			if('0002' == resp[j].sku)
			{
				var product_url = resp[j].images[0] == null? "" :resp[j].images[0].urls.product;
				if ($('#product0002_pic').length)
				{
					$('#product0002_pic').prop ('src',product_url.replace('/spree/products/','/products/picture/'));
					$('#product2Price').html(resp[j].price+'元');
				}
				continue;
			}
		}
	}).fail (function() {
		alert ("产品信息获取失败，请稍候再试");
	});

	$('.flexslider1').flexslider({
		animation: "fade",
		controlNav: false,
		animationLoop: true, 
		slideshowSpeed: 4000,
	});
	$('.flexslider2').flexslider({
		animation: "fade",
		controlNav: false,
		animationLoop: true,
		slideshowSpeed: 5003, 
	});
}
