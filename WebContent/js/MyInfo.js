//Set hide and show for elements.
$(function(){
	$("#save").hide();
	$("#edit").click(function(){
		$("input[id^='e_']").show();
		$("select[id^='e_']").show();
		$("textarea[id^='e_']").show();
		$("[id^='e_']").show();
		$("span[id^='v_']").hide();
		$("#save").show();
		$("#edit").hide();
		$("#tips").show();
		
		dataViewToEdit();
		educationBackgroundViewToEdit();
	});
	$("#save").click(function(){
		$("input[id^='e_']").hide();
		$("select[id^='e_']").hide();
		$("textarea[id^='e_']").hide();
		$("[id^='e_']").hide();
		$("span[id^='v_']").show();
		$("#save").hide();
		$("#edit").show();
		$("#tips").hide();
		
		dataEditToView();
		educationBackgroundEditToView();
	});
});

function dataEditToView(){
	var e_name = $("#e_name").val();
	var e_gender = $("input[name='e_gender']:checked").val();
	var e_degree = $("input[name='e_degree']:checked").val();
	var e_year = $('#e_year option:selected').val();
	var e_status = $("input[name='e_status']:checked").val();
	var e_language = $('#e_language option:selected').val();
	var e_origin = $('#e_origin option:selected').val();
	var e_background = $('#e_background').val();
	$("#v_name").text(e_name);
	$("#v_gender").text(e_gender);
	$("#v_degree").text(e_degree);
	$("#v_year").text(e_year);
	$("#v_status").text(e_status);
	$("#v_language").text(e_language);
	$("#v_origin").text(e_origin);
	$("#v_background").text(e_background);
}
function dataViewToEdit(){
	var v_name = $("#v_name").text();
	var v_gender = $("#v_gender").text();
	var v_degree = $("#v_degree").text();
	var v_year = $("#v_year").text();
	var v_status = $("#v_status").text();
	var v_language = $("#v_language").text();
	var v_origin = $("#v_origin").text();
	var v_background = $("#v_background").text();
	$("#e_name").val(v_name);
	$("input[name=e_gender][value="+v_gender+"]").attr("checked",true);
	$("input[name=e_degree][value="+v_degree+"]").attr("checked",true);
	$("#e_year [value="+v_year+"]").attr("selected","selected");
	$("input[name=e_status][value="+v_status+"]").attr("checked",true);
	$("#e_language [value="+v_language+"]").attr("selected","selected");
	$("#e_origin [value="+v_origin+"]").attr("selected","selected");
	$("#e_background").val(v_background);
}

function educationBackgroundViewToEdit(){
	var v_ieltsMark = $("#v_ieltsMark").text();
	var v_toeflMark = $("#v_toeflMark").text();
	var v_greMark = $("#v_greMark").text();
	$("#e_ielts").val(v_ieltsMark);
	$("#e_toefl").val(v_toeflMark);
	$("#e_gre").val(v_greMark);
	var marksTitle=[$("#va_ielts"),$("#va_toefl"),$("#va_gre")];
	for(var i = 0; i<marksTitle.length;i++){
		marksTitle[i].show();
	}
}
function educationBackgroundEditToView(){
	var marksTitle=[$("#va_ielts"),$("#va_toefl"),$("#va_gre")];
	var marks=[$("#e_ielts"),$("#e_toefl"),$("#e_gre")];
	var marksSpan=[$("#v_ieltsMark"),$("#v_toeflMark"),$("#v_greMark")];
	for(var i = 0; i<marks.length;i++){
		if(marks[i].val()!=""){
			marksSpan[i].text(marks[i].val());
		}else{
			marksSpan[i].text("");
			marksTitle[i].hide();
			marksSpan[i].hide();
		}
	}
}


//var e_ielts = $("#e_ielts").val();
//var e_toefl = $("#e_toefl").val();
//var e_gre = $("#e_gre").val();













