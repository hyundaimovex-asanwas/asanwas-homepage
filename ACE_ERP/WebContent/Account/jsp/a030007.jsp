
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 결산관리 - 월계표
+ 프로그램 ID	: A030007
+ 기 능 정 의	: 조회, 출력
+ 최 초 이 력	: 구자헌
+ 서 블 릿 명	: a030007_s1, a030007_s2

-----------------------------------------------------------------------------
+ 수 정 내 용  :	 출력  
+ 수   정  자  :  하민숙
+ 수 정 일 자  :  2006.3.15
------------------------------------------------------------------------------
+ 수 정 내 용  :	 출력물 수정
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.10
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>월계표</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
//get_cookdata();

var gs_date = gcurdate.substring(0, 4) + gcurdate.substring(5, 7) + gcurdate.substring(8,10); //현재월
var gs_date2 = gcurdate.substring(0, 4) + "01"; //년초 월
var gs_date3 //기준월 한달 전
var gs_date4 //현재달,기준월
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_Before();	
	
}

/******************************************************************************
	Description : 조회 
******************************************************************************/
function ln_Query(){

	var str1 = gclx_sfdcode.BindColVal;	//지점코드	
	var str2 = gs_date2; //년초 월
	var str3 = gs_date3; //기준월 한달 전
	var str4 = gs_date4; //기준월
	var str5 = gclx_gubun.BindColVal; //구분


	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030007_s1?v_str1=" + str1 + "&v_str2=" + str2 + "&v_str3=" + str3 + "&v_str4=" + str4+"&v_str5=" + str5;
//	prompt("",gcds_data1.DataID);
	
	gcds_data1.Reset();

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030007_s2" + "?v_str1=" + str1 + "&v_str2=" + str4;
	gcds_data2.Reset();

}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
  
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
 
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

	var str1 = gclx_sfdcode.BindColVal;	//지점코드	
	var str2 = gs_date2; //년초 월
	var str3 = gs_date3; //기준월 한달 전
	var str4 = gs_date4; //기준월
	var str5 = gclx_gubun.BindColVal; //구분

	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030007_s1?v_str1=" + str1 + "&v_str2=" + str2 + "&v_str3=" + str3 + "&v_str4=" + str4+"&v_str5=" + str5;
	gcds_print1.Reset();



}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Format() {

	var ls_for = "";

  var cnt  = ft_cnt1.innerText;
  if(cnt == 'undefined')	cnt=""; 

	var strfr = gcem_yyyymm.text;

  var yyyy = strfr.substring(0,4);
  var mm = strfr.substring(4,6);	 
	var dd = strfr.substring(6,8);

	var yyyy3 = gs_date.substring(0,4);
	var mm3 = gs_date.substring(4,6);
	var dd3 = gs_date.substring(6,8);

	var fd = gcds_sfdcode.NameValue(gcds_sfdcode.rowposition,"FDNAME");


//	gcds_print1.Addrow();		

	ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=438 ,face='Arial' ,size=10 ,penwidth=1	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>	<T>id='월   계   표' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>	<T>id='(회계년월 : "+yyyy+"년 "+mm+"월)' ,left=1150 ,top=119 ,right=2003 ,bottom=166 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=2384 ,top=181 ,right=2806 ,bottom=228 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=234 ,top=437 ,right=2809 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='현금' ,left=872 ,top=378 ,right=1166 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='대변' ,left=1956 ,top=297 ,right=2734 ,bottom=362 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=234 ,top=287 ,right=2809 ,bottom=287 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=550 ,top=372 ,right=550 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2503 ,top=372 ,right=2503 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='대체' ,left=2200 ,top=378 ,right=2494 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='계정과목' ,left=1244 ,top=294 ,right=1803 ,bottom=428 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<C>id='작성일자:', left=2384, top=181, right=2806, bottom=228, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='회계일자 :', left=859, top=119, right=2003, bottom=166, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=234 ,top=369 ,right=1175 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=863 ,top=372 ,right=863 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1872 ,top=369 ,right=2809 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2191 ,top=372 ,right=2191 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1175 ,top=287 ,right=1175 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1875 ,top=287 ,right=1875 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='지점 : "+fd+"' ,left=234 ,top=231 ,right=519 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='Page : #p of #t' ,left=2384 ,top=234 ,right=2806 ,bottom=278 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='합계' ,left=2513 ,top=378 ,right=2800 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='현금' ,left=1884 ,top=378 ,right=2181 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='차변' ,left=388 ,top=297 ,right=1019 ,bottom=362 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=2809 ,top=284 ,right=2809 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=234 ,top=284 ,right=234 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='대체' ,left=559 ,top=378 ,right=853 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='합계' ,left=244 ,top=381 ,right=541 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T></B><B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=234 ,top=0 ,right=234 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='CRTOT', left=2513, top=0, right=2800, bottom=44, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=2503 ,top=0 ,right=2503 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2191 ,top=0 ,right=2191 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1875 ,top=0 ,right=1875 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1175 ,top=0 ,right=1175 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=550 ,top=0 ,right=550 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=234 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>	<C>id='CRCASH', left=872, top=3, right=1166, bottom=44, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='ATKORNAM', left=1181, top=0, right=1763, bottom=47, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF,align='left'</C>	<C>id='DETOT', left=244, top=0, right=541, bottom=47, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='DECRVAL', left=559, top=0, right=850, bottom=47, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=859 ,top=0 ,right=859 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='CRDEVAL', left=2200, top=3, right=2494, bottom=44, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='DECASH', left=1884, top=3, right=2181, bottom=44, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C></B><B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1	<L> left=234 ,top=47 ,right=2809 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='"+cnt+"' ,left=244 ,top=3 ,right=1859 ,bottom=44 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=234 ,top=0 ,right=234 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=231 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>	<L> left=234 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B>";

	gcrp_print.Format = ls_for + gcrp_print.Format;
}
/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
//	gcgd_data1.runexcel("월계표");
     gcgd_data1.GridToExcel("월계표","",2);

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 

	//gclx_sfdcode.BindColVal = "01";			//지점코드
	//gcra_data.CodeValue	 = "1";				//구분

	gs_date4 = gcurdate.substring(0, 4) + "01"; //기준월세팅
	gs_date3 = shiftTime(gs_date4, 0, -1); //기준월 한달 전 세팅
	
	gcem_yyyymm.text  = gs_date4;	
	gcem_staxdatfr.text	 = gs_date4;	//계산서기간 from
	gcem_staxdatto.text	 = gs_date;			//계산서기간 to

	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); //지점코드

	gclx_gubun.index=0;

}

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1월=0,12월=11
    return new Date(year,month);
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함

    if (("" + month).length == 1) { month = "0" + month; }

    return ("" + year + month);
}

/**
 * 주어진 Time 과 y년 m월 차이나는 Time을 리턴
 *
 * ex) var time = form.time.value; //'200001'
 *     alert(shiftTime(time,0,-1));
 *     => 2000/01 으로부터 1월 전 Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m) { //moveTime(time,y,m)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y년을 더함
    date.setMonth(date.getMonth() + m);       //m월을 더함

    return toTimeString(date);
}

function back() {
	var date = gcem_yyyymm.text;
	var date1 = shiftTime(date, 0, -1);
	if(date1<gcem_staxdatfr.text ){
		alert("from 기간보다 작을 수 없습니다.");
		return;
	}
	gcem_yyyymm.text = date1;
	gs_date3 = shiftTime(date1, 0, -1);
	gs_date4 = date1;
}

function forward() {
	var date = gcem_yyyymm.text;
	var date1 = shiftTime(date, 0, 1);
	if(date1>gcem_staxdatto.text ){
		alert("to 기간보다 클 수 없습니다.");
		return;
	}
	gcem_yyyymm.text = date1;
	gs_date3 = shiftTime(date1, 0, -1);
	gs_date4 = date1;
}

/***********************************************************************************************
	Description : [일별] - 계정원장 찾기
	parameter   : fcod - 지점코드, atcod - 계정코드, frdt - 검색일자(from), todt - 검색일자(to)
**********************************************************************************************/
function ln_Popup2(fcod,atcod,frdt,todt){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;

	strURL = "./totalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : 총계정원장[일별] 찾기
	parameter   : fcod2 - 지점코드, atcod2 - 계정코드, frdt2 - 검색일자(from), todt2 - 검색일자(to)
**********************************************************************************************/
function ln_Popup3(fcod2,atcod2,frdt2,todt2){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod2;
	arrParam[1] = atcod2;
	arrParam[2] = frdt2;
	arrParam[3] = todt2;

	strURL = "./DTotalbal_popup.";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 계정 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 합계 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_sfdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 레포트 -->
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_sfdcode" event="OnCloseUp()">
	//txt_fdcode.value = gclx_sfdcode.BindColVal;	
</script>

<script language=JavaScript for="gcem_staxdatfr" event="onKillFocus()">
	gcem_yyyymm.text = gcem_staxdatfr.text;
	gs_date3 = shiftTime(gcem_staxdatfr.text, 0, -1);
	gs_date4 = gcem_staxdatfr.text;
</script>

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	//ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row<1)
		alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	//ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row<1) {
		//	alert("검색된 데이터가 없습니다.");
		ft_cnt1.innerText = "전표갯수 : " + row;
	}
	else {
		ft_cnt1.innerText = "전표갯수 : " + gcds_data2.nameValue(gcds_data2.rowposition, "TOTAL")
		+ "  전표번호 : " + gcds_data2.nameValue(gcds_data2.rowposition, "FSNBR1")
		+ " ~ " + gcds_data2.nameValue(gcds_data2.rowposition, "FSNBR2");
	}

</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";	
	ln_Format();
	gcrp_print.preview(); 
		
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<script language=JavaScript for=gcgd_data1 event=OnDblClick(row,colid)>
	var row = gcds_data1.rowposition;
	var p_fcod = gclx_sfdcode.BindColVal;//지점코드
	var p_acod = gcds_data1.namevalue(row,"ATCODE");//계정코드
	var p_frdt = gcds_data1.namevalue(row,"ACTYYMM")+"01";//일자1
	var p_todt = gcds_data1.namevalue(row,"ACTYYMM")+"31";//일자2
	ln_Popup2(p_fcod,p_acod,p_frdt,p_todt);	//계정원장[일별] Popup
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
  <tr> 
        <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030007_head.gif"></td>
    <td width="879" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" HEIGHT=47>	

			 <IMG src="../../Common/img/btn/com_b_print.gif"  style="cursor:hand"  onclick="ln_Print()">
			 <IMG src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand"  onclick="ln_Excel()">	
			 <IMG src="../../Common/img/btn/com_b_query.gif"  style="CURSOR: hand" onclick="ln_Query()" > 
			&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>

<table cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr> 
<!------지점코드------>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;지점코드&nbsp;</font></nobr></td>				
					<td width="170px;" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
<!-----회계일자------>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;기&nbsp;간&nbsp;</font></nobr></td>
					<td width="300px" class="tab23"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text'),gcem_yyyymm.text = gcem_staxdatfr.text,gs_date3 = shiftTime(gcem_staxdatfr.text, 0, -1),gs_date4 = gcem_staxdatfr.text;" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	            value=true>
							<param name=Format	            value="YYYY/MM">
							<param name=PromptChar	        value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;right:0px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td> 
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr></font style="position:relative;top:1px;">&nbsp;회계년월&nbsp;</font></nobr></td>
					<td width="170px;" class="tab23"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:5px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	            value=false>
							<param name=Format	            value="YYYY/MM">
							<param name=PromptChar	        value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;월계표&nbsp;</font></nobr></td>
					<td width="300px" class="tab23"><nobr>&nbsp;
					<img src="../../Common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;left:-5px;cursor:hand" onClick="back()">
					<img src="../../Common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;left:-7px;cursor:hand" onClick="forward()"></nobr>
					</td>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr></font style="position:relative;top:1px;">&nbsp;구&nbsp;분</font></nobr></td>
					<td width="270px;" class="tab23"><nobr>&nbsp;
							<comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
									<param name=CBData			   value="''1^계정별,2^집계계정">
									<param name=CBDataColumns		value="Code,Parm">
									<param name=SearchColumn		value="Parm">
									<param name=Sort						value="false">
									<param name=ListExprFormat	value="Parm^0^80">
									<param name=BindColumn			value="Code">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
					</td>



					<!-- <td width=100%>&nbsp;</td> -->
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2">

      <table width="875" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:876" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:875" >
						  <PARAM NAME="DataID"			VALUE="gcds_data1">
					      <PARAM NAME="Editable"		VALUE="false">
					      <PARAM NAME="ColSizing"		VALUE="true">
					      <PARAM NAME="SortView"		VALUE="left">
					      <PARAM NAME="BorderStyle"     VALUE="0">
						  <param name="Fillarea"		VALUE="true">
						<PARAM NAME="IndWidth"		VALUE="0">
						  <PARAM NAME="Format"		    VALUE=" 
	<G>Name='차변', HeadBgColor=#B9D4DC,HeadAlign=center
	<C>ID=DETOT,	Name='합계',width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
	<C>ID=DECRVAL,	Name='대체' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center,align=right</C>
	<C>ID=CRCASH, Name='현금' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>  
	</G>	
	<C>ID=ATCODE, Name='계정코드' ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center show=false</C>
	<C>ID=ATKORNAM, Name='계정과목' ,width=255, HeadBgColor=#B9D4DC,HeadAlign=center, align=left</C>
	<G>Name='대변', HeadBgColor=#B9D4DC,HeadAlign=center
	<C>ID=DECASH, Name='현금' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>  
	<C>ID=CRDEVAL,	Name='대체' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center,align=right</C>
	<C>ID=CRTOT,	Name='합계',width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
	</G>
												">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;">전표갯수 :</font>
						</fieldset>
					</td>
        </tr>
			</table>

    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_print1">
	<param NAME="DetailDataID"			VALUE="gcds_print1">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
 <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="

">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
