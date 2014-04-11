$(window).resize (function(){
	w = $(window).width();
	h = $(window).height();
});

$(document).ready(function(){
	$('#logo').hide().fadeIn(5000);
});

var requestAnimFrame = function(){
	return (
		window.requestAnimationFrame       || 
		window.webkitRequestAnimationFrame || 
		window.mozRequestAnimationFrame    || 
		window.oRequestAnimationFrame      || 
		window.msRequestAnimationFrame     || 
		function(callback){
			window.setTimeout(callback, 1000 / 60);
		});
}();

$(document).ready (function(){
	w = $(window).width();
	h = $(window).height();

	var starttime = new Date()/1000

//below codes for logo animation	
	var logo_w = 69;
	var logo_h = 186;
	$('#logo').css("width", logo_w+"px");
	$('#logo').css("height", logo_h+"px");
	$('#logo').css("top", (h-logo_h)/2+"px");
	$('#logo').css("left", (w-logo_w)/2+"px");
	var logo_context = $('#logo').get(0).getContext('2d');
	var img = new Image();
	var logo_opcity = 0;
	img.src = '/assets/qzz-logo-main.png';

	var newgradient = function(){
		var second = (new Date()/1000 - starttime)%5;
		if( logo_opcity >= 1 ){
			logo_opcity = 1;
		}else{
			logo_opcity += 0.01;
		}
		logo_context.clearRect(0,0,300,150);
		logo_context.globalAlpha = logo_opcity;
		logo_context.drawImage(img,0,0,300,150);
		if (second < 1) {
			var s1 = -0.2 + 0.4 * second;
			var s2 = s1 + 0.1;
			var s3 = s1 + 0.2;
			if (s1 < 0) s1 = 0;
			if (s2 < 0) s2 = 0;

			var gradient = logo_context.createLinearGradient(0,0,300,900);
			gradient.addColorStop(s1, 'rgba(255,255,255,0)');
			gradient.addColorStop(s2, 'rgba(255,255,255,1)');
			gradient.addColorStop(s3, 'rgba(255,255,255,0)');
			logo_context.fillStyle = gradient;
		} else {
			logo_context.fillStyle = 'rgba(255,255,255,0)';
		}
		logo_context.fillRect(0,0,300,150);

		requestAnimFrame(newgradient);
	}

	img.onload = function(){
		setTimeout(function(){newgradient()}, 3000);
	};
});
