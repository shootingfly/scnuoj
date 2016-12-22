var hideNotice = function(){
	$(".notice").fadeOut("slow");
}
setTimeout(hideNotice, 2000);
var file = function() {
	$(":file").filestyle({
		input: false
	});
}