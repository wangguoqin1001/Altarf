var contentSelector = '#page';

$(document).ready (function() {
	if (window.history && history.pushState) {

		$('#menu a').on ('click', function(event) {
			var url = $(this).attr('href');

			History.pushState (null, null, url);
			event.preventDefault();
			return false;
		});

		$(window).bind ('statechange', function() {
			var url = History.getState().url;
			$(contentSelector).animate ({opacity: 0.3});

			$.ajax({
				url: url,
				timeout: 3000
			}).done (function (resp) {

				var $html = $(String(resp));
				var new_content =  $html.find (contentSelector).html();

				$(contentSelector).html (new_content);
				$(contentSelector).animate ({opacity: 1, visibility: "visible"});

				document.title = $html.filter ('title').text();

				$('body').animate ({scrollTop: $('#menu').offset().top}, 1000);

			}).fail (function() {
				document.location.href = url;
				return false;
			});

			return false;
		});
	}
});
