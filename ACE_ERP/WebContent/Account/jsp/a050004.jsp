<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 세금계산서집계표
+ 프로그램 ID	:  A050004.html
+ 기 능 정 의	:  세금계산서집계표 출력 및 조회 화면이다.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 a050004_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>세금계산서집계표</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_date3 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var cuserid  = gusrid;		
var g_fdcod  = gfdcode;	//지점코드
var gdeptcd  = gdeptcd;	//부서코드

var btc = 0;
var bts = 0;
var btv = 0;
var atc = 0;
var ats = 0;
var atv = 0;
var abtc =0;
var abts =0;
var abtv =0;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
  btc = 0;
  bts = 0;
  btv = 0;
  atc = 0;
  ats = 0;
  atv = 0;
  abtc =0;
  abts =0;
  abtv =0;

	var str1 = gclx_fdcode1.BindColVal;		//지점코드
	var str2 = gcem_saccyy.text;					//예산년도
	var str5 = "A";												//매입
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	if(gisu=="1"){ 			str3 = str2+"0101";	str4 = str2+"0331";
	}else if(gisu=="2"){str3 = str2+"0401";	str4 = str2+"0630";
	}else if(gisu=="3"){str3 = str2+"0701";	str4 = str2+"0930";
	}else if(gisu=="4"){str3 = str2+"1001";	str4 = str2+"1231";}
  
  var com="";
  if(str1==02){
    com='1018510695';
  }else if(str1==01){
    com='2218113834';
  }

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s1?v_str1="+com;
	gcds_data1.Reset();

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s2?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_data2.Reset();

	gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s3?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_data3.Reset();

	gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s4?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_data4.Reset();

	gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s5?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_data5.Reset();
/*
  var btc = parseInt(gcds_data2.namevalue(1,"ILBAN_CNT"))    + parseInt(gcds_data2.namevalue(1,"YOUNG_CNT"))    + parseInt(gcds_data3.namevalue(1,"00001"));
  var bts = parseInt(gcds_data2.namevalue(1,"ILBAN_GONAMT")) + parseInt(gcds_data2.namevalue(1,"YOUNG_GONAMT")) + parseInt(gcds_data3.namevalue(1,"00002"));
  var btv = parseInt(gcds_data2.namevalue(1,"ILBAN_VATAMT")) + parseInt(gcds_data2.namevalue(1,"YOUNG_VATAMT")) + parseInt(gcds_data3.namevalue(1,"00003"));
  var atc = parseInt(gcds_data4.namevalue(1,"ILBAN_CNT"))    + parseInt(gcds_data4.namevalue(1,"GITA_CNT"))    + parseInt(gcds_data4.namevalue(1,"BUL_CNT"))    + parseInt(gcds_data4.namevalue(1,"BUL_CNT")) + parseInt(gcds_data5.namevalue(1,"00001"));
  var ats = parseInt(gcds_data4.namevalue(1,"ILBAN_GONAMT")) + parseInt(gcds_data4.namevalue(1,"GITA_GONAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_GONAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_CNT")) + parseInt(gcds_data5.namevalue(1,"00002"));
  var atv = parseInt(gcds_data4.namevalue(1,"ILBAN_VATAMT")) + parseInt(gcds_data4.namevalue(1,"GITA_VATAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_VATAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_CNT")) + parseInt(gcds_data5.namevalue(1,"00003"));
  var abtc = parseInt(gcds_data2.namevalue(1,"ILBAN_CNT"))    + parseInt(gcds_data2.namevalue(1,"YOUNG_CNT"))    + parseInt(gcds_data3.namevalue(1,"00001")) + parseInt(gcds_data4.namevalue(1,"ILBAN_CNT"))    + parseInt(gcds_data4.namevalue(1,"GITA_CNT"))    + parseInt(gcds_data4.namevalue(1,"BUL_CNT"))    + parseInt(gcds_data4.namevalue(1,"BUL_CNT")) + parseInt(gcds_data5.namevalue(1,"00001"));
  var abts = parseInt(gcds_data2.namevalue(1,"ILBAN_GONAMT")) + parseInt(gcds_data2.namevalue(1,"YOUNG_GONAMT")) + parseInt(gcds_data3.namevalue(1,"00002")) + parseInt(gcds_data4.namevalue(1,"ILBAN_GONAMT")) + parseInt(gcds_data4.namevalue(1,"GITA_GONAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_GONAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_CNT")) + parseInt(gcds_data5.namevalue(1,"00002"));
  var abtv = parseInt(gcds_data2.namevalue(1,"ILBAN_VATAMT")) + parseInt(gcds_data2.namevalue(1,"YOUNG_VATAMT")) + parseInt(gcds_data3.namevalue(1,"00003")) + parseInt(gcds_data4.namevalue(1,"ILBAN_VATAMT")) + parseInt(gcds_data4.namevalue(1,"GITA_VATAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_VATAMT")) + parseInt(gcds_data4.namevalue(1,"BUL_CNT")) + parseInt(gcds_data5.namevalue(1,"00003"));

  var btc = eval(gcds_data2.namevalue(1,"ILBAN_CNT"))    + eval(gcds_data2.namevalue(1,"YOUNG_CNT"))    + eval(gcds_data3.namevalue(1,"00001"));
  var bts = eval(gcds_data2.namevalue(1,"ILBAN_GONAMT")) + eval(gcds_data2.namevalue(1,"YOUNG_GONAMT")) + eval(gcds_data3.namevalue(1,"00002"));
  var btv = eval(gcds_data2.namevalue(1,"ILBAN_VATAMT")) + eval(gcds_data2.namevalue(1,"YOUNG_VATAMT")) + eval(gcds_data3.namevalue(1,"00003"));
  var atc = eval(gcds_data4.namevalue(1,"ILBAN_CNT"))    + eval(gcds_data4.namevalue(1,"GITA_CNT"))    + eval(gcds_data4.namevalue(1,"BUL_CNT"))    + eval(gcds_data4.namevalue(1,"BUL_CNT")) + eval(gcds_data5.namevalue(1,"00001"));
  var ats = eval(gcds_data4.namevalue(1,"ILBAN_GONAMT")) + eval(gcds_data4.namevalue(1,"GITA_GONAMT")) + eval(gcds_data4.namevalue(1,"BUL_GONAMT")) + eval(gcds_data4.namevalue(1,"BUL_CNT")) + eval(gcds_data5.namevalue(1,"00002"));
  var atv = eval(gcds_data4.namevalue(1,"ILBAN_VATAMT")) + eval(gcds_data4.namevalue(1,"GITA_VATAMT")) + eval(gcds_data4.namevalue(1,"BUL_VATAMT")) + eval(gcds_data4.namevalue(1,"BUL_CNT")) + eval(gcds_data5.namevalue(1,"00003"));
  var abtc = eval(gcds_data2.namevalue(1,"ILBAN_CNT"))    + eval(gcds_data2.namevalue(1,"YOUNG_CNT"))    + eval(gcds_data3.namevalue(1,"00001")) + eval(gcds_data4.namevalue(1,"ILBAN_CNT"))    + eval(gcds_data4.namevalue(1,"GITA_CNT"))    + eval(gcds_data4.namevalue(1,"BUL_CNT"))    + eval(gcds_data4.namevalue(1,"BUL_CNT")) + eval(gcds_data5.namevalue(1,"00001"));
  var abts = eval(gcds_data2.namevalue(1,"ILBAN_GONAMT")) + eval(gcds_data2.namevalue(1,"YOUNG_GONAMT")) + eval(gcds_data3.namevalue(1,"00002")) + eval(gcds_data4.namevalue(1,"ILBAN_GONAMT")) + eval(gcds_data4.namevalue(1,"GITA_GONAMT")) + eval(gcds_data4.namevalue(1,"BUL_GONAMT")) + eval(gcds_data4.namevalue(1,"BUL_CNT")) + eval(gcds_data5.namevalue(1,"00002"));
  var abtv = eval(gcds_data2.namevalue(1,"ILBAN_VATAMT")) + eval(gcds_data2.namevalue(1,"YOUNG_VATAMT")) + eval(gcds_data3.namevalue(1,"00003")) + eval(gcds_data4.namevalue(1,"ILBAN_VATAMT")) + eval(gcds_data4.namevalue(1,"GITA_VATAMT")) + eval(gcds_data4.namevalue(1,"BUL_VATAMT")) + eval(gcds_data4.namevalue(1,"BUL_CNT")) + eval(gcds_data5.namevalue(1,"00003"));

  gcem_b_totcnt.text = gcds_data2.namevalue(1,"ILBAN_CNT")    + gcds_data2.namevalue(1,"YOUNG_CNT")    + gcds_data3.namevalue(1,"00001");
  gcem_b_totsum.text = gcds_data2.namevalue(1,"ILBAN_GONAMT") + gcds_data2.namevalue(1,"YOUNG_GONAMT") + gcds_data3.namevalue(1,"00002");
  gcem_b_totvat.text = gcds_data2.namevalue(1,"ILBAN_VATAMT") + gcds_data2.namevalue(1,"YOUNG_VATAMT") + gcds_data3.namevalue(1,"00003");

  gcem_a_totcnt.text = gcds_data4.namevalue(1,"ILBAN_CNT")    + gcds_data4.namevalue(1,"GITA_CNT")    + gcds_data4.namevalue(1,"BUL_CNT")    + gcds_data4.namevalue(1,"BUL_CNT") + gcds_data5.namevalue(1,"00001");
  gcem_a_totsum.text = gcds_data4.namevalue(1,"ILBAN_GONAMT") + gcds_data4.namevalue(1,"GITA_GONAMT") + gcds_data4.namevalue(1,"BUL_GONAMT") + gcds_data4.namevalue(1,"BUL_CNT") + gcds_data5.namevalue(1,"00002");
  gcem_a_totvat.text = gcds_data4.namevalue(1,"ILBAN_VATAMT") + gcds_data4.namevalue(1,"GITA_VATAMT") + gcds_data4.namevalue(1,"BUL_VATAMT") + gcds_data4.namevalue(1,"BUL_CNT") + gcds_data5.namevalue(1,"00003");

  gcem_ab_totcnt.text = gcds_data2.namevalue(1,"ILBAN_CNT")    + gcds_data2.namevalue(1,"YOUNG_CNT")    + gcds_data3.namevalue(1,"00001") + gcds_data4.namevalue(1,"ILBAN_CNT")    + gcds_data4.namevalue(1,"GITA_CNT")    + gcds_data4.namevalue(1,"BUL_CNT")    + gcds_data4.namevalue(1,"BUL_CNT") + gcds_data5.namevalue(1,"00001");
  gcem_ab_totsum.text = gcds_data2.namevalue(1,"ILBAN_GONAMT") + gcds_data2.namevalue(1,"YOUNG_GONAMT") + gcds_data3.namevalue(1,"00002") + gcds_data4.namevalue(1,"ILBAN_GONAMT") + gcds_data4.namevalue(1,"GITA_GONAMT") + gcds_data4.namevalue(1,"BUL_GONAMT") + gcds_data4.namevalue(1,"BUL_CNT") + gcds_data5.namevalue(1,"00002");
  gcem_ab_totvat.text = gcds_data2.namevalue(1,"ILBAN_VATAMT") + gcds_data2.namevalue(1,"YOUNG_VATAMT") + gcds_data3.namevalue(1,"00003") + gcds_data4.namevalue(1,"ILBAN_VATAMT") + gcds_data4.namevalue(1,"GITA_VATAMT") + gcds_data4.namevalue(1,"BUL_VATAMT") + gcds_data4.namevalue(1,"BUL_CNT") + gcds_data5.namevalue(1,"00003");
*/
}
function subSum(){
  gcem_b_totcnt.text = gcds_data2.namevalue(1,"ILBAN_CNT")    + gcds_data2.namevalue(1,"YOUNG_CNT")    + gcds_data3.namevalue(1,"A00001");
  gcem_b_totsum.text = gcds_data2.namevalue(1,"ILBAN_GONAMT") + gcds_data2.namevalue(1,"YOUNG_GONAMT") + gcds_data3.namevalue(1,"A00002");
  gcem_b_totvat.text = gcds_data2.namevalue(1,"ILBAN_VATAMT") + gcds_data2.namevalue(1,"YOUNG_VATAMT") + gcds_data3.namevalue(1,"A00003");

  gcem_a_totcnt.text = gcds_data4.namevalue(1,"ILBAN_CNT")    + gcds_data4.namevalue(1,"GITA_CNT")    + gcds_data4.namevalue(1,"BUL_CNT")    + gcds_data5.namevalue(1,"B00001");
  gcem_a_totsum.text = gcds_data4.namevalue(1,"ILBAN_GONAMT") + gcds_data4.namevalue(1,"GITA_GONAMT") + gcds_data4.namevalue(1,"BUL_GONAMT") + gcds_data5.namevalue(1,"B00002");
  gcem_a_totvat.text = gcds_data4.namevalue(1,"ILBAN_VATAMT") + gcds_data4.namevalue(1,"GITA_VATAMT") + gcds_data4.namevalue(1,"BUL_VATAMT") + gcds_data5.namevalue(1,"B00003");

  gcem_ab_totcnt.text = gcds_data2.namevalue(1,"ILBAN_CNT")    + gcds_data2.namevalue(1,"YOUNG_CNT")    + gcds_data3.namevalue(1,"A00001") + gcds_data4.namevalue(1,"ILBAN_CNT")    + gcds_data4.namevalue(1,"GITA_CNT")    + gcds_data4.namevalue(1,"BUL_CNT")    + gcds_data5.namevalue(1,"B00001");
  gcem_ab_totsum.text = gcds_data2.namevalue(1,"ILBAN_GONAMT") + gcds_data2.namevalue(1,"YOUNG_GONAMT") + gcds_data3.namevalue(1,"A00002") + gcds_data4.namevalue(1,"ILBAN_GONAMT") + gcds_data4.namevalue(1,"GITA_GONAMT") + gcds_data4.namevalue(1,"BUL_GONAMT") + gcds_data5.namevalue(1,"B00002");
  gcem_ab_totvat.text = gcds_data2.namevalue(1,"ILBAN_VATAMT") + gcds_data2.namevalue(1,"YOUNG_VATAMT") + gcds_data3.namevalue(1,"A00003") + gcds_data4.namevalue(1,"ILBAN_VATAMT") + gcds_data4.namevalue(1,"GITA_VATAMT") + gcds_data4.namevalue(1,"BUL_VATAMT") + gcds_data5.namevalue(1,"B00003");
}
/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
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

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_disp01.RunExcel('세금계산서집계표');	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_saccyy.text    = gs_date2;	//년도
	gclx_saccyyqt.index = 0;				//기수
  gclx_fdcode1.index = 0;
	gcem_wrdt.text		  = gs_date;	//작성일자
//	gcem_taxtermfr.text = gs_date3+"01";	//거래기간fr
//	gcem_taxtermto.text = gs_date;				//거래기간to
  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0101";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0401";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0701";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"1001";
    gcem_taxtermto.Text = gcem_saccyy.Text+"1231";
  }
	//지점코드
//	gcds_fdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
//	gcds_fdcode1.Reset();
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_fdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
//  alert("row :"+row);
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	}
  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0101";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0401";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0701";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"1001";
    gcem_taxtermto.Text = gcem_saccyy.Text+"1231";
  }
</script>
<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
  subSum();
</script>
<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
subSum();
//  alert("3row :"+row);
</script>
<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
subSum();
</script>
<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
subSum();
//  alert("5row :"+row);
</script>






<script language="javascript" for="gcds_fdcode1" event="onloadCompleted(row,colid)">

</script>
<script language=JavaScript for=gclx_saccyyqt event=onSelChange()>
  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0101";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0401";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0701";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"1001";
    gcem_taxtermto.Text = gcem_saccyy.Text+"1231";
  }
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050004_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<table cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>사&nbsp;업&nbsp;소</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_fdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
								<param name=CBData					value="02^서울,01^고성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>년&nbsp;&nbsp;&nbsp;&nbsp;도</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;분&nbsp;기&nbsp;수&nbsp;</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1기,2^2기,3^3기,4^4기">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_print.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print()">
						<img src="../../Common/img/btn/com_b_query.gif"	 style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr>
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>등록번호</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:85px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=Format			value="000-00-00000">
									<param name=PromptChar	value="_">
									<param name=Enable			value="false">
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상&nbsp;&nbsp;&nbsp;&nbsp;호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업장주소</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_addrs classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>업&nbsp;&nbsp;&nbsp;&nbsp;태</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_bsnscnd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>종&nbsp;&nbsp;&nbsp;&nbsp;목</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_bsnsknd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>작성일자</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object id=gcem_wrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_wrdt','Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>거래기간</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object id=gcem_taxtermfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxtermfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~<comment id="__NSID__">
								<object id=gcem_taxtermto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_taxtermto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr><!-- 세금계산서 집계표 자료 -->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:304px" bgcolor="#eeeeee"><nobr>자료구분</nobr></td>
							<td class="tab11" style="width:184px" bgcolor="#eeeeee">세금계산서매수</td>
							<td class="tab11" style="width:184px" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
							<td class="tab13" style="width:184px" bgcolor="#eeeeee">세액</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px">일반 매출</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_cnt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_taxsum01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_vatsum01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<!--tr>
							<td class="tab11" style="width:304px">감액 매출</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_cnt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_taxsum02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_vatsum02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr-->
						<tr>
							<td class="tab11" style="width:304px">영세율매출</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_cnt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_taxsum03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_vatsum03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px">주민기재분</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_cnt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_taxsum04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_b_vatsum04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px" bgcolor="#eeeeee">매출 합계</td>
							<td class="tab11" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_b_totcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_b_totsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_b_totvat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px">일반 매입</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_cnt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_taxsum01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_vatsum01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px">고정자산 매입분</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_cnt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_taxsum02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_vatsum02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px">기타 매입분</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_cnt03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_taxsum03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_vatsum03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px">불공제매입</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_cnt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_taxsum04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px"><comment id="__NSID__">
								<object id=gcem_a_vatsum04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:304px" bgcolor="#eeeeee">매입 합계</td>
							<td class="tab11" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_a_totcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_a_totsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab13" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_a_totvat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:304px" bgcolor="#eeeeee">총 합 계</td>
							<td class="tab12" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_ab_totcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:184px" bgcolor="#eeeeee"><comment id="__NSID__">
								<object id=gcem_ab_totsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td style="width:184px" bgcolor="#eeeeee" align="center"><comment id="__NSID__">
								<object id=gcem_ab_totvat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:175px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=MaxLength   value=15>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<!-- <tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:1px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:304px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data1">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='등록번호'	ID=VEND_NM	HeadAlign=Center HeadBgColor=#B9D4DC Width=183	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
								<C> Name='상호'			ID=PREAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='매수'			ID=CURAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='공란수'		ID=CURAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='공급가액'	ID=REAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='세액'			ID=REAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='업태'			ID=REAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='종목'			ID=REAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText=''		SumBgColor='#C3D0DB'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr> -->
			</table>			
		</td> 
	</tr> 
</table> 

		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - DataSet 1
------------------------------------------------------------------------------>
<!--
<comment id="__NSID__"><object id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data1>
	<param name=BindInfo		value='  
		<C>Col=VEND_ID			Ctrl=gcem_vendid				Param=text</C>
		<C>Col=VEND_NM			Ctrl=gcem_vendnm				Param=text</C>
		<C>Col=VD_DIRECT	  Ctrl=gcem_vddirect			Param=text</C>
		<C>Col=ADDRESS1		  Ctrl=gcem_addrs					Param=text</C>
		<C>Col=BSNS_CND		  Ctrl=gcem_bsnscnd				Param=text</C>
		<C>Col=BSNS_KND		  Ctrl=gcem_bsnsknd				Param=text</C>-->
		<!--C>Col=WRDT				  Ctrl=gcem_wrdt				  Param=text</C-->
<!--		<C>Col=TAXTERMFR	  Ctrl=gcem_taxtermfr			Param=text</C>
		<C>Col=TAXTERMTO	  Ctrl=gcem_taxtermto			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
-->
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - DataSet 2
------------------------------------------------------------------------------>
<!--
<comment id="__NSID__"><object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data2>
	<param name=BindInfo		value='  
		<C>Col=B_CNT01			Ctrl=gcem_b_cnt01				Param=text</C>
		<C>Col=B_TAXSUM01		Ctrl=gcem_b_taxsum01		Param=text</C>
		<C>Col=B_VATSUM01		Ctrl=gcem_b_vatsum01		Param=text</C>
		<C>Col=B_CNT02			Ctrl=gcem_b_cnt02				Param=text</C>
		<C>Col=B_TAXSUM02		Ctrl=gcem_b_taxsum02		Param=text</C>
		<C>Col=B_VATSUM02		Ctrl=gcem_b_vatsum02		Param=text</C>
		<C>Col=B_CNT03			Ctrl=gcem_b_cnt03				Param=text</C>
		<C>Col=B_TAXSUM03		Ctrl=gcem_b_taxsum03		Param=text</C>
		<C>Col=B_VATSUM03		Ctrl=gcem_b_vatsum03		Param=text</C>
		<C>Col=B_CNT04			Ctrl=gcem_b_cnt04				Param=text</C>
		<C>Col=B_TAXSUM04		Ctrl=gcem_b_taxsum04		Param=text</C>
		<C>Col=B_VATSUM04		Ctrl=gcem_b_vatsum04		Param=text</C>
		<C>Col=B_TOTCNT			Ctrl=gcem_b_totcnt			Param=text</C>
		<C>Col=B_TOTSUM			Ctrl=gcem_b_totsum			Param=text</C>
		<C>Col=B_TOTVAT			Ctrl=gcem_b_totvat			Param=text</C>

		<C>Col=A_CNT01			Ctrl=gcem_a_cnt01				Param=text</C>
		<C>Col=A_TAXSUM01		Ctrl=gcem_a_taxsum01		Param=text</C>
		<C>Col=A_VATSUM01		Ctrl=gcem_a_vatsum01		Param=text</C>
		<C>Col=A_CNT02			Ctrl=gcem_a_cnt02				Param=text</C>
		<C>Col=A_TAXSUM02		Ctrl=gcem_a_taxsum02		Param=text</C>
		<C>Col=A_VATSUM02		Ctrl=gcem_a_vatsum02		Param=text</C>
		<C>Col=A_CNT03			Ctrl=gcem_a_cnt03				Param=text</C>
		<C>Col=A_TAXSUM03		Ctrl=gcem_a_taxsum03		Param=text</C>
		<C>Col=A_VATSUM03		Ctrl=gcem_a_vatsum03		Param=text</C>
		<C>Col=A_CNT04			Ctrl=gcem_a_cnt04				Param=text</C>
		<C>Col=A_TAXSUM04		Ctrl=gcem_a_taxsum04		Param=text</C>
		<C>Col=A_VATSUM04		Ctrl=gcem_a_vatsum04		Param=text</C>
		<C>Col=A_TOTCNT			Ctrl=gcem_a_totcnt			Param=text</C>
		<C>Col=A_TOTSUM			Ctrl=gcem_a_totsum			Param=text</C>
		<C>Col=A_TOTVAT			Ctrl=gcem_a_totvat			Param=text</C>

		<C>Col=AB_TOTCNT		Ctrl=gcem_ab_totcnt			Param=text</C>
		<C>Col=AB_TOTSUM		Ctrl=gcem_ab_totsum			Param=text</C>
		<C>Col=AB_TOTVAT		Ctrl=gcem_ab_totvat			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
-->

<comment id="__NSID__"><object id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data1>
	<param name=BindInfo		value='  
    <C>Col=VEND_NM    Ctrl=gcem_vendnm			Param=text</C>
    <C>Col=VEND_ID    Ctrl=gcem_vendid			Param=text</C>
    <C>Col=VD_DIRECT  Ctrl=gcem_vddirect		Param=text</C>
    <C>Col=BSNS_CND   Ctrl=gcem_bsnscnd			Param=text</C>
    <C>Col=BSNS_KND   Ctrl=gcem_bsnsknd			Param=text</C>
    <C>Col=ADDRESS1   Ctrl=gcem_addrs			  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data2>
	<param name=BindInfo		value='  
    <C>Col=ILBAN_CNT      Ctrl=gcem_b_cnt01     Param=text</C>
    <C>Col=ILBAN_GONAMT   Ctrl=gcem_b_taxsum01  Param=text</C>
    <C>Col=ILBAN_VATAMT   Ctrl=gcem_b_vatsum01  Param=text</C>
    <C>Col=YOUNG_CNT      Ctrl=gcem_b_cnt03     Param=text</C>
    <C>Col=YOUNG_GONAMT   Ctrl=gcem_b_taxsum03  Param=text</C>
    <C>Col=YOUNG_VATAMT   Ctrl=gcem_b_vatsum03  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data3>
	<param name=BindInfo		value='  
		<C>Col=A00001			Ctrl=gcem_b_cnt04		    		Param=text</C>
		<C>Col=A00002			Ctrl=gcem_b_taxsum04				Param=text</C>
		<C>Col=A00003	    Ctrl=gcem_b_vatsum04			  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object id=gcbn_data4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data4>
	<param name=BindInfo		value='  
    <C>Col=ILBAN_CNT      Ctrl=gcem_a_cnt01       Param=text</C>
    <C>Col=ILBAN_GONAMT   Ctrl=gcem_a_taxsum01    Param=text</C>
    <C>Col=ILBAN_VATAMT   Ctrl=gcem_a_vatsum01    Param=text</C>
    <C>Col=GITA_CNT       Ctrl=gcem_a_cnt03       Param=text</C>
    <C>Col=GITA_GONAMT    Ctrl=gcem_a_taxsum03    Param=text</C>
    <C>Col=GITA_VATAMT    Ctrl=gcem_a_vatsum03    Param=text</C>
    <C>Col=BUL_CNT        Ctrl=gcem_a_cnt04       Param=text</C>
    <C>Col=BUL_GONAMT     Ctrl=gcem_a_taxsum04    Param=text</C>
    <C>Col=BUL_VATAMT     Ctrl=gcem_a_vatsum04    Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object id=gcbn_data5 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data5>
	<param name=BindInfo		value='  
		<C>Col=B00001			Ctrl=gcem_a_cnt02				  Param=text</C>
		<C>Col=B00002			Ctrl=gcem_a_taxsum02			Param=text</C>
		<C>Col=B00003	    Ctrl=gcem_a_vatsum02 			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="false">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
