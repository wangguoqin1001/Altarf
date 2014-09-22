var contentSelector = '#page';
var rootUrl = History.getRootUrl();

$(document).ready (function() {
	if (window.history && history.pushState) {

		$.expr[':'].internal = function(obj, index, meta, stack){
			var url = $(obj).attr ('href') || '';
			return url.substring (0, rootUrl.length) === rootUrl || url.indexOf (':') === -1;
		};

		$('body').delegate ('a:internal', 'click', function(event) {
			var url = $(this).attr('href');

			History.pushState (null, null, url);
			event.preventDefault();
			return false;
		});

		$(window).bind ('statechange', function() {
			var url = History.getState().url;
			$(contentSelector).animate ({opacity: 0.3});
			$('#class_load').each (function() {
				$('body').removeClass ($(this).val());
			});

			$(contentSelector).load (url + ' ' + contentSelector, function (resp, status, xhr) {
				if (status == "error") {
					document.location.href = url;
					$(contentSelector).animate ({opacity: 1, visibility: "visible"});
				} else {
					var $resp = $(resp);
					document.title = $resp.filter ('title').text();
					$(contentSelector).animate ({opacity: 1, visibility: "visible"});
					$('#partial_load').each (function() {
						History.pushState (null, null, $(this).val());
					});
					if ($('#partial_load').length) {
						return false;
					}
					$('.func_document_ready').each (function() {
						window[$(this).val()]();
					});
					$('#class_load').each (function() {
						$('body').addClass ($(this).val());
					});
				}

			});

			return false;
		});
	}
});
