//1.Set scroll view
window.onunload = function() {
	return confirm("Are you sure you want to leave this page?");
};
$('.box').on('scroll', function(e) {
	console.log(e,'局部滚动'); 
});
setTimeout(gf, 2000);
aaa($('.box'),$('.hh'),6,-100);
/**
* 动态改变dom位置
* @param  {[type]} parentDom [滚动区域父元素]
* @param  {[type]} listDom   [滚动的列表]
* @param  {[type]} index     [滚动到的指定元素]
* @param  {[type]} offset    [便宜正上方的量,上负下正]
* @return {[type]}           [description]
*/
function aaa(parentDom,listDom,index,offset){	
	offset=typeof offset=='undefined'?0:offset;
	let ll=listDom.eq(index).position().top;
	if(parentDom.scrollTop()){
		parentDom.scrollTop(ll+parentDom.scrollTop()-offset);
	}else {
		parentDom.scrollTop(ll-offset);
	};
}
function gf() { //高度变化函数调用获取dom位置方法
	$('.hh').height(100);
aaa($('.box'),$('.hh'),8,-100);
}