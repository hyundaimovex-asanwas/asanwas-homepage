	
var root	= "";


var page_0_0_0=root+"/";//index

var page_0_1_0=root+"#";//로그인
var page_0_1_1=root+"#";//로그아웃
var page_0_2_0=root+"#";//회원가입
var page_0_3_0=root+"#";//사이트맵
var page_0_4_0=root+"#";//English

var page_0_5_0=root+"javascript:winopen();";//예약하기


var page_1_0_0=root+"/company/sub_company.jsp";//회사소개
var page_1_1_0=root+"/company/overview.jsp";//회사소개>개요
var page_1_2_0=root+"/company/history.jsp";//회사소개>연혁
var page_1_3_0=root+"/company/ceo01.jsp";//회사소개>CEO
var page_1_3_1=root+"/company/ceo01.jsp";//회사소개>CEO01
var page_1_3_2=root+"/company/ceo02.jsp";//회사소개>CEO02
var page_1_3_3=root+"/company/ceo03.jsp";//회사소개>CEO03
var page_1_3_4=root+"javascript:openCEO();";//회사소개>CEO04
var page_1_3_5=root+"#";//회사소개>CEO05
var page_1_4_0=root+"/company/business01.jsp";//회사소개>경영현황
var page_1_4_1=root+"/company/business0201.jsp";//회사소개>경영현황01
var page_1_4_2=root+"/company/business0202.jsp";//회사소개>경영현황02
var page_1_5_0=root+"/company/good.jsp";//회사소개>인재상
var page_1_6_0=root+"#";//회사소개>채용
var page_1_6_1=root+"#";//회사소개>채용>채용공고및 안내
var page_1_6_2=root+"#";//회사소개>채용>인사제도
var page_1_6_3=root+"#";//회사소개>채용>교육제도
var page_1_6_4=root+"#";//회사소개>채용>복리후생제도
var page_1_6_5=root+"#";//회사소개>채용>채용Q&A
var page_1_7_0=root+"/company/org.jsp";//회사소개>조직도
var page_1_8_0=root+"/company/ci01.jsp";//회사소개>CI
var page_1_8_1=root+"/company/ci01.jsp";//회사소개>CI01
var page_1_8_2=root+"/company/bi01.jsp";//회사소개>CI02
var page_1_9_0=root+"/company/map01.jsp";//회사소개>사업소위치


var page_2_0_0=root+"#";//관광사업
var page_2_1_0=root+"#";//관광사업
var page_2_2_0=root+"#";//관광사업
var page_2_3_0=root+"#";//관광사업
var page_2_4_0=root+"#";//관광사업
var page_2_5_0=root+"#";//관광사업
var page_2_6_0=root+"#";//관광사업
var page_2_7_0=root+"#";//관광사업
var page_2_8_0=root+"#";//관광사업


var page_3_0_0=root+"#";//개성공단
var page_3_1_0=root+"#";//개성공단
var page_3_2_0=root+"#";//개성공단
var page_3_3_0=root+"#";//개성공단
var page_3_4_0=root+"#";//개성공단
var page_3_5_0=root+"#";//개성공단
var page_3_6_0=root+"#";//개성공단
var page_3_7_0=root+"#";//개성공단
var page_3_8_0=root+"#";//개성공단


var page_4_0_0=root+"#";//건설사업
var page_4_1_0=root+"#";//건설사업
var page_4_2_0=root+"#";//건설사업
var page_4_3_0=root+"#";//건설사업
var page_4_4_0=root+"#";//건설사업
var page_4_5_0=root+"#";//건설사업


var page_5_0_0=root+"#";//기타사업
var page_5_1_0=root+"#";//기타사업
var page_5_2_0=root+"#";//기타사업
var page_5_3_0=root+"#";//기타사업
var page_5_4_0=root+"#";//기타사업
var page_5_5_0=root+"#";//기타사업
var page_5_6_0=root+"#";//기타사업
var page_5_7_0=root+"#";//기타사업
var page_5_8_0=root+"#";//기타사업


var page_6_0_0=root+"#";//사이버홍보실
var page_6_1_0=root+"#";//사이버홍보실
var page_6_2_0=root+"#";//사이버홍보실
var page_6_3_0=root+"#";//사이버홍보실
var page_6_4_0=root+"#";//사이버홍보실
var page_6_5_0=root+"#";//사이버홍보실
var page_6_6_0=root+"#";//사이버홍보실
var page_6_7_0=root+"#";//사이버홍보실
var page_6_8_0=root+"#";//사이버홍보실


var page_7_0_0=root+"#";//고객지원
var page_7_1_0=root+"#";//고객지원
var page_7_2_0=root+"#";//고객지원
var page_7_3_0=root+"#";//고객지원
var page_7_4_0=root+"#";//고객지원



function pageURL(a, b, c)
{
	var page = "page_" + a +"_"+ b +"_"+ c ;
	/*
	if( ( a == 0 && ( b == 1 || b == 2 || b == 3 || b == 4 || b == 5 ) ) || ( a == 2 ) || ( a == 3 ) || ( a == 4 ) || ( a == 5 ) || ( a == 6 ) ) {
		alert("서비스 준비 중입니다.");
	}*/

	if(eval(page) == "#") {
		alert("서비스 준비 중입니다.");
	}
	else{
		location.href=eval(page);
	}
}


// 서치
function search(str)
{
	alert("서비스 준비 중입니다.");
	//var page = ""+str ;
	//location.href=eval(page);
}


function winopen()
{
	window.open("http://www.mtkumgang.com/");
}


function openCEO() { //--CEO동향 윈도--
  sw = screen.width;  // to center: use desired width
  sh = screen.height;  // to center: use desired height
  cx = (sw-700) * 0.5  // to center: (.5*sw) - (w*.5)
  cy = (sh-450) * 0.5  // to center: (.5*sh) - (h*.5)
  window.open('http://old.hdasan.com/brdFrame_CEO.htm','winCEO','left='+cx+',top='+cy+',width=700,height=450,fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0');
 }

