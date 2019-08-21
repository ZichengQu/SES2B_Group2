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

$(function(){
	//法律法规 动态   切换
	$('.inves_ProtFocus ul li').bind("click",function(){
		$(this).addClass('cur').siblings().removeClass('cur');
		$('.inves_ProtContentBlick>div:eq('+$(this).index()+')').show().siblings().hide();	
	})

	//tab  切换
	$('.inves_Tab ul li').bind("click",function(){
		$(this).addClass('cur').siblings().removeClass('cur');
		$('.inves_TabContentBox>div:eq('+$(this).index()+')').show().siblings().hide();	
	})

	
	//new招商信息  切换
	$('.inves_ProtFocus ul li').bind("click",function(){
		$(this).addClass('cur').siblings().removeClass('cur');
		$('.business_ConBox>div:eq('+$(this).index()+')').show().siblings().hide();	
	});
	//new 招商动态 切换
	$('.busine_ProtFocus ul li').bind("click",function(){
		$(this).addClass('cur').siblings().removeClass('cur');
		$('.busine_SpotContent>div:eq('+$(this).index()+')').show().siblings().hide();	
	});

	//show.html  tab  切换
	$('.wth').bind("click",function(){
		$(this).addClass('cur1').siblings().removeClass('cur2');
		$(".show_model1").css({display: 'block'});
		$(".show_model2").css({display: 'none'});
		//$('.show_ConBox>div:eq('+$(this).index()+')').show().siblings().hide();	
	})
	$('.wth1').bind("click",function(){
		$(this).addClass('cur2').siblings().removeClass('cur1');
		//$('.show_ConBox>div:eq('+$(this).index()+')').show().siblings().hide();	
		$(".show_model1").css({display: 'none'});
		$(".show_model2").css({display: 'block'});
	})

	//更多点击
	var liHeight=$('.inves_Spot ul,.inves_SystemList ul,.inves_SystemList2 ul').height();
	var count=$('.inves_Spot ul,.inves_SystemList ulm,.inves_SystemList2 ul').length;
	var dheight=liHeight - 50;
	var allheight=liHeight*count/3;
	var n=1;
	$(".readMoreBtn,.readMoreBtn2").bind('click', function() {
		n++;
		h=dheight*n;
		if(h<allheight){
			$('.readMoreBtn,.readMoreBtn2').hide(300);
		}
		$('.inves_Spot ul,.inves_SystemList ul,.inves_SystemList2 ul').height(h);	
	});

	
	
	//更多点击
	var liHeight=$('#inves_SystemList2 ul').height();
	var count=$('#inves_SystemList2 ul').length;
	var dheight=liHeight - 50;
	var allheight=liHeight*count/3;
	var n=1;
	$("#readMoreBtn2").bind('click', function() {
		n++;
		h=dheight*n;
		if(h<allheight){
			$('#readMoreBtn2').hide(300);
		}
		$('#inves_SystemList2 ul').height(h);	
	});
	
	$("#readMoreBtn3").bind('click', function() {
		n++;
		h=dheight*n;
		if(h<allheight){
			$('#readMoreBtn3').hide(300);
		}
		$('#inves_SystemList3 ul').height(h);	
	});

	//点击事件的触发  selcet 列表下拉展开
	$(".wselect").click(function(){
		//找到当前类的父类元素，再寻找他的孩子节点
		$(this).parents(".select_border,.select_border2,.select_border3").children(".selcet").hide().stop(true,true).slideDown(200);   
		// 动画执行时需要 stop()  函数 ，停止当前正在运行的动画 ， 否则出现bug
	});

	// 获取列表的参数值，返回给 wselect
  	$(".select_border a,.select_border2 a,.select_border3 a").bind("click",function(){
  		$(".selcet").hide().stop(true,true).slideUp(200);
   	 	var thisText = $(this).text();
    		$(this).parents(".selcet").siblings(".wselect").text(thisText); //  找到当前 父类元素 的 selcet
    	//将当前的select   的值传给wselect
    });

	//鼠标离开后 selcet 列表下拉收缩
	$(".select_border,.select_border2,.select_border3").bind("mouseleave",function(){
    		$(".selcet").hide().stop(true,true).slideUp(200);
    });

	 //弹出框
   $(".busine_oneselfTable,.jobApplyBtn").bind('click',function(){ 
       $("#pop-up").fadeIn();
       $(".pop-main").removeClass("outAni").addClass("inAni");
   })
   //关闭弹出框
   $("#close_pop").bind('click',function(){
       $(".pop-main").removeClass("inAni").addClass("outAni");
       $("#pop-up").fadeOut();
       $(".sercess").css({"display":"none"})
   });




   //职位申请 弹出框
   $(".jobApplyBtn").bind('click',function(){ 
       $("#pop-up").fadeIn();
       $(".pop-main").removeClass("outAni").addClass("inAni");
   })
   //关闭弹出框
   $("#close_pop,.colseBtn").bind('click',function(){
       $(".pop-main").removeClass("inAni").addClass("outAni");
       $("#pop-up").fadeOut();
       $(".sercess").css({"display":"none"})
   });

   $(".nextBtn").bind('click',function(){ 
       $(".applyContent1").fadeOut();
       $(".applyContent2").fadeIn();
       $(".pop-main").removeClass("outAni").addClass("inAni");
   })

   $(".nextBtn2").bind('click',function(){ 
       $(".applyContent2").fadeOut();
       $(".applyContent3").fadeIn();
       $(".applyContent3").css("display","block");
       $(".pop-main").removeClass("outAni").addClass("inAni");
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
})

function popEmpty(){
	$("#popCarrier").val("");
	$("#popLegal").val("");
	$("#popAddress").val("");
	$("#popEstablishTime").val("");
	$("#popMoney").val("");
	$("#popContactName").val("");
	$("#popJob").val("");
	$("#popPhone").val("");
	$("#popEmail").val("");
	$("#popBuz").val("");
	$("#popAchievement").val("");
	$("#basePath").val("");
}

function saveInvestMentCover(){
	var menuId = $("#coverMenuId").val();
	var carrier = $("#popCarrier").val();
	var legal = $("#popLegal").val();
	var address = $("#popAddress").val();
	var establishTime = $("#popEstablishTime").val();
	var money = $("#popMoney").val();
	var contactName = $("#popContactName").val();
	var job = $("#popJob").val();
	var phone = $("#popPhone").val();
	var email = $("#popEmail").val();
	var buz = $("#popBuz").val();
	var achievement = $("#popAchievement").val();
	var basePath = $("#basePath").val();
	$.ajax({			 
        url: basePath + "/web/investment/investmentcover/save",
        type: 'post',
        dataType: 'json',
        data : {
        	menuId : menuId,
        	carrier : carrier,
			legal : legal,
			address : address,
			establishTime : establishTime,
			money : money,
			contactName : contactName,
			job : job,
			phone : phone,
			email : email ,
			buz : buz,
			achievement : achievement
        },
        cache: false,
        success: function(data){
        	if(data!=null&&data!=false){
        		alert("操作成功");
        		 $("#pop-up").fadeOut();
        		 popEmpty();
        	}else{
        		alert("操作失败");
        	}
        }
    });
}
$(function(){
	/*$(".header_onList").eq(1).css({"right":"-39px"});
	$(".header_onList").eq(2).css({"right":"60px"});
	$(".header_onList").eq(3).css({"right":"56px"});
	$(".header_onList").eq(4).css({"right":"154px"});
	$(".header_onList").eq(5).css({"right":"56px"});*/

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