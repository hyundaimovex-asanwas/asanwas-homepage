<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 자금신청서
+ 프로그램 ID	:  a300060.jsp
+ 기 능 정 의	:  현업이 필요한 자금을 신청하는 화면이다.  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2016.12.07
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
<title>자금신청서</title>

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

	gcem_appdate.text = gs_date;
	//gcem_appdate.text = "20161001";
	//gcem_reqdate.text = gs_date;
	gcem_taxdat.text = gs_date;
	
	gcds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_taxknd.Reset();

	gclx_fdcode.bindcolval = gs_fdcode;
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	if(e=="0"){  //데이터 셋만....
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_s1?v_str1=999"
																			   +"&v_str2=99991231"
																			   +"&v_str3=99991231"
																			   +"&v_str4=6070001";
		 gcds_data01.Reset();	 
	}else{
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_s1?v_str1="+gclx_fdcode.bindcolval
		  																       +"&v_str2="+gcem_appdate.text
																			   +"&v_str3="+gcem_reqdate.text
																			   +"&v_str4="+gcem_appempno.text;	
         gcds_data01.Reset();
	}
    gcds_taxmst.ClearAll();
}

<%
/******************************************************************************************
	Description : 저장
******************************************************************************************/
%>
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_data01.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
			gctr_data.KeyValue   = "Account.a300060_t1(I:USER=gcds_data01)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data01.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}

<%
/******************************************************************************************
	Description : 저장 체크
******************************************************************************************/
%>
function ln_Chk_Save(){
	
	for(var i=1;i<=gcds_data01.countrow;i++){
		//기 발행 체크 
		//매입처리가 존재하는데, SYSSTAUS <> 0  아니면 체크
		if(gcds_data01.namevalue(i,"TAXNBR")!=""&& gcds_data01.SysStatus(i)!=0){
			alert("이미 세금계산서가 발행되었습니다." +i+" 행의 데이터 수정이 불가합니다.");
			return false;
		}
		
		//신청전표가 존재하는데, SYSSTAUS <> 0  아니면 체크
		if(gcds_data01.namevalue(i,"APPFSDAT")!=""&&gcds_data01.SysStatus(i)!=0){
			alert("이미 신청전표가 발행되었습니다." +i+" 행의 데이터 수정이 불가합니다.");
			return false;
		}
		
		//필수항목 체크
		//신청일자
		if(gcds_data01.namevalue(i,"APPDATE")==""){
			alert(i+"번째 줄의 신청일자가 필요합니다.");
			return false;
		}
		
		//지급정보
		if(gcds_data01.namevalue(i,"PAYKND")==""){ 
			alert(i+"번째 줄의 지급종류가  필요합니다.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"PAYKND")=="1"){ //수시지급	
			if(gcds_data01.namevalue(i,"REQDATE")!=""){
				alert(i+"번째 줄의 지급요청일은 입력불가 입니다.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="2"){ //고정지급
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"번째 줄의 고정지급의 지급요청일은 필수항목 입니다.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="3"){ //자동지급
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"번째 줄의 자동출금의 지급요청일은 필수항목 입니다.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="4"){ //지로납부
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"번째 줄의 지로납부의 지급요청일은 필수항목 입니다.");
				return false;
			}
		}
		
		
		//지급기준
		if(gcds_data01.namevalue(i,"PAYGB")==""){
			alert(i+"번째 줄의 지급기준이 필요합니다.");
			return false;
		}
		
		
		//거래처
		if(gcds_data01.namevalue(i,"VENDCD")==""){
			alert(i+"번째 줄의 거래처코드가 필요합니다.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"VENDNM")==""){
			alert(i+"번째 줄의 거래처명이 필요합니다.");
			return false;
		}
		
		
		//예금인데 계좌번호가 없는 경우는 체크함.
		if(gcds_data01.namevalue(i,"PAYGB")=="1"||gcds_data01.namevalue(i,"PAYGB")=="3"){ //예금일경우만 계좌번호 필수 체크 
			if(gcds_data01.namevalue(i,"PAYACCTNO")==""){
				alert(i+"번째 줄의 계좌번호가 필요합니다.");
				return false;
			}
		}
		
		
		//적요
		if(gcds_data01.namevalue(i,"REMARK")==""){
			alert(i+"번째 줄의 적요가 필요합니다.");
			return false;
		}
		
		//공급가액
		if(gcds_data01.namevalue(i,"SUPAMT")==0){
			alert(i+"번째 줄의 공급가액이 필요합니다.");
			return false;
		}
		
		
		
		//지급기준 외화
		if(gcds_data01.namevalue(i,"PAYGB")=="3"||gcds_data01.namevalue(i,"PAYGB")=="4"){
			//통화명
			if(gcds_data01.namevalue(i,"CURUNIT")==""){
				alert(i+"번째 줄의 통화명이 필요합니다.");
				return false;
			}
			//외화
			if(gcds_data01.namevalue(i,"FOUTAMT")==""||gcds_data01.namevalue(i,"FOUTAMT")=="0"){
				alert(i+"번째 줄의 외화가 필요합니다.");
				return false;
			}
			//환율
			if(gcds_data01.namevalue(i,"EXRATE")==""||gcds_data01.namevalue(i,"EXRATE")=="0"){
				alert(i+"번째 줄의 환율이 필요합니다.");
				return false;
			}
		}
		
		//계정코드
		if(gcds_data01.namevalue(i,"ATCODE")==""){
			alert(i+"번째 줄의 계정코드가 필요합니다.");
			return false;
		}
		
		//계정코드명
		if(gcds_data01.namevalue(i,"ATKORNAM")==""){
			alert(i+"번째 줄의 계정명이 필요합니다.");
			return false;
		}
		
		//부가세액 매입처리 .. 
		if(gcds_data01.namevalue(i,"SUPVATAMT")>0 && (gcds_data01.namevalue(i,"PURGB")==""||gcds_data01.namevalue(i,"PURGB")=="F") ){
			alert(i+"번째 줄의 부가세액 또는 매입처리를 확인하십시요.");
			return false;
		}
	}
	return true;
}

<%
/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
%>
function ln_Delete(){
	
	if(!ln_Chk_Delete(gcds_data01.rowposition))return;

	if (confirm("삭제 하시겠습니까?")){	
		gcds_data01.deleterow(gcds_data01.rowposition);
		gctr_data.KeyValue   = "Account.a300060_t1(I:USER=gcds_data01)";
		gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_t1?";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		ln_Query();			
	}	
}



function ln_Chk_Delete(srow){
	//세금계산서 체크
	//전표체크
	//미지급체크
	if(gcds_data01.namevalue(srow,"TAXNBR")!=""){
		alert(srow+"번째 줄의 계산서번호가 존재합니다. 삭제 불가합니다.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"APPFSDAT")!=""){
		alert(srow+"번째 줄의 전표접수번호가 존재합니다. 삭제 불가합니다.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"PAYSTAT")!="1"){
		alert(srow+"번째 줄의 상태를 확인하십시요. 삭제 불가합니다.");
		return false;
	}
	
	return true ;
}


/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
		
	if(gcds_data01.countrow<1){
		ln_Query("0");
	}	
		
	gcds_data01.addrow();
	gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE") = gs_fdcode;
	
	gcds_data01.namevalue(gcds_data01.rowposition,"APPDATE") = gcem_appdate.text;
	
	if(chkbox_reqdate.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"REQDATE") = gcem_reqdate0.text;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"REQDATE") = "";
	}
	
	if(chkbox_vendcd.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD")    = txt_vendcd0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM")    = txt_vendnm0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYACCTNO") = txt_payacctno0.value;
		//alert("txt_vendid0.value::"+txt_vendid0.value);
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDID")    = txt_vendid0.value;
		//alert("VENDID::"+gcds_data01.namevalue(gcds_data01.rowposition,"VENDID") );
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYGB") = gclx_paygb.bindcolval;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD")    = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM")    = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYACCTNO") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDID")= "";
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYGB") = "";
	}
	
	if(chkbox_remark.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"REMARK") = gcem_remark0.text;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"REMARK") = "";
	}
	
	if(chkbox_atcode.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"ATCODE") = txt_atcode0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"ATKORNAM") = txt_atkornam0.value;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"ATCODE") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"ATKORNAM") = "";
	}
	
	
	gcds_data01.namevalue(gcds_data01.rowposition,"APPEMPNO") = gs_userid;
	//gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM") = "";
	gcds_data01.namevalue(gcds_data01.rowposition,"PAYSTAT") = "1"; // 미지급
	
}


/******************************************************************************
Description : 행삭제
******************************************************************************/
function ln_RowDel(){
	
	if(gcds_data01.countrow<1){
		alert("행 삭제할 행이 존재하지 않습니다.");	
	}	
	
	if(!ln_Chk_Delete(gcds_data01.rowposition))return;
	
	gcds_data01.deleterow(gcds_data01.rowposition);

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
	//gcgd_disp01.GridToExcel("일자별 예금집계 현황","",2);
}


<%
/******************************************************************************
	Description : 계산서 데이터 생성
******************************************************************************/
%>

function ln_Create(){
	
	// 선택건만 처리 
	var dbltaxsum = 0;
	var dbltaxvatsum = 0;
	var dbltaxtot=0;
	var strCnt=0;
	var strPurgbCnt=0;
	var strRemark="";
	var strVendcd="";
	var strVendnm="";
	var strVendcd_Temp="";
	var strCOCOMYN="";
	
	//체크된 건이 한 건도 없을 경우
	
	// 계산서 일자 체크 없으면 누락
	if(gcem_taxdat.text==""){
		alert("계산서일자가 누락되었습니다.확인바랍니다.");
		return false;
	}
	
	// 체크 동일 업체가 아닌 건이 2개 이상 존재하면 체크
	for(var j=1;j<=gcds_data01.countrow; j++){		
		if(gcds_data01.namevalue(j,"CHKBOX")=="T"){
			strCnt+=1;
			if(strCnt==1){
				strVendcd_Temp = gcds_data01.namevalue(j,"VENDCD");
			}else if(strCnt >1){
				if(strVendcd_Temp!=gcds_data01.namevalue(j,"VENDCD")){
					alert("동일 거래처만 매입생성 가능합니다.");
					return false;
				}
			}
		}
	}
	
	if(strCnt==0) {
		alert("자금신청내역을 선택하십시요.");
		return false; 
	}
	
	
	// 부서체크 
	if(gdeptcd==""){
		alert("부서코드를 확인하십시요.");
		return false;
	}
	
	// EMPNO 체크
	if(gusrid==""){
		alert("처리자 사번을 확인하십시요.");
		return false;
	}
	
	ln_Appno_SetDataHeader();
	strCnt=0;
	for(var i=1; i<=gcds_data01.countrow; i++){		
		if(gcds_data01.namevalue(i,"CHKBOX")=="T"){
			strCnt+=1;
			
			if(strCnt==1){
				strVendcd = gcds_data01.namevalue(i,"VENDCD");
				strRemark = gcds_data01.namevalue(i,"REMARK");
				strCOCOMYN = gcds_data01.namevalue(i,"COCOMYN");
			}
			
			//매입처리 체크건 
			if(gcds_data01.namevalue(i,"PURGB")=="T"){	
				strPurgbCnt+=1;
				gcds_appno.addrow();
				gcds_appno.namevalue(gcds_appno.rowposition,"APPNO")=gcds_data01.namevalue(i,"APPNO");  
				gcds_appno.namevalue(gcds_appno.rowposition,"UPDT")=gs_date;
				gcds_appno.namevalue(gcds_appno.rowposition,"UPID")=gs_userid;
				
				dbltaxsum +=gcds_data01.namevalue(i,"SUPAMT");
				dbltaxvatsum +=gcds_data01.namevalue(i,"SUPVATAMT") ;
				dbltaxtot = dbltaxtot+dbltaxsum+dbltaxvatsum;
			}
		}
	}
	
	if(strPurgbCnt==0){
		alert("매입처리 건이 존재하지 않습니다. 확인바랍니다.");
		return false;
	}
	
	ln_Taxmst_SetDataHeader();
	ln_Taxdtl_SetDataHeader();
	
	gcds_taxmst.Addrow();
	
	var row = 0;
	row = gcds_taxmst.rowposition;
	var strdat = gcem_taxdat.text; 
	var strtaxkidiv ="";

	if (strdat.substring(4,6) >='01' && strdat.substring(4,6) <='03') {
		strtaxkidiv="1";	//기수[1]
	}else if(strdat.substring(4,6) >='04' && strdat.substring(4,6) <='06') {
		strtaxkidiv="2";	//기수[2]
	}else if(strdat.substring(4,6) >='07' && strdat.substring(4,6) <='09') {
		strtaxkidiv="3";	//기수[3]
	}else if(strdat.substring(4,6) >='10' && strdat.substring(4,6) <='12') {
		strtaxkidiv="4";	//기수[4]
	}
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCODE")="02"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"DEPTCD")=gdeptcd; //입력값
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"EMPNO")=gusrid;  //입력값 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXIODIV")="A"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXDIV")="0001"; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND");  //입력값
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"VEND_CD")=strVendcd; //입력값
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXDAT")=gcem_taxdat.text;  //입력값
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXSUM")=dbltaxsum;    //입력값
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")=dbltaxvatsum; //입력값 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXTOT")=dbltaxtot;    //입력값
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK")=strRemark;     //입력값
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXCDNBR")="";  //신용카드 공백
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"ATCODE");     //입력값
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXPRTYN")="Y";  
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXCNT")="0"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"LASTPRT")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXTYPE")="N"; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"FSDAT");     //전표생성시 업데이트 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"FSNBR");     //전표생성시 업데이트
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKIDIV")=strtaxkidiv;  //입력값 (계산서일자로 계산) 1,2,3,4
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"FDCODE")=gclx_fdcode.bindcolval;     
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WORKTYPE")="A"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REPORT")=""; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRDT"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRID"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPDT"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPID"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SSDAT"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SSNBR"); 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SEQ")=0; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"CONVERSATION_ID")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SUPBUY_TYPE")=""; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"DIRECTION"); 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"GUBUN"); //입력값
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"AMEND_CODE")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"AMEND_REMARK")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"EXTCHK")="0"; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK2")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK3")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"S_BIZPLACE")=""; 
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"B_BIZPLACE")="0001"; 
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COSTCD"); //입력값
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCOMYN")=strCOCOMYN; 
	
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRDT")=gs_date ;
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"WRID")=gs_userid ;
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPDT")=gs_date ;
	gcds_taxmst.namevalue(gcds_taxmst.rowposition,"UPID")=gs_userid ;
	
	gcds_taxdtl.Addrow();
	
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSEQ")="001";
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")=strRemark;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")=dbltaxsum;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")=dbltaxvatsum;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRID")=gs_userid;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPID")=gs_userid;	
}

<%
/******************************************************************************
	Description : 계산서 데이터 저장  && 계산서 번호 업데이트
******************************************************************************/
%>

function ln_Save_Tax(){
	var strParam="";
	//서울 A-매입, B-매출  , 개성 C-매입, D-매출 , 금강산 E-매입, F-매출
	if(gclx_fdcode.bindcolval =="02"){        // 서울 
		strParam ="A";
	}else if(gclx_fdcode.bindcolval =="03"){ //금강산
		strParam ="E";
	}else if(gclx_fdcode.bindcolval =="04"){ //개성 
		strParam ="C";
	}else{
		alert("지점을 확인하세요.");
	} 
	strParam = strParam+gcem_taxdat.text.substring(0,6); //구분값+년월:
		
	if(!ln_Chk_Tax())return;
	if (gcds_taxmst.IsUpdated) {	
		if (confirm("매입[세금]정보를 저장 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300060_t2";
			gctr_data.KeyValue = "Account.a300060_t2(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,I:USER3=gcds_appno)";	
			gctr_data.Parameters ="v_str1="+strParam;
			//prompt('',gcds_taxmst.text);
			//prompt('',gcds_taxdtl.text);
			gctr_data.post();
		}	
	}
}

<%
/******************************************************************************
Description : 필수항목 체크 
******************************************************************************/
%>
function ln_Chk_Tax(){

	 if (fn_trim(gs_date)=="")   { alert("세션이 존재하지 않습니다. 확인하십시요.");  return false; }
	 if (fn_trim(gs_userid)=="") { alert("처리자가 존재하지 않습니다. 확인하십시요.");  return false; }
	 
	 
	 //과세구분 체크 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")==""){
		 alert("과세구분은 필수항목입니다.");
		 return false;
	 }
	 
	 //품목정보 체크 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REMARK")==""){
		 alert("품목정보는 필수항목입니다.");
		 return false;
	 }
	 
	 //상대계정 체크 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"ATCODE")==""){
		 alert("상대계정 필수항목입니다.");
		 return false;
	 }
	 
	 //원가코드 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COSTCD")==""){
		 alert("원가코드는 필수항목입니다.");
		 return false;
	 }
	
	 //구분 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"GUBUN")==""){
		 alert("전자발행구분은 필수항목입니다.");
		 return false;
	 }
	  
	 //과세일경우 
	 if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="1"){ 
		//0이면 안됨.
	 	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")==0){
	 		alert("과세구분과 부가세액이 맞지 않습니다.확인 바랍니다.");
	 		return false;
	 	}	
	 }else if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="2"||gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="3"){ //영세 면세일 경우 부가세액 체크 
		//0이 아니면 안됨.
	 	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")!=0){
	 		alert("과세구분과 부가세액이 맞지 않습니다.확인 바랍니다2.");
	 		return false;
	 	}	
	 }
	 
    //과세구분이 신용카드 일 경우 여기서는 없음.  
	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")=="8"){
		alert("과세구분 확인 바랍니다.");
		return false;
	}

    //면세업체인데, 과세구분이 면세가 아니면 체크.
    if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCOMYN")=="M"){    	
    	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKND")!="3"){
    		alert("면세업체는 과세구분이 [면세]만 가능합니다.");
    		return false;
    	}
    }
	 
    //간이과세자일 경우 부가세액 0원  ( 꼭 체크 )
    if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"COCOMYN")=="T" ){   
    	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT")!=0){
    		alert("간이과세 업체입니다. 부가세액을 확인 하십시요.");
    		return false;
    	}
    }
    
	return true;
}



<%
/******************************************************************************
	Description : 계산서 데이터 생성 취소 
******************************************************************************/
%>

function ln_Cancel_Tax(){

	gcds_taxmst.undoAll();
}



<%
/******************************************************************************
Description : 원가 / 예산부서 팝업
******************************************************************************/
%>
function ln_Popup_Costbgt(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gcds_data01.namevalue(row,"COSTGB")=="1"){         //원가
		
		arrParam[0] ="0030";
		arrParam[1] = "";
		arrParam[2]="";
		arrParam[3]="";
		arrParam[4]="02";
		
		
		strURL = "./commdtil_cost_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"COSTBGT")   = arrResult[0];  // 코드 
			gcds_data01.namevalue(row,"COSTBGTNM") = arrResult[1];  // 원가명
		}else{
			gcds_data01.namevalue(row,"COSTBGT")   = "";
			gcds_data01.namevalue(row,"COSTBGTNM") = "";
		}
		
	}else if(gcds_data01.namevalue(row,"COSTGB")=="2"){  //예산
		
		arrParam[0] ="0003";
		arrParam[1] = "";
		arrParam[2]="";
		arrParam[3]="";

		
		//strURL = "./commdtil_popup2.jsp";
		strURL = "./commdtil_popup_ifrm.jsp";
		
	    strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"COSTBGT")   = arrResult[0];  // 코드 
			gcds_data01.namevalue(row,"COSTBGTNM") = arrResult[1];  // 예산부서명
		}else{
			gcds_data01.namevalue(row,"COSTBGT")   = "";
			gcds_data01.namevalue(row,"COSTBGTNM") = "";
		}
		
	}
}



<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>
function ln_Popup_Atcode0(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='';
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		txt_atcode0.value   = arrResult[0];  // 코드 
		txt_atkornam0.value = arrResult[1];  // 거래처명
	}else{
		txt_atcode0.value   = "";  // 코드 
		txt_atkornam0.value = "";  // 거래처명
	}
}

<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>
function ln_Popup_Atcode(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='';
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_data01.namevalue(row,"ATCODE")   = arrResult[0];  // 코드 
		gcds_data01.namevalue(row,"ATKORNAM") = arrResult[1];  // 거래처명
	}else{
		gcds_data01.namevalue(row,"ATCODE")   = "";
		gcds_data01.namevalue(row,"ATKORNAM") = "";
	}
}

<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>
function ln_Popup_Atcode2(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	arrParam[1]='';
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_taxmst.namevalue(row,"ATCODE")   = arrResult[0];  // 코드 
		//gcds_taxmst.namevalue(row,"ATKORNAM") = arrResult[1];  // 거래처명
	}else{
		gcds_taxmst.namevalue(row,"ATCODE")   = "";
		//gcds_taxmst.namevalue(row,"ATKORNAM") = "";
	}
}


<%
/******************************************************************************
Description : 원가 팝업
******************************************************************************/
%>
function ln_Popup_Costcd2(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
		
	arrParam[0] ="0030";
	arrParam[1] = "";
	arrParam[2]="";
	arrParam[3]="";
	arrParam[4]="02";
	
	strURL = "./commdtil_cost_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_taxmst.namevalue(row,"COSTCD") = arrResult[0];  // 코드 
		//gcds_taxmst.namevalue(row,"COSTNM") = arrResult[1];  // 원가명
	}else{
		gcds_taxmst.namevalue(row,"COSTCD") = "";
		//gcds_taxmst.namevalue(row,"COSTNM") = "";
	}
}

<%
/******************************************************************************
Description : 거래처 계좌 팝업
******************************************************************************/
%>
function ln_Popup_Payacctno(row){
	
	if(gcds_data01.namevalue(row,"PAYGB")==""){
		alert(row+"번째 줄의 지급기준이 필요합니다.");
		return false;
	}
	
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//arrParam[0]=gcds_data01.namevalue(row,"VENDNM");
	//arrParam[1]='B';
	
	if(gcds_data01.namevalue(row,"PAYGB")=="1"||gcds_data01.namevalue(row,"PAYGB")=="3"){ //예금
	
		strURL = "./a300060_popup.jsp";
	    strPos = "dialogWidth:480px;dialogHeight:450px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"VENDCD")     = arrResult[0];  // 코드 
			gcds_data01.namevalue(row,"VENDNM")     = arrResult[1];  // 거래처명
			gcds_data01.namevalue(row,"PAYACCTNO")  = arrResult[2];  // 계좌
			gcds_data01.namevalue(row,"VENDID")     = arrResult[3];  // 사업자번호
		}else{
			gcds_data01.namevalue(row,"VENDCD")     = "";  // 코드 
			gcds_data01.namevalue(row,"VENDNM")     = "";  // 거래처명
			gcds_data01.namevalue(row,"PAYACCTNO")  = "";  // 계좌
			gcds_data01.namevalue(row,"VENDID")     = "";  // 사업자번호
		}
		
	}else if(gcds_data01.namevalue(row,"PAYGB")=="2"||gcds_data01.namevalue(row,"PAYGB")=="4"){ //현금
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"VENDCD") = arrResult[0];
			gcds_data01.namevalue(row,"VENDNM") = arrResult[1];
			gcds_data01.namevalue(row,"PAYACCTNO") = "";
			gcds_data01.namevalue(row,"VENDID")    = arrResult[5];  // 사업자번호
		} else {
			gcds_data01.namevalue(row,"VENDCD")="";
			gcds_data01.namevalue(row,"VENDNM")="";
			gcds_data01.namevalue(row,"PAYACCTNO")  = "";
			gcds_data01.namevalue(row,"VENDID")     = "";  // 사업자번호
		}	
	}
}


<%
/******************************************************************************
Description : 거래처 계좌 팝업 
******************************************************************************/
%>
function ln_Popup_Payacctno_0(){
	
	if(gclx_paygb.bindcolval==""){
		alert("지급기준을 선택하십시요.");
		return false;
	}
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gclx_paygb.bindcolval=="1"||gclx_paygb.bindcolval=="3"){//예금일 경우 계좌정보
	
		strURL = "./a300060_popup.jsp";
	    strPos = "dialogWidth:480px;dialogHeight:450px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			txt_vendcd0.value    = arrResult[0];  // 코드 
			txt_vendnm0.value    = arrResult[1];  // 거래처명
			txt_payacctno0.value = arrResult[2];  // 계좌
			txt_vendid0.value    = arrResult[3];  // 사업자번호
		}else{
			txt_vendcd0.value    = "";  // 코드 
			txt_vendnm0.value    = "";  // 거래처명
			txt_payacctno0.value = "";  // 계좌
			txt_vendid0.value    = "";  // 사업자번호
		}
	
	}else if(gclx_paygb.bindcolval=="2"||gclx_paygb.bindcolval=="4"){//현금일경우 거래처 정보 
		
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			arrResult = result.split(";");
			txt_vendcd0.value = arrResult[0];
			txt_vendnm0.value = arrResult[1];
			txt_payacctno0.value = "";
			txt_vendid0.value    = arrResult[5]; 
		} else {
			txt_vendcd0.value="";
			txt_vendnm0.value="";
			txt_payacctno0.value = "";
			txt_vendid0.value    = ""; 
		}	
	}
}

<%
/******************************************************************************
Description : 찾기 - 작성자 
******************************************************************************/
%>
function ln_Popup_Appempno(){

	if(gusrid=="6070001"){
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		strURL = "./empno_popup.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_appempno.text    = arrParam[1];
			gcem_appempnm.text    = arrParam[0];
		}else{
			gcem_appempno.text="";
			gcem_appempnm.text="";
		}
	}
}


<%
/******************************************************************************
Description : 찾기 - 통화 
******************************************************************************/
%>
function ln_Popup_Curunit(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="1043";
	arrParam[1]="";
	arrParam[2]="";
	
	strURL = "./commdtil_popup_ifrm.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	
	if(result != null) {
		arrResult = result.split(";"); 
		gcds_data01.namevalue(row,"CURUNITCD")  = arrResult[0];  // 통화명코드
		gcds_data01.namevalue(row,"CURUNIT")    = arrResult[1];  // 통화명
	}else{
		gcds_data01.namevalue(row,"CURUNITCD")  = ""; 
		gcds_data01.namevalue(row,"CURUNIT")    = "";
		
	}
}

<%
/******************************************************************************
Description : 거래처 초기화
******************************************************************************/
%>
function fnSelCostCleanup_0(){
	txt_vendcd0.value="";
	txt_vendnm0.value="";
	txt_payacctno0.value="";
	txt_vendid0.value="";
	gclx_paygb.bindcolval="";
}

<%
/******************************************************************************
Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>
function ln_Taxmst_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,"
        	   + "TAXDIV:STRING,TAXKND:STRING,VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,"
			   + "TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,"
			   + "TAXPRTYN:STRING,TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,"
			   + "FSNBR:STRING,TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,"
			   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING,"
			   + "SEQ:DECIMAL,CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,"
			   + "GUBUN:STRING,AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,"
			   + "REMARK3:STRING,S_BIZPLACE:STRING,B_BIZPLACE:STRING,COSTCD:STRING,COCOMYN:STRING,EBILLGB:STRING";
	gcds_taxmst.SetDataHeader(s_tmp1);
}

<%
/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>
function ln_Taxdtl_SetDataHeader(){
	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING,TAXTOT:DECIMAL";
	gcds_taxdtl.SetDataHeader(s_tmp1);
	
}

<%
/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>
function ln_Appno_SetDataHeader(){
	var s_tmp1 = "APPNO:STRING,TAXNBR:STRING,UPDT:STRING,UPID:STRING";
	gcds_appno.SetDataHeader(s_tmp1);
}


<%
/******************************************************************************
	Description : 전체선택
******************************************************************************/
%>
function ln_CheckAll(){
	
	if(chkbox_all.checked==true){
		chkbox_reqdate.checked=true;
		chkbox_vendcd.checked=true;
		chkbox_remark.checked=true;
		chkbox_atcode.checked=true;
	}else{
		chkbox_reqdate.checked=false;
		chkbox_vendcd.checked=false;
		chkbox_remark.checked=false;
		chkbox_atcode.checked=false;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--자금신청내역 -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--매입계산서 -->
<object  id=gcds_taxmst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_fdcode classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_taxknd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id=gcds_appno classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_temp01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_temp02 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
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
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	
	if(row>0){
		
		if(colid=="VENDCD"){
			ln_Popup_Payacctno(row); 
		}
		if(colid=="COSTBGT"){
			ln_Popup_Costbgt(row);
		}
		
		if(colid=="ATCODE"){
			ln_Popup_Atcode(row);
		}
		
		if(colid=="CURUNIT"){
			ln_Popup_Curunit(row);
		}
	}
</script>


<script language="javascript"  for=gcgd_disp01  event=OnClick(row,colid)>

	if(row>0){
		if(colid =="CHKBOX"){
			//계산서번호 확인
			if(gcds_data01.namevalue(row,"TAXNBR")!=""){
				alert("계산서번호가 이미 존재합니다.");

				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
			
			//접수번호 있는지 확인
			if(gcds_data01.namevalue(row,"APPFSDAT")!=""){
				alert("신청전표가  이미 존재합니다.");
				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
			
			//미지급 상태값 확인.
			if(gcds_data01.namevalue(row,"PAYSTAT")=="2"||gcds_data01.namevalue(row,"PAYSTAT")=="3"){
				alert("지급상태를 확인하십시요.");
				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
		}
	}
</script>

<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
    
	if(row>0){
		if(colid=="SUPVATAMT"){
			if(gcds_data01.namevalue(row,"SUPVATAMT")!=0){
				gcds_data01.namevalue(row,"PURGB")="T";   //매입처리 자동 체크
			}else{
				
			}
		}
	}
</script>



<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	
	if(row>0){	
		if(colid=="ATCODE"){
			ln_Popup_Atcode2(row);
		}
		
		if(colid=="COSTCD"){
			ln_Popup_Costcd2(row);
		}
	}
</script>

<script language=JavaScript for=gcds_data01 event=onColumnChanged(row,colid)>

	if(colid == "PAYKND") { //지급종류
		if(gcds_data01.namevalue(row,colid)=="1"){ //수시지급
			gcds_data01.namevalue(row,"REQDATE")="";
		}
	}else if(colid == "PAYGB") { // 지급기준
		if(gcds_data01.namevalue(row,colid)=="1"||gcds_data01.namevalue(row,colid)=="2"){ // 보통예금, 현금원화
			gcds_data01.namevalue(row,"CURUNIT")="";
			gcds_data01.namevalue(row,"FOUTAMT")=0;
			gcds_data01.namevalue(row,"EXRATE")=0;
		}
	}

</script>
 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("성공적으로 완료되지 못했습니다.");
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
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_delete.gif"	        style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Delete()">
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
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지점</nobr></td>
					<td class="tab24" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_fdcode classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID      value="gcds_fdcode">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>신청일</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_appdate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_appdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지급요청일</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_reqdate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>처리자</nobr></td>
					<td class="tab24" >
						<comment id="__NSID__">
						<object id=gcem_appempno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Appempno()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_appempnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Enable		  value="false">
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
			    <tr>
			        <td><font size="2" color="blue" ><strong>&nbsp;[자금신청내역]</strong></font>&nbsp;
			        	<input type=checkbox  id=chkbox_all  style="width:15px;position:relative;left:0px;top:-3px"   onclick="ln_CheckAll()">&nbsp;전체
			        </td>
				    <td align = right>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Add()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_RowDel()"></font>
					</td>
				</tr>
				
			    <tr height='25px'>
			    	<td style="position:relative;left:6px;" colspan=2>
			    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
			    			<tr>                                                                     
			                    <td align="center" class="text" width="65">지급요청일</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox  id=chkbox_reqdate  style="width:15px;position:relative;left:0px;top:-3px">&nbsp;&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_reqdate0 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate0', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
			                    </td>
			                    <td align="center" class="text" width="65">거래처정보</td>   
		                        <td bgcolor="#FFFFFF"  colspan=5 >&nbsp;
		                             <input type=checkbox  id=chkbox_vendcd    style="position:relative;left:0px;top:-3px;width:15px;">&nbsp;&nbsp;
		                             
		                             <comment id="__NSID__">
										<object  id=gclx_paygb classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:4px;top:5px;font-size:12px;width:98px;">
											<param name=CBData			        value="1^보통예금,2^현금,3^외화보통예금,4^현금(외화)">
											<param name=CBDataColumns	 		value="CODE,NAME">
											<param name=SearchColumn	     	value=NAME>
											<param name=Sort			        value=false>
											<param name=ListExprFormat       	value="NAME">								
											<param name=BindColumn		     	value="CODE">
										</object>
									 </comment><script>__ws__(__NSID__);</script>
		                             
		                             <input id="txt_vendcd0"    type=text      style= "position:relative;top:-2px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7;"  readOnly>
									 <img src="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:5px" align=center onclick="ln_Popup_Payacctno_0();">
								     <input id="txt_vendnm0"    type="text"    style= "position:relative;top:-2px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>			
		                             <input id="txt_vendid0"    type="text"    style= "position:relative;top:-2px;left:4px;width:100px; height:20px;" class="txtbox"  maxlength="36" " readOnly>
		                             <input id="txt_payacctno0" type="text"    style= "position:relative;top:-2px;left:4px;width:130px; height:20px;" class="txtbox"  maxlength="36" " readOnly>
		                             <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="값 지우기">
		                         </td>
			                 </tr>
			                 <tr>   
			                    <td align="center" class="text" width="65">적요</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox  id=chkbox_remark  style="width:15px;position:relative;left:0px;top:-3px;">&nbsp;&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_remark0 classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:150px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="">
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									</object>
									</comment><script>__ws__(__NSID__);</script>   
			                    </td>
			                    <td align="center" class="text" width="65">계정정보</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox     id=chkbox_atcode     style="width:15px;position:relative;left:0px;top:-3px">&nbsp;&nbsp;
		                            <input id="txt_atcode0"    type=text        style="position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7;"  readOnly>
									<img src="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup_Atcode0();">
								    <input id="txt_atkornam0"    type="text"    style="position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>			
			                    </td>
			    			</tr>
			       		</table>
			       	</td>
			 	</tr>
				
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:345px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<param name="GTitleHeight"  value=25>
							<param name="TitleHeight"   value="25">
							<param name=RowHeight       value="20">
							<param name="UsingOneClick" value="1">
							<PARAM NAME="Format"        VALUE="  
								<FC> Name='선택'       ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </FC>
								<FC> Name='신청일자'    ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee' </FC>
								<FG> Name='지급정보'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='종류'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:수시지급,2:고정지급,3:자동출금,4:지로납부'</FC>
								<FC> Name='요청일'      ID=REQDATE	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  MASK='XXXX/XX/XX' bgcolor={Decode(PAYKND,2,'',3,'',4,'','#eeeeee')} edit={Decode(PAYKND,1,none,'')} </FC>    
								<FC> Name='지급기준'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:보통예금,2:현금,3:외화보통예금,4:현금(외화)'</FC>
								</FG>
								<FG> Name='거래처정보'   HeadAlign=Center HeadBgColor=#B9D4DC
								<FC> Name='코드'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </FC>
								<FC> Name='등록번호'	  ID=VENDID 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</FC>
								<FC> Name='거래처명'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								<FC> Name='계좌번호'    ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								</FG>
								<C> Name='적요'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	SumBgColor='#C3D0DB'  </C>
								<C> Name='공급가액'    ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  SumText=@sum</C>
								<C> Name='부가세액'    ID=SUPVATAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  SumText=@sum</C>
								
								<G> Name='외화정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='통화명'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} EditStyle=Popup</</C>
								<C> Name='외화'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} SumText=@sum</C>
								<C> Name='환율'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} </C>
								</G>
								
								<G> Name='계정정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	SumBgColor='#C3D0DB'  EditStyle=Popup</C>
								<C> Name='계정명'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								</G>
								<G> Name='원가/예산정보' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='구분'	     ID=COSTGB  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center 	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:원가,2:예산'</C>
								<C> Name='코드'	     ID=COSTBGT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='원가/예산명'	 ID=COSTBGTNM  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								</G>
								
								<G> Name='매입정보'    HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='매입처리'    ID=PURGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=53    	align=center	SumBgColor='#C3D0DB'  EditStyle=CheckBox  </C>
								<C> Name='계산서번호'   ID=TAXNBR 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none MASK='XXXXXXX-XXXX' bgcolor='#eeeeee'</C>
								</G>
								<G> Name='신청전표정보'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='접수일자'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='접수번호'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
							    </G>
								<C> Name='지급상태'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:미지급,2:접수,3:지급' bgcolor='#eeeeee'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				
				<tr><td colspan=2>&nbsp;</td></tr>
				<tr>
					<td><font size="2" color="blue" ><strong>&nbsp;[매입계산서 등록]</strong></font>&nbsp;
					    <font size="2" color="black" >&nbsp;* 계산서일자</font>			
						<comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">
					</td>
					 <td align = right>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_create.gif"	 style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Create()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_save.gif"	     style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Save_Tax()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"	 style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Cancel_Tax()"></font>
					</td>
				</tr>
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:100px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_taxmst">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1"> 
							<PARAM NAME="Format"        VALUE="  
								<C> Name='계산서일자'  ID=TAXDAT 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	    align=center  	SumBgColor='#C3D0DB'  edit=none mask='XXXX/XX/XX'</C>
								<C> Name='거래처'	    ID=VEND_CD	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   	align=left	    SumBgColor='#C3D0DB'  edit=none </C>    
								<C> Name='과세구분'	ID=TAXKND 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80   	align=center 	SumBgColor='#C3D0DB'  EditStyle=Lookup	Data='gcds_taxknd:CDCODE:CDNAM'</C>
								<C> Name='품목정보'	ID=REMARK   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=200    	align=left   	SumBgColor='#C3D0DB'  </C>
								<C> Name='공급가액'   ID=TAXSUM 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right	    SumBgColor='#C3D0DB'  edit=none  SumText=@sum</C>
								<C> Name='부가세액'	ID=TAXVATAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none  SumText=@sum</C>
							    <C> Name='상대계정'	ID=ATCODE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
							    <C> Name='원가코드'	ID=COSTCD 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
							    <C> Name='구분'	    ID=GUBUN 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:전자발행,2:수기발행' </C>
							    <C> Name='eBill구분'	ID=EBILLGB 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:스마트빌,2:트러스빌,9:기타' </C> 
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
						<font size="2" color="black" >&nbsp; 1.[자금신청내역]에서 매입처리 체크 후 매입생성 가능합니다.</font>
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

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
