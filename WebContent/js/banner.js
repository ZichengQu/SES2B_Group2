$(function(){
    var ban=0;
    var maxImg=$(".ban-block ul li").length;
    //banner动画效果
    var Funimg= function(){
        $(".ban-block ul li").eq(ban).addClass("cur").siblings().removeClass("cur");
        $(".banner ul li").eq(ban).stop(true,true).siblings().hide();
        $(".banner ul li").eq(ban).stop(true,true).stop(true,true).fadeIn();
    } 
    Funimg();
    $(".ban-block ul li").hover(function(){
        ban = $(this).index();
        Funimg();
    })
    //自动切换添加定时器
    var setInt=setInterval(function(){
        ban++;
        ban %=maxImg;
        Funimg();
    },3500);
    //当鼠标放到点上清除定时器
    $(".ban-block ul li,a.prev ,a.next").hover(function(){
        clearInterval(setInt);
        //清除后移开点后重新绑定定时器
    },function(){
        setInt=setInterval(function(){
        ban++;
        ban %=maxImg;
        Funimg();
       },3500);
    })

})