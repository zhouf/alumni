$(document).ready(function(){
		
	//button submit clicked
	$("input[name=submit]").click(function(){
		
		var username = $("#username").val();
		if(username.length<=0){
			alert("请填写捐赠人信息");
			return false;
		}
		
		var amount = $("#amount").val();
		if(amount.length<=0){
			alert("请填写捐赠金额");
			return false;
		}else{
			for(var i=0;i<amount.length;i++){
				if("1234567890".indexOf(amount.charAt(i))<0){
					alert("请输入正确的数据");
					return false;
				}
			}
		}
		$("form:first").submit();
	});
});