function GetCookie (name) {
	var arg = name + "="
	var alen = arg.length
	var clen = document.cookie.length
	var i = 0
  
	while (i < clen){
		var j = i + alen
		if (document.cookie.substring(i, j) == arg)
			return getCookieVal (j)
		i = document.cookie.indexOf(" ", i) + 1
		if (i == 0) break
	}
    return null
};

function getCookieVal (offset) {
	var endstr = document.cookie.indexOf(";", offset)
	if (endstr == -1)
		endstr = document.cookie.length
	return unescape(document.cookie.substring(offset, endstr))
};


function init(){
	/* 서버에만 있는 포워딩 설정
    var url=location.href;
    url=url.substr(0,7);
    if( url == "http://") {
    	location.href = "https://ace.hdasan.com:447/";
    }/*
    
	var form = document.form;
	if(GetCookie("saveID")=="none"||GetCookie("saveID")==null){
		form.txt_id.focus();
	}else{
		form.txt_id.value=GetCookie("saveID");
		form.saveID.checked=true;
		form.txt_pass.focus();
	}

	/*if(GetCookie("pop2015") != "done" )	{	// 불러온 쿠키의 값이 "done"이 아니면~
		fnPop();
	}*/	
}

function popFirstHelp(){
	window.open("https://www.mtkumgang.com/popimgs/newERP.mht","","top=100, left=100, width=700,height=800, fullscreen=0, toolbar=0, scrollbars=1,locatioin=0,status=0,menubar=0m resizable=1");
}

function form_submit(){
	var form = document.form;
	form.ssID.value = session.getId()//클릭시 실시간 세션값 취
	if(form.saveID.checked) {
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + 3 );//3일
		document.cookie = "saveID=" + escape( form.txt_id.value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	} else {
		document.cookie = "saveID=none; path=/; expires=" + todayDate.toGMTString() + ";"
		//SetCookie("saveID","none");
	}
	return;
}




function fnPop() {
    var link ="Config/my/cm010i.jsp";
    var dialogWidth = 500; 
    var features ="top=0,left="+ ((screen.availWidth - dialogWidth) / 2)+",height=610, width="+dialogWidth+",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
    var pop_ap_dwr = window.open(link, 'pop_ap_dwr', features); 

}


