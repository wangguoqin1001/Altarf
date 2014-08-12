$(document).ajaxSend(function(e, xhr, options) {
        var sid = $("meta[name='csrf-token']").attr("content");
        xhr.setRequestHeader("X-CSRF-Token", sid);
});

$(document).ajaxStart(function() {
        $("#spinner").show();
}).ajaxStop(function() {
        $("#spinner").hide();
	jQuery.ready();
}).ajaxError(function() {
        $("#spinner").hide();
	jQuery.ready();
});
