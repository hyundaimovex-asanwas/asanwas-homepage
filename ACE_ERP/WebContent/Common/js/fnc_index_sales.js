/*var operation = null
var districtLeft = 214, dongLeft = 34, classLeft = 220, subClassLeft = 408, shopLeft = 365
var districtTop = 68, dongTop = 150, classTop = 150, subClassTop = 150, shopTop = 173
var itemCount = 0, districtID = -1
var mode = "", oldTitle = "", searchCondition = "";*/

//[함수]		1자리 숫자를 02와 같이 2자리 문자열로..
function makeDigit(num)	
{
	if(num.length < 2){
		num='0'+num;}
	return num;
}
//[함수]		글자수와 허용문자 체크
function CHECK(form) {
	if(form.value.length < 4 || form.value.length > 8) {
	 return false;
	}
	for(var i=0; i<form.value.length; i++) {
	 var chr=form.value.substr(i,1);
	 if((chr<'0' || chr >'9') && (chr < 'a' || chr >'z') && (chr < 'A' || chr >'Z') ) {
	   return false;
	   }
	}
	return true;
}

//[함수]		숫자체크
function ISNUMBER(form)
{
	for(var i=0; i<form.value.length; i++)
	{
		var chr=form.value.substr(i,1);
		if(chr<'0' || chr >'9')
		  return false;
	 }
	 return true;
}
//[함수]		대문자 만들기
function toUpper(form)	
{
	form.value = form.value.toUpperCase();
}

//[함수]		쿠키 쓰기			setCookie("blnEvent","true","July 18, 2010 00:00:00")
function setCookie(name, value) {
	document.cookie = name + "=" + escape( value ) + ";" ; 
} 

//[함수]		쿠키 지우기
function clearCookie(name) {
    var today = new Date()
    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    var expire_date = new Date(today.getTime() - 60*60*24*1000)
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString()
}
//[함수]		쿠키 읽기
function getCookie(name) {
   var from_idx = document.cookie.indexOf(name+'=');
   if (from_idx != -1) { 
      from_idx += name.length + 1;
      to_idx = document.cookie.indexOf(';', from_idx) ;
      if (to_idx == -1) {
            to_idx = document.cookie.length;
      }
      return unescape(document.cookie.substring(from_idx, to_idx))
   }
}


/*function changeDate()		//출발일을 변경하면 신청서번호를 불러온다.
{
	targetURL = "select.asp?oper=date&id=" + document.searchForm.sYear[document.searchForm.sYear.selectedIndex].value;
	targetURL = targetURL	+ makeDigit(document.searchForm.sMonth[document.searchForm.sMonth.selectedIndex].value);
	targetURL = targetURL	+ makeDigit(document.searchForm.sDay[document.searchForm.sDay.selectedIndex].value);
	top.execute1.location = targetURL;
}*/

//[공통]		신청서번호를 입력하면 해당 번호에 속하는 금액구분, 신청객실코드, 현재판매가를 불러온다.
function changeJpno(form)
{
	if (form.value.length < 12) {
		alert("신청서번호는 12자리입니다. 12자리를 모두 입력해주세요");
		form.focus();
		return; 
	}
	if (!ISNUMBER(form)) {	 //이부분은 DOM 폼이라서 배열이 ()로.. 처리..
		alert("신청서번호는 모두 숫자입니다. 숫자로 입력해 주세요...");
		form.focus();
		return;
	}

	targetURL1 = "select.asp?oper=wgu&id=" + document.searchForm.KG56JPNO.value;
	top.execute1.location = targetURL1;		//금액구분
	targetURL2 = "select.asp?oper=vcls&id=" + document.searchForm.KG56JPNO.value;
	top.execute2.location = targetURL2;		//신청객실코드
	targetURL3 = "select.asp?oper=clas&id=" + document.searchForm.KG56JPNO.value;
	top.execute3.location = targetURL3;		//확정객실코드
	targetURL4 = "select.asp?oper=panw&id=" + document.searchForm.KG56JPNO.value;
	top.execute4.location = targetURL4;		//현재판매가
	fn_sel(form.value);
}

//[빠른 수정]	쿼리 날리기
function qUpdate()
{
	document.searchForm.action="qUpdate.asp";	//?targetPrice="+document.all.targetPrice.value;
	document.searchForm.submit();
}

//[상세 수정]	그리드 그리기
function drawGrid()
{
	showNews();
	document.searchForm.action="drawGrid.asp";
	document.searchForm.submit();
//	top.execute1.location = "drawGrid.asp";
}


//[공통]		show progressbar
function showNews()
{
var win = document.all.newsWin;
	win.src = "";
	win.style.display = "none";
	win.src = "../library/progress.htm";
	win.style.display = "";
}
//[공통]		hide progressbar 
function hideNews()
{
	var win = document.all.newsWin;
	win.style.display = "none";
	win.src = "";
}


//[공통]		레이어 토글하면 토글한 것만 보여주기
function toggleLayer(layerIDX)
{
//	alert(layerIDX);
//	alert(window.idTabDiv[layerIDX]);
	var layerCnt = window.arrayLayer.length;	
	for(i=0 ; i<layerCnt ; i++) {	//모든 레이어를 닫아버리고
		window.idTabDiv[i].className="TabUnselected";
		window.arrayLayer[i].style.display = "none" ;
	}
	//해당 레이어만 열기
	window.idTabDiv[layerIDX].className="TabSelected";
	window.arrayLayer[layerIDX].style.display = "";
//	if(layerIDX=1)
//			initGrid();		//1번레이어이면 그리드초기화실행
}


//[공통]		레이어 토글하면 토글한 것만 보여주기
function togLeftMenu()
{
	var leftMenuCookie = getCookie("togLeftMenu");
	if (leftMenuCookie == 'close') 	{
		setCookie("togLeftMenu","open");
		window.leftMenuArrow.src="http://localhost:8080/erp/images/Common/arrow_menuClose.gif";
		window.leftMenuLayer.style.display = "" ;
	}else{
		setCookie("togLeftMenu","close");
		window.leftMenuArrow.src="http://localhost:8080/erp/images/Common/arrow_menuOpen.gif";
		window.leftMenuLayer.style.display = "none" ;
	}
}




//[공통]		페이지 초기화
function init() {
//	setCookie("togLeftMenu","close",1);
	document.searchForm.KG56JPNO.focus();
}
