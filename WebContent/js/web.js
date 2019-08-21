//请求连接参数分割
$UrlParameter = function(_key) {
	//debugger
	var _url = window.location.search;
	//如果不等于空表示存在参数
	if (_url.length != 0) {
		//清除问号字符
		_params = _url.replace('?', "").split('&');
		for (var i = 0; _p = _params[i]; i++) {
			_params[_p.split('=')[0]] = _p.split('=')[1];
		}
		//是否返回固定参数值
		if (_key && _key.length != 0) {
			return _params[_key];
		}
		//否则返回对象集合
		return _params;
	}
};

jQuery(document).ready(function() {
	var imgs  = $(".fr-fin");
	for(var i=0;i<imgs.length;i++){
		var img = imgs[i];
		var p = $(img).parent();
		var textAlign = p.css("text-align");
//		p.css("text-align","center");
	}
})


function webSize(){
	var winW = $(window).width();
	var winH = $(window).height();
	var head = $(".Header").height();
	var foot = $(".Footer").height();
	var middle = $("#middle").height();
    var sum = winH - head - foot;
	$(".i-center").css({width:winW,height:sum})
}

$(function(){
	webSize();
	$(window).resize(function(){
		webSize();
	})
})

$(function(){
$(".nav_liBlock").bind("click",function(){
	$(this).addClass("current").siblings().removeClass("current");
})
})

$(function(){
	/*$(".header_onList").eq(1).css({"right":"-60px"});
	$(".header_onList").eq(2).css({"right":"-150px"});
	$(".header_onList").eq(3).css({"right":"-240px"});
	$(".header_onList").eq(4).css({"right":"-320px"});*/

	var tOn=0;
	function showBlock(){
		$(".header_onBlockBg").eq(tOn).stop(true,true).fadeIn().siblings().hide();

	}
	showBlock();
	$(".header_ulBlock a").bind("mouseover",function(){
		tOn = $(this).index();
		showBlock();
	})
	$(".header_onBlockBg").bind("mouseover",function(){
		$(this).show();
	})
	$(".header_onBlockBg").bind("mouseout",function(){
		$(this).hide();
	})
})