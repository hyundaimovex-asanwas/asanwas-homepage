<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  예금관리 - 예금현황
+ 프로그램 ID	:  a400030.jsp
+ 기 능 정 의	:  은행 예금 파일을 업로드 함.  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2016.10.25
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>예금업로드</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드

var gs_frdt="";
var gs_todt="";
var gs_hf_gb="";  //반기구분
var gs_hf_seq=""; //반기내순번


<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

<%
/******************************************************************************
	Description : 선조회
******************************************************************************/
%>
function ln_Before(){
	gcrd_gubun.codevalue="1";
	gcem_enddat.text = gs_date;
	gcem_enddat.text = "20161001";
}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	if(gcem_enddat.text==""){
		alert("거래일자를 입력하십시요.");
		return false;
	}
		
	if(gcrd_gubun.codevalue=="1"){	//저장 전 
		
		//예금 
	    gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s1?v_str1="+gcem_acctcd.text
	    		                                                              +"&v_str2="+gcem_acctno.text
	    		                                                              +"&v_str3="+gcem_enddat.text
	    		                                                              +"&v_str4="+txt_remark.value;	
	    gcds_data01.Reset();
	    
	    //현금
	    gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s2?v_str1="+gcem_acctcd.text
																			  +"&v_str2="+gcem_acctno.text
																			  +"&v_str3="+gcem_enddat.text
	    		                                                              +"&v_str4="+txt_remark.value;	
		gcds_data02.Reset();
		
		//신탁
		gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s3?v_str1="+gcem_acctcd.text
																		      +"&v_str2="+gcem_acctno.text
																		      +"&v_str3="+gcem_enddat.text
	    		                                                              +"&v_str4="+txt_remark.value;	
		gcds_data03.Reset();
	    
		//담보
		gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s4?v_str1="+gcem_acctcd.text
																			  +"&v_str2="+gcem_acctno.text
																			  +"&v_str3="+gcem_enddat.text
	    		                                                              +"&v_str4="+txt_remark.value;	
		gcds_data04.Reset();
	}else if(gcrd_gubun.codevalue=="2"){ //저장 후 
		
		//예금 
	    gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s11?v_str1="+gcem_acctcd.text
	    		                                                               +"&v_str2="+gcem_acctno.text
	    		                                                               +"&v_str3="+gcem_enddat.text
	    		                                                               +"&v_str4="+txt_remark.value;	
	    gcds_data01.Reset();
	    
	    //현금
	    gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s12?v_str1="+gcem_acctcd.text
																			   +"&v_str2="+gcem_acctno.text
																			   +"&v_str3="+gcem_enddat.text
	    		                                                               +"&v_str4="+txt_remark.value;	
		gcds_data02.Reset();
		
		//신탁
		gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s13?v_str1="+gcem_acctcd.text
																		       +"&v_str2="+gcem_acctno.text
																		       +"&v_str3="+gcem_enddat.text
	    		                                                               +"&v_str4="+txt_remark.value;	
		gcds_data03.Reset();
	    
		//담보
		gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_s14?v_str1="+gcem_acctcd.text
																			   +"&v_str2="+gcem_acctno.text
																			   +"&v_str3="+gcem_enddat.text
	    		                                                               +"&v_str4="+txt_remark.value;	
		gcds_data04.Reset();
	}	
}
<%
/******************************************************************************************
	Description : 저장
******************************************************************************************/
%>
function ln_Save(){
		
	ln_Data_Setting();	
		
	if(!ln_Chk_Save())return;
	else if (gcds_data01.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
			gctr_data.KeyValue   = "Account.a400030_t1(I:USER=gcds_data_sum)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data_sum.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}


function ln_Chk_Save(){
	
	
	return true;
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
 
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/


<%
/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
%>

function ln_Excel(){
	gcgd_disp01.GridToExcel("일자별 예금집계 현황","",2);
}

<%
/******************************************************************************
Description : 계좌정보팝업
******************************************************************************/
%>
function ln_Popup_Acctinfo(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./acctinfo_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_acctcd.text = arrResult[0];  // 계좌코드 
		gcem_acctno.text = arrResult[1];  // 계좌번호
	}else{
		gcem_acctcd.text = "";
		gcem_acctno.text = "";
	}
}


<%
/******************************************************************************
Description : 일집계 저장 데이터 설정
******************************************************************************/
%>
function ln_Data_Setting(){
	ln_SetDataHeader();
	
	//예금
	for(var i=1;i<=gcds_data01.Countrow;i++){
		if(gcds_data01.namevalue(i,"CHKBOX")=="T"){
			gcds_data_sum.addrow();
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEDATE") = gcds_data01.namevalue(i,"DEDATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTNO") = gcds_data01.namevalue(i,"ACCTNO");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTCD") = gcds_data01.namevalue(i,"ACCTCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"REMARK") = gcds_data01.namevalue(i,"REMARK");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BALAMTS") = gcds_data01.namevalue(i,"BALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"FBALAMTS") = gcds_data01.namevalue(i,"FBALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CURUNIT") = gcds_data01.namevalue(i,"CURUNIT");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTUSE") = gcds_data01.namevalue(i,"ACCTUSE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTGB") = gcds_data01.namevalue(i,"ACCTGB");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BRCHCD") = gcds_data01.namevalue(i,"BRCHCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEPOGB") = "1";
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"INRATE") = gcds_data01.namevalue(i,"INRATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CHKBOX") = gcds_data01.namevalue(i,"CHKBOX");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"WRID") = gcds_data01.namevalue(i,"WRID");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"UPID") = gcds_data01.namevalue(i,"UPID");
		}
	}

	
	for(var i=1;i<=gcds_data02.Countrow;i++){
		if(gcds_data02.namevalue(i,"CHKBOX")=="T"){
			gcds_data_sum.addrow();
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEDATE") = gcds_data02.namevalue(i,"DEDATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTNO") = gcds_data02.namevalue(i,"ACCTNO");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTCD") = gcds_data02.namevalue(i,"ACCTCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"REMARK") = gcds_data02.namevalue(i,"REMARK");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BALAMTS") = gcds_data02.namevalue(i,"BALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"FBALAMTS") = gcds_data02.namevalue(i,"FBALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CURUNIT") = gcds_data02.namevalue(i,"CURUNIT");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTUSE") = gcds_data02.namevalue(i,"ACCTUSE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTGB") = gcds_data02.namevalue(i,"ACCTGB");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BRCHCD") = gcds_data02.namevalue(i,"BRCHCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEPOGB") = "2";
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"INRATE") = gcds_data02.namevalue(i,"INRATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CHKBOX") = gcds_data02.namevalue(i,"CHKBOX");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"WRID") = gcds_data02.namevalue(i,"WRID");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"UPID") = gcds_data02.namevalue(i,"UPID");
		}
	}
	
	for(var i=1;i<=gcds_data03.Countrow;i++){
		if(gcds_data03.namevalue(i,"CHKBOX")=="T"){
			gcds_data_sum.addrow();
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEDATE") = gcds_data03.namevalue(i,"DEDATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTNO") = gcds_data03.namevalue(i,"ACCTNO");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTCD") = gcds_data03.namevalue(i,"ACCTCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"REMARK") = gcds_data03.namevalue(i,"REMARK");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BALAMTS") = gcds_data03.namevalue(i,"BALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"FBALAMTS") = gcds_data03.namevalue(i,"FBALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CURUNIT") = gcds_data03.namevalue(i,"CURUNIT");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTUSE") = gcds_data03.namevalue(i,"ACCTUSE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTGB") = gcds_data03.namevalue(i,"ACCTGB");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BRCHCD") = gcds_data03.namevalue(i,"BRCHCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEPOGB") = "3";
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"INRATE") = gcds_data03.namevalue(i,"INRATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CHKBOX") = gcds_data03.namevalue(i,"CHKBOX");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"WRID") = gcds_data03.namevalue(i,"WRID");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"UPID") = gcds_data03.namevalue(i,"UPID");
			
		}
	}
	
	
	for(var i=1;i<=gcds_data04.Countrow;i++){
		if(gcds_data04.namevalue(i,"CHKBOX")=="T"){
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEDATE") = gcds_data04.namevalue(i,"DEDATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTNO") = gcds_data04.namevalue(i,"ACCTNO");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTCD") = gcds_data04.namevalue(i,"ACCTCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"REMARK") = gcds_data04.namevalue(i,"REMARK");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BALAMTS") = gcds_data04.namevalue(i,"BALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"FBALAMTS") = gcds_data04.namevalue(i,"FBALAMTS");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CURUNIT") = gcds_data04.namevalue(i,"CURUNIT");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTUSE") = gcds_data04.namevalue(i,"ACCTUSE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"ACCTGB") = gcds_data04.namevalue(i,"ACCTGB");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"BRCHCD") = gcds_data04.namevalue(i,"BRCHCD");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"DEPOGB") = "4";
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"INRATE") = gcds_data04.namevalue(i,"INRATE");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"CHKBOX") = gcds_data04.namevalue(i,"CHKBOX");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"WRID") = gcds_data04.namevalue(i,"WRID");
			gcds_data_sum.namevalue(gcds_data_sum.rowposition,"UPID") = gcds_data04.namevalue(i,"UPID");
		}
	}
}

<%
/******************************************************************************
Description : 데이터셋 헤드 설정
******************************************************************************/
%>
function ln_SetDataHeader(){
    var s_temp="";

	if (gcds_data_sum.countrow<1){
	    s_temp="";
		s_temp = "DEDATE:STRING,ACCTNO:STRING,ACCTCD:STRING,REMARK:STRING,BALAMTS:DECIMAL,"
			   + "FBALAMTS:DECIMAL,CURUNIT:STRING,ACCTUSE:STRING,ACCTGB:STRING,BRCHCD:STRING,"
			   + "DEPOGB:STRING,INRATE:DECIMAL,CHKBOX:STRING,WRID:STRING,UPID:STRING";
		gcds_data_sum.SetDataHeader(s_temp);
	}
}

<%
/******************************************************************************
Description : 데이터셋 헤드 설정
******************************************************************************/
%>
function ln_SetDataHeader2(){
    var s_temp="";

	if (gcds_closeyn.countrow<1){
	    s_temp="";
		s_temp = "DEDATE:STRING,WRID:STRING";
		gcds_closeyn.SetDataHeader(s_temp);
	}
}




<%
/******************************************************************************
Description : 출력
******************************************************************************/
%>
function ln_Print(){
	
	if(gcrd_gubun.codevalue!="2"){
		alert("저장 후 데이터만 출력 가능합니다.");
		return false;
	}
	
	gcrp_print.preview();
}


<%
/******************************************************************************
Description : 마감
******************************************************************************/
%>
function ln_Finish(){
	
	if(gcrd_gubun.codevalue!="2"){
		alert("저장 후 데이터만 마감이 가능합니다.");
		return false;
	}
	
	ln_SetDataHeader2();
		
	if(gcds_data01.namevalue(1,"DEDATE")==gcem_enddat.text){
		gcds_closeyn.addrow();
		gcds_closeyn.namevalue(gcds_closeyn.rowposition,"DEDATE")=gcds_data01.namevalue(1,"DEDATE");
	}else{
		alert("거래일자를 확인하십시요.");
		return false;
	}
	
	if (gcds_closeyn.IsUpdated) {
		if (confirm("마감 하시겠습니까?")){	
			gctr_data.KeyValue   = "Account.a400030_t2(I:USER=gcds_closeyn)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			prompt('',gcds_closeyn.text);
			gctr_data.post();
			ln_Query();			
		}else{
			gcds_closeyn.undoAll();
		}	
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--예금현황 -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--현금 -->
<object  id=gcds_data02 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--내포빌앤더스 신탁예치금 -->
<object  id=gcds_data03 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--담보제공 -->
<object  id=gcds_data04 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<!--일집계 -->
<object  id=gcds_data_sum classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_closeyn classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_print classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	if(gcrd_gubun.codevalue=="1"){ //저장전
		for(var i=1; i<=row; i++){
			if(gcds_data01.namevalue(i,"CLOSEYN")!="Y"){//진행
				if(gcds_data01.namevalue(i,"BALAMTS")>950000){
					gcds_data01.namevalue(i,"CHKBOX")="T";
				}else{
					gcds_data01.namevalue(i,"CHKBOX")="F";
				}	
			}
		}
	}
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	if(gcrd_gubun.codevalue=="1"){ //저장전
		for(var i=1; i<=row; i++){
			if(gcds_data02.namevalue(i,"CLOSEYN")!="Y"){//진행
				if(gcds_data02.namevalue(i,"BALAMTS")>950000){
					gcds_data02.namevalue(i,"CHKBOX")="T";
				}else{
					gcds_data02.namevalue(i,"CHKBOX")="F";
				}	
			}
		}
	}
</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
	if(gcrd_gubun.codevalue=="1"){ //저장전
		for(var i=1; i<=row; i++){
			if(gcds_data03.namevalue(i,"CLOSEYN")!="Y"){//진행
				if(gcds_data03.namevalue(i,"BALAMTS")>950000){
					gcds_data03.namevalue(i,"CHKBOX")="T";
				}else{
					gcds_data03.namevalue(i,"CHKBOX")="F";
				}	
			}
		}
	}
</script>


<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
	if(gcrd_gubun.codevalue=="1"){ //저장전
		for(var i=1; i<=row; i++){
			if(gcds_data04.namevalue(i,"CLOSEYN")!="Y"){//진행
				if(gcds_data04.namevalue(i,"BALAMTS")>950000){
					gcds_data04.namevalue(i,"CHKBOX")="T";
				}else{
					gcds_data04.namevalue(i,"CHKBOX")="F";
				}	
			}
		}
	}
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("데이터 생성이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("데이터 생성이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_finish.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Finish()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Print()">
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:0 solid #708090'>
				<tr>
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>구분</nobr></td>
					<td class="tab24" style="width:300px">
						<comment id="__NSID__">
							<object id=gcrd_gubun classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:24; width:120">
								<param name=Cols	    value="2">
								<param name=Format	value="1^저장전 ,2^저장후">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>거래일자</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_enddat classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_enddat', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab27" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>계좌번호</nobr></td>
					<td class="tab28" >
						<comment id="__NSID__">
						<object id=gcem_acctcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:40px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="####">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script></nobr>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Acctinfo()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_acctno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab28" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>적요</nobr></td>
					<td class="tab28" >
						<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
			    <tr><td><font size="2" color="blue" ><strong>&nbsp;[예금현황]</strong></font></td></tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:260px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='선택'      ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </C>
								<C> Name='금융기관'   ID=BRCHNM 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구분'	    ID=ACCTGBNM	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   	align=center	SumBgColor='#C3D0DB'  edit=none SumText=@count	 </C>    
								<C> Name='원화금액'	ID=BALAMTS 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=110   	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='외화금액'	ID=FBALAMTS  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='통화'	    ID=CURUNIT 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구좌번호'	ID=ACCTNO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='이자율'	    ID=INRATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='비고'	    ID=ACCTUSE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=180    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='마감'	    ID=CLOSEYN 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='Y:마감,N:진행'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				<tr><td><font size="2" color="blue" ><strong>&nbsp;[현금]</strong></font></td></tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:120px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data02">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='선택'      ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </C>
								<C> Name='금융기관'   ID=BRCHNM 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구분'	    ID=ACCTGBNM	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   	align=center	SumBgColor='#C3D0DB'  edit=none SumText=@count	 </C>    
								<C> Name='원화금액'	ID=BALAMTS 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=110   	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='외화금액'	ID=FBALAMTS  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='통화'	    ID=CURUNIT 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구좌번호'	ID=ACCTNO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='이자율'	    ID=INRATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='비고'	    ID=ACCTUSE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=180    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
							    <C> Name='마감'	    ID=CLOSEYN 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='Y:마감,N:진행'</C> 
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				<tr><td><font size="2" color="blue" ><strong>&nbsp;[내포빌앤더스 신탁예치금]</strong></font></td></tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp03 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:80px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data03">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='선택'      ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </C>
								<C> Name='금융기관'   ID=BRCHNM 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구분'	    ID=ACCTGBNM	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   	align=center	SumBgColor='#C3D0DB'  edit=none SumText=@count	 </C>    
								<C> Name='원화금액'	ID=BALAMTS 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=110   	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='신탁사'	    ID=REMARK 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=160    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구좌번호'	ID=ACCTNO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='이자율'	    ID=INRATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='비고'	    ID=ACCTUSE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=180    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
							    <C> Name='마감'	    ID=CLOSEYN 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='Y:마감,N:진행'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				<tr><td><font size="2" color="blue" ><strong>&nbsp;[담보제공]</strong></font></td></tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp04 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:60px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data04">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='선택'      ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </C>
								<C> Name='금융기관'   ID=BRCHNM 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구분'	    ID=ACCTGBNM	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   	align=center	SumBgColor='#C3D0DB'  edit=none SumText=@count	 </C>    
								<C> Name='원화금액'	ID=BALAMTS 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=110   	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
								<C> Name='담보제공처'  ID=REMARK 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=160    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='구좌번호'	ID=ACCTNO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='이자율'	    ID=INRATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='비고'	    ID=ACCTUSE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=180    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
							    <C> Name='마감'	    ID=CLOSEYN 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='Y:마감,N:진행'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>


<comment id="__NSID__"><object id="gcrp_print" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                    VALUE="
	
	<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1_1.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID'=gcds_data01'  DetailDataID='gcds_data01' 	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=392 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=582 ,top=259 ,right=841 ,bottom=318 ,border=true ,penstyle=solid ,penwidth=3</X>
	<L> left=1638 ,top=323 ,right=1638 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1505 ,top=325 ,right=1505 ,bottom=392 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='이자율' ,left=1511 ,top=328 ,right=1632 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='예금 및 차입금 현황' ,left=24 ,top=19 ,right=1958 ,bottom=143 ,face='굴림' ,size=24 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=392 ,right=1958 ,bottom=392 </L>
	<L> left=26 ,top=323 ,right=26 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=323 ,right=1958 ,bottom=323 </L>
	<T>id='원화금액' ,left=587 ,top=328 ,right=836 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외화금액' ,left=844 ,top=328 ,right=1093 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1958 ,top=323 ,right=1958 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='비고' ,left=1643 ,top=328 ,right=1953 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구좌번호' ,left=1103 ,top=328 ,right=1500 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=365 ,top=328 ,right=579 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=32 ,top=328 ,right=355 ,bottom=389 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[단위 : 백만원]' ,left=1680 ,top=262 ,right=1955 ,bottom=318 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1098 ,top=323 ,right=1098 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='DEDATE', left=482, top=148, right=1453, bottom=206 ,mask='( XXXX.XX.XX )', face='굴림', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=360 ,top=323 ,right=360 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='※ 예금현황' ,left=32 ,top=180 ,right=347 ,bottom=251 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=323 ,right=582 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=839 ,top=323 ,right=839 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<X>left=26 ,top=259 ,right=579 ,bottom=318 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='합계' ,left=42 ,top=262 ,right=569 ,bottom=315 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BALAMTS_SUM', left=590, top=262, right=839, bottom=315, align='right', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=26 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=0 ,right=360 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=64 ,right=1958 ,bottom=64 </L>
	<L> left=1505 ,top=3 ,right=1505 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=0 ,right=1638 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='BALAMTS2', left=587, top=3, right=836, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INRATE,0,,INRATE)}', left=1511, top=3, right=1632, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTUSE', left=1643, top=3, right=1953, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTNO', left=1103, top=3, right=1500, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1098 ,top=0 ,right=1098 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=839 ,top=0 ,right=839 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='ACCTGBNM', left=365, top=3, right=579, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BRCHNM', left=32, top=3, right=355, bottom=61, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CURUNIT,\'WON\',,CURUNIT)}', left=844, top=3, right=915, bottom=61, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(FBALAMTS,0,,FBALAMTS)}', left=915, top=3, right=1093, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=69 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=26 ,top=3 ,right=26 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=69 ,right=1958 ,bottom=69 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=839 ,top=0 ,right=839 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<S>id='{Sum(BALAMTS2)}' ,left=587 ,top=5 ,right=836 ,bottom=64 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<T>id='소계' ,left=32 ,top=5 ,right=579 ,bottom=64 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1_2.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID'=gcds_data02'  DetailDataID='gcds_data02' 
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=203 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='[단위 : 백만원]' ,left=1680 ,top=74 ,right=1955 ,bottom=130 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=32 ,top=140 ,right=355 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=365 ,top=140 ,right=579 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구좌번호' ,left=1103 ,top=140 ,right=1500 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1643 ,top=140 ,right=1953 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1958 ,top=135 ,right=1958 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1098 ,top=135 ,right=1098 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='외화금액' ,left=844 ,top=140 ,right=1093 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=839 ,top=135 ,right=839 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='원화금액' ,left=587 ,top=140 ,right=836 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=135 ,right=582 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=135 ,right=1958 ,bottom=135 </L>
	<T>id='이자율' ,left=1511 ,top=140 ,right=1632 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1505 ,top=138 ,right=1505 ,bottom=204 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=135 ,right=360 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=135 ,right=1638 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='※ 현금' ,left=34 ,top=11 ,right=349 ,bottom=82 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=204 ,right=1958 ,bottom=204 </L>
	<L> left=26 ,top=135 ,right=26 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=26 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=0 ,right=360 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=64 ,right=1958 ,bottom=64 </L>
	<L> left=1638 ,top=0 ,right=1638 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(BALAMTS2,0,,BALAMTS2)}', left=587, top=3, right=836, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INRATE,0,,INRATE)}', left=1511, top=3, right=1632, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTUSE', left=1643, top=3, right=1953, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1098 ,top=0 ,right=1098 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='ACCTGBNM', left=365, top=3, right=579, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BRCHNM', left=32, top=3, right=355, bottom=61, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1505 ,top=0 ,right=1505 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=839 ,top=0 ,right=839 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(FBALAMTS,0,,FBALAMTS)}', left=915, top=3, right=1093, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(CURUNIT,\'WON\',,CURUNIT)}', left=844, top=3, right=915, bottom=61, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='소계' ,left=32 ,top=3 ,right=579 ,bottom=61 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BALAMTS2)}' ,left=587 ,top=3 ,right=836 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=839 ,top=0 ,right=839 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=66 ,right=1958 ,bottom=66 </L>
</B>

</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1_3.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID'=gcds_data03'  DetailDataID='gcds_data03' 
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=203 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='[단위 : 백만원]' ,left=1680 ,top=74 ,right=1955 ,bottom=130 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=32 ,top=140 ,right=355 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=365 ,top=140 ,right=579 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구좌번호' ,left=1103 ,top=140 ,right=1500 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1643 ,top=140 ,right=1953 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1958 ,top=135 ,right=1958 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1098 ,top=135 ,right=1098 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='신탁사' ,left=844 ,top=140 ,right=1093 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=839 ,top=135 ,right=839 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='원화금액' ,left=587 ,top=140 ,right=836 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=135 ,right=582 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=135 ,right=1958 ,bottom=135 </L>
	<L> left=26 ,top=135 ,right=26 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='이자율' ,left=1511 ,top=140 ,right=1632 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1505 ,top=138 ,right=1505 ,bottom=204 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=135 ,right=360 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=135 ,right=1638 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=204 ,right=1958 ,bottom=204 </L>
	<T>id='※ 내포빌앤더스 신탁예치금' ,left=34 ,top=11 ,right=804 ,bottom=82 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=26 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=0 ,right=360 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=64 ,right=1958 ,bottom=64 </L>
	<L> left=1505 ,top=3 ,right=1505 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=0 ,right=1638 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(BALAMTS2,0,,BALAMTS2)}', left=587, top=3, right=836, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=844, top=3, right=1093, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INRATE', left=1511, top=3, right=1632, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTUSE', left=1643, top=3, right=1953, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTNO', left=1103, top=3, right=1500, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1098 ,top=0 ,right=1098 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=839 ,top=0 ,right=839 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='ACCTGBNM', left=365, top=3, right=579, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BRCHNM', left=32, top=3, right=355, bottom=61, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='소계' ,left=32 ,top=3 ,right=579 ,bottom=61 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BALAMTS2)}' ,left=587 ,top=3 ,right=836 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=839 ,top=0 ,right=839 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=66 ,right=1958 ,bottom=66 </L>
</B>
</R>
</A>


<A>id=Area4 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1_4.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID'=gcds_data04'  DetailDataID='gcds_data04' 	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=203 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='[단위 : 백만원]' ,left=1680 ,top=74 ,right=1955 ,bottom=130 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=32 ,top=140 ,right=355 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=365 ,top=140 ,right=579 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구좌번호' ,left=1103 ,top=140 ,right=1500 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1643 ,top=140 ,right=1953 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1958 ,top=135 ,right=1958 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1098 ,top=135 ,right=1098 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='외화금액' ,left=844 ,top=140 ,right=1093 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=839 ,top=135 ,right=839 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='원화금액' ,left=587 ,top=140 ,right=836 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=582 ,top=135 ,right=582 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=135 ,right=1958 ,bottom=135 </L>
	<L> left=26 ,top=135 ,right=26 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='이자율' ,left=1511 ,top=140 ,right=1632 ,bottom=201 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1505 ,top=138 ,right=1505 ,bottom=204 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=135 ,right=360 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=135 ,right=1638 ,bottom=201 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='※ 담보제공' ,left=34 ,top=11 ,right=349 ,bottom=82 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=204 ,right=1958 ,bottom=204 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=26 ,top=0 ,right=26 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=360 ,top=0 ,right=360 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=64 ,right=1958 ,bottom=64 </L>
	<L> left=1505 ,top=3 ,right=1505 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1638 ,top=0 ,right=1638 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{decode(BALAMTS2,0,,BALAMTS2)}', left=587, top=3, right=836, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FBALAMTS,0,,FBALAMTS)}', left=844, top=3, right=1093, bottom=61, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INRATE,0,,INRATE)}', left=1511, top=3, right=1632, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTUSE', left=1643, top=3, right=1953, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTNO', left=1103, top=3, right=1500, bottom=61, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1098 ,top=0 ,right=1098 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=839 ,top=0 ,right=839 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=64 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='ACCTGBNM', left=365, top=3, right=579, bottom=61, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BRCHNM', left=32, top=3, right=355, bottom=61, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='소계' ,left=32 ,top=3 ,right=579 ,bottom=61 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BALAMTS2)}' ,left=587 ,top=3 ,right=836 ,bottom=61 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=839 ,top=0 ,right=839 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=582 ,top=0 ,right=582 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=26 ,top=66 ,right=1958 ,bottom=66 </L>
</B>

</R>
</A>

">
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
