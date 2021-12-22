$(document).ready(function(){
	$(".userdata").click(function(index){
		
		$("#userid").val($(this).children().eq(0).html());
		$("#username").val($(this).children().eq(1).html());
	});
	
	//button1 create
	$("input[name=button1]").click(function(){
		$("input[type=hidden]").val("create");
		$("form:first").submit();
	});
	
	//button2 modify
	$("input[name=button2]").click(function(){
		$("input[type=hidden]").val("modify");
		$("form:first").submit();
	});
});