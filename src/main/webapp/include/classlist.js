$(document).ready(function(){
	$(".classdata").click(function(index){
		
		$("#id").val($(this).children().eq(0).html());
		$("#deptname").val($(this).children().eq(1).html());
		$("#majorname").val($(this).children().eq(2).html());
		$("#classname").val($(this).children().eq(3).html());
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