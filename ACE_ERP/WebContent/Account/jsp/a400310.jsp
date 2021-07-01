<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  출금관리 - 지출신청
+ 프로그램 ID	:  a400310.jsp
+ 기 능 정 의	:  현업이 필요한 자금을 신청하는 화면이다.  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2017.10.25
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 

	String v_dwr_sid = request.getParameter("v_dwr_sid");	//작업일보 index
	String v_status	 = request.getParameter("v_status");	//페이지 작업 구분자 : 상태 010작성중, 011현장결재진행중, 012현장결재완료
	String v_ap_m_sid = request.getParameter("v_ap_m_sid");	//결재마스터 sid : 반려시에는 스냅샷을 찍는게 아니므로 일보 인덱스가 겹친다.
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
%>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>지출신청</title>

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
	
	ln_SetDataHeader();	    //결재선 헤더
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// 결재유형      AP005 - 공통모듈쪽 공통코드 읽어오기
	
	ds_gc_apsts_d.DataId= "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// 결재상태_D AP003 - 공통모듈쪽 공통코드 읽어오기
}

<%
/******************************************************************************
	Description : 선조회
******************************************************************************/
%>
function ln_Before(){

	//^^gcem_appdate.text = gs_date;
	gcem_appdate.text = "20171109";
	//gcem_reqdate.text = gs_date;
	//^^gcem_taxdat.text = gs_date;
	
	gcds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_taxknd.Reset();

	gclx_fdcode.bindcolval = gs_fdcode;
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
	gclx_ap_status_m.bindcolval="1";
}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	if(e=="0"){  //데이터 셋만....
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_s1?v_str1=999"
																			   +"&v_str2=99991231"
																			   +"&v_str3=99991231"
																			   +"&v_str4=6070001"
																			   +"&v_str5="
																			   +"&v_str6=";
		 gcds_data01.Reset();	 
	}else{
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_s1?v_str1="+gclx_fdcode.bindcolval
		  																       +"&v_str2="+gcem_appdate.text
																			   +"&v_str3="+gcem_reqdate.text
																			   +"&v_str4="+gcem_appempno.text
																			   +"&v_str5="
																			   +"&v_str6="+gclx_ap_status_m.bindcolval;	
         gcds_data01.Reset();
	}

	//alert("gcds_data01.rowposition::"+gcds_data01.rowposition);
	ln_Query2(gcds_data01.namevalue(gcds_data01.rowposition,"APPNO"),gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE"));
	
	//신청번호로  상세정보 재조
	ln_Query_Apline(99999);
}

<%
/******************************************************************************************
	Description : 상세정보
******************************************************************************************/
%>

function ln_Query2(strAppno,strFdcode){
	
	 gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_s2?v_str1="+strFdcode
	  																       +"&v_str2="+strAppno;
	 //prompt('',gcds_data02.DataID ); 
     gcds_data02.Reset();
	 //신청번호로  상세정보 재조회
}


<%
/******************************************************************************************
	Description : 금액 Valid Chk
******************************************************************************************/
%>

function ln_Query3(strAppno,strFdcode){
	
	 gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_s3?v_str1="+strFdcode
	  																       +"&v_str2="+strAppno;
	 //prompt('',gcds_data02.DataID ); 
     gcds_data03.Reset();
	 //신청번호로  상세정보 재조회
}

<%
/******************************************************************************************
	Description : 결재선 조회
******************************************************************************************/
%>
function ln_Query_Apline(strAp_m_sid){
	
	//신청팀 결재선 조회 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s2?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
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
			gctr_data.KeyValue   = "Account.a400310_t1(I:USER=gcds_data01)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_t1?";
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
		/*
		if(gcds_data01.namevalue(i,"TAXNBR")!=""&& gcds_data01.SysStatus(i)!=0){
			alert("이미 세금계산서가 발행되었습니다." +i+" 행의 데이터 수정이 불가합니다.");
			return false;
		}
		*/
		
		//신청전표가 존재하는데, SYSSTAUS <> 0  아니면 체크
		if(gcds_data01.namevalue(i,"APPFSDAT")!=""&&gcds_data01.SysStatus(i)!=0){
			alert("이미 신청전표가 발행되었습니다." +i+" 행의 데이터 수정이 불가합니다.");
			return false;
		}
		
		//필수항목 체크
		//신청일자
		if(gcds_data01.namevalue(i,"APPDATE")==""){
			alert(i+"번째 행의 신청일자가 필요합니다.");
			return false;
		}
		
		//지급정보////////////////////////////////////////
		if(gcds_data01.namevalue(i,"PAYKND")==""){ 
			alert(i+"번째 행의 지급종류가  필요합니다.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"PAYKND")=="1"){ //수시지급	
			if(gcds_data01.namevalue(i,"REQDATE")!=""){
				alert(i+"번째 행의 지급요청일은 입력불가 입니다.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="2"){ //고정지급
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"번째 행의 고정지급의 지급요청일은 필수항목 입니다.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="3"){ //자동지급
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"번째 행의 자동출금의 지급요청일은 필수항목 입니다.");
				return false;
			}
		}else if(gcds_data01.namevalue(i,"PAYKND")=="4"){ //지로납부
			if(gcds_data01.namevalue(i,"REQDATE")==""){
				alert(i+"번째 행의 지로납부의 지급요청일은 필수항목 입니다.");
				return false;
			}
		}
		
		//지급기준
		if(gcds_data01.namevalue(i,"PAYGB")==""){
			alert(i+"번째 행의 지급기준이 필요합니다.");
			return false;
		}
		
		
		//지급금액 -- 신규
		if(gcds_data01.namevalue(i,"OUTAMT")==0){
			alert(i+"번째 행의 지급금액이 필요합니다.");
			return false;
		}
		
		//매입정보///////////////////////////////////    
		
        //매입처리시만 
		if (gcds_data01.namevalue(i,"PURGB")=="T"){
			if(gcds_data01.namevalue(i,"DOCUMCD")==""){
				alert(i+"번째 행의 증빙명을 선택하십시요.");
				return false;
			}
			
			if(gcds_data01.namevalue(i,"TAXNBR")==""){
				alert(i+"번째 행의 계산서번호가 없습니다.");
				return false;
			}
			
			//공급가액
			if(gcds_data01.namevalue(i,"SUPAMT")==0){
				alert(i+"번째 행의 공급가액이 필요합니다.");
				return false;
			}
			
			
			//지급금액 = 공급가액 + 부가세
			if(gcds_data01.namevalue(i,"OUTAMT")!=gcds_data01.namevalue(i,"SUPAMT")+gcds_data01.namevalue(i,"SUPVATAMT")){
				alert("지급금액과 공급가액+부가세액의 합이 같지 않습니다.");
				return false;
			}
			
		}else{
			if(gcds_data01.namevalue(i,"DOCUMCD")!=""){
				alert(i+"번째 행의 증빙명이 존재합니다.");
				return false;
			}
			
			if(gcds_data01.namevalue(i,"TAXNBR")!=""){
				alert(i+"번째 행의 계산서번호가 존재합니다.");
				return false;
			}
		}
		
		//부가세액 매입처리 ..
		/*
		if(gcds_data01.namevalue(i,"SUPVATAMT")>0 && (gcds_data01.namevalue(i,"PURGB")==""||gcds_data01.namevalue(i,"PURGB")=="F") ){
			alert(i+"번째 행의 부가세액 또는 매입처리를 확인하십시요.");
			return false;
		}
		*/
		
		//거래처 정보////////////////////////////////////
		if(gcds_data01.namevalue(i,"VENDCD")==""){
			alert(i+"번째 행의 거래처코드가 필요합니다.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"VENDNM")==""){
			alert(i+"번째 행의 거래처명이 필요합니다.");
			return false;
		}
		
		//예금인데 계좌번호가 없는 경우는 체크함.
		if(gcds_data01.namevalue(i,"PAYGB")=="1"||gcds_data01.namevalue(i,"PAYGB")=="3"){ //예금일경우만 계좌번호 필수 체크 
			if(gcds_data01.namevalue(i,"PAYACCTNO")==""){
				alert(i+"번째 행의 계좌번호가 필요합니다.");
				return false;
			}
		}
		
		//적요
		if(gcds_data01.namevalue(i,"REMARK")==""){
			alert(i+"번째 행의 적요가 필요합니다.");
			return false;
		}
		
	
		//지급기준 외화
		if(gcds_data01.namevalue(i,"PAYGB")=="3"||gcds_data01.namevalue(i,"PAYGB")=="4"){
			//통화명
			if(gcds_data01.namevalue(i,"CURUNIT")==""){
				alert(i+"번째 행의 통화명이 필요합니다.");
				return false;
			}
			//외화
			if(gcds_data01.namevalue(i,"FOUTAMT")==""||gcds_data01.namevalue(i,"FOUTAMT")=="0"){
				alert(i+"번째 행의 외화가 필요합니다.");
				return false;
			}
			//환율
			if(gcds_data01.namevalue(i,"EXRATE")==""||gcds_data01.namevalue(i,"EXRATE")=="0"){
				alert(i+"번째 행의 환율이 필요합니다.");
				return false;
			}
		}
		
		/**
		//계정코드
		if(gcds_data01.namevalue(i,"ATCODE")==""){
			alert(i+"번째 행의 계정코드가 필요합니다.");
			return false;
		}
		
		//계정코드명
		if(gcds_data01.namevalue(i,"ATKORNAM")==""){
			alert(i+"번째 행의 계정명이 필요합니다.");
			return false;
		}
		
		*/
		
		//결재상태 
		if(gcds_data01.namevalue(i,"AP_STATUS_M")!="0"){
			alert(i+"번째 행의 결재상태값을 확인 하십시요.");
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
		gctr_data.KeyValue   = "Account.a400310_t1(I:USER=gcds_data01)";
		gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_t1?";
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
		alert(srow+"번째 행의 계산서번호가 존재합니다. 삭제 불가합니다.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"APPFSDAT")!=""){
		alert(srow+"번째 행의 전표접수번호가 존재합니다. 삭제 불가합니다.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"PAYSTAT")!="1"){
		alert(srow+"번째 행의 상태를 확인하십시요. 삭제 불가합니다.");
		return false;
	}
	
	if(gcds_data01.namevalue(srow,"AP_STATUS_M")!="0"){
		alert(srow+"번째 행의 결재상태를 확인하십시요. 삭제 불가합니다.");
		return false;
	}
	
	//상세정보 조회 후 데이터 존재하면 삭제 불가....	
	ln_Query2(gcds_data01.namevalue(srow,"APPNO"),gs_fdcode);
	
	if(gcds_data02.countrow>0){
		alert("신청번호 "+gcds_data01.namevalue(srow,"APPNO")+"의 상세정보가  "+gcds_data02.countrow+" 건 존재합니다. \n 상세정보를 먼저 삭제 하십시요. ");
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
	
	
	if(gs_fdcode=="null"||gs_fdcode==""){
		alert("지점 정보를 확인하십시요.");
		return false;
	}
	
	if(gcem_appdate.text==""){
		alert("신청일 정보를 확인하십시요.");
		return false;
	}
	
	gcds_data01.addrow();
	gcds_data02.ClearAll();
	
	gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE") = gs_fdcode;
	gcds_data01.namevalue(gcds_data01.rowposition,"APPDATE") = gcem_appdate.text;
	
	
	/**
	if(chkbox_reqdate.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"REQDATE") = gcem_reqdate0.text;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"REQDATE") = "";
	}
	
	//alert("txt_vendid0.value::"+txt_vendid0.value);
	//alert("length::"+txt_vendid0.value.length);

	if(chkbox_vendcd.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD")    = txt_vendcd0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM")    = txt_vendnm0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYACCTNO") = txt_payacctno0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDID")    = txt_vendid0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYGB") = gclx_paygb.bindcolval;
		gcds_data01.namevalue(gcds_data01.rowposition,"ACCT_AUTH") = hid_acct_auth0.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"VEND_ID_LEN") = txt_vendid0.value.length;
	}else {
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD")    = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM")    = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYACCTNO") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"VENDID")= "";
		gcds_data01.namevalue(gcds_data01.rowposition,"PAYGB") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"ACCT_AUTH") ="";
		gcds_data01.namevalue(gcds_data01.rowposition,"VEND_ID_LEN")="";
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
	
	**/
	gcds_data01.namevalue(gcds_data01.rowposition,"APPEMPNO") = gs_userid;
	//gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM") = "";
	gcds_data01.namevalue(gcds_data01.rowposition,"PAYSTAT") = "1"; // 미지급
	gcds_data01.namevalue(gcds_data01.rowposition,"AP_STATUS_M")= "0"; // 결재상태값 
		
	gcgd_disp01.ColumnProp("DOCUMCD","Edit")="None";
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
/******************************************************************************************
	Description : 저장
******************************************************************************************/
%>
function ln_Save2(){
		
	if(!ln_Chk_Save2())return;
	else if (gcds_data02.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
			gctr_data.KeyValue   = "Account.a400310_t2(I:USER=gcds_data02)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data02.text);
			gctr_data.post();
			ln_Query2(gcds_data01.namevalue(gcds_data01.rowposition,"APPNO"),gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE"));		
		}	
	}
}

<%
/******************************************************************************************
	Description : 저장 체크
******************************************************************************************/
%>
function ln_Chk_Save2(){
	
	
	for(var i=1;i<=gcds_data02.countrow;i++){
		
		//신청전표가 존재하는데, SYSSTAUS <> 0  아니면 체크
		if(gcds_data02.namevalue(i,"APPFSDAT")!=""&&gcds_data02.SysStatus(i)!=0){
			alert("이미 신청전표가 발행되었습니다." +i+" 행의 데이터 수정이 불가합니다.");
			return false;
		}
		
		//필수항목 체크
		//지급상세정보////////////////////////////////////////
		if(gcds_data02.namevalue(i,"APPNO")==""){
			alert(i+"번째 행의 신청번호가 필요합니다.");
			return false;
		}
		
		//지급상세기준
		if(gcds_data02.namevalue(i,"COSTGB")==""){
			alert(i+"번째 행의 지급기준이 필요합니다.");
			return false;
		}
		 
		 
		if(gcds_data02.namevalue(i,"COSTGB")!="9"){
			if(gcds_data02.namevalue(i,"COSTCT")==""){
				alert(i+"번째 행의 원가/예산코드가 필요합니다.");
				return false;
			}
			
			if(gcds_data02.namevalue(i,"COSTCTNM")==""){
				alert(i+"번째 행의 원가/예산명이 필요합니다.");
				return false;
			}
		}
		
		
		//계정코드
		if(gcds_data02.namevalue(i,"ATCODE")==""){
			alert(i+"번째 행의 계정코드가 필요합니다.");
			return false;
		}
		
		//계정코드명
		if(gcds_data02.namevalue(i,"ATKORNAM")==""){
			alert(i+"번째 행의 계정명이 필요합니다.");
			return false;
		}
		
		
		//
		if(gcds_data02.namevalue(i,"COSTGB")=="1"){ //원가
			
			if(gcds_data02.namevalue(i,"ATCODE").substring(0,2)!="43"){
				alert(i+"번째 행의 계정은 매출원가만 가능합니다. ");
				return false;
			}
		}else if(gcds_data02.namevalue(i,"COSTGB")=="2"){ //예산
			if(gcds_data02.namevalue(i,"ATCODE").substring(0,2)!="44"){
				alert(i+"번째 행의 계정은 매출원가만 가능합니다. ");
				return false;
			}
		}
		
		
		if(gcds_data02.namevalue(i,"PAYGB")==""){
			alert(i+"번째 행의 지급기준이 필요합니다.");
			return false;
		}
		
		//공급금액 
		if(gcds_data02.namevalue(i,"PAYGB")=="1"||gcds_data02.namevalue(i,"PAYGB")=="2"){
			if(gcds_data02.namevalue(i,"SUPAMT")==""||gcds_data02.namevalue(i,"SUPAMT")=="0"){
				alert(i+"번째 행의 원화가 필요합니다.");
				return false;
			}
	    }else if(gcds_data02.namevalue(i,"PAYGB")=="3"||gcds_data02.namevalue(i,"PAYGB")=="4"){
			//외화
			if(gcds_data02.namevalue(i,"FOUTAMT")==""||gcds_data02.namevalue(i,"FOUTAMT")=="0"){
				alert(i+"번째 행의 외화가 필요합니다.");
				return false;
			}
		}
		
		//결재상태 
		if(gcds_data02.namevalue(i,"AP_STATUS_M")!="0"){
			alert(i+"번째 행의 결재상태값을 확인 하십시요.");
			return false;
		}
		
		//상세정보의 공급금액 SUM값과 지급정보의 지급금액 비교  상신에서 체크 
		/**
		//맨 마지막 행 
		if(i==gcds_data02.countrow){
			var intsum = gcds_data02.sum(9,0,0);
			
			for(k=1;k<=gcds_data01.countrow;k++){
				
				if(gcds_data02.namevalue(i,"APPNO")==gcds_data01.namevalue(k,"APPNO")){
					
					if(intsum!=gcds_data01.namevalue(k,"OUTAMT")){
						alert("지급정보의 지급금액과 상세정보의 공급금액 합이 일치하지 않습니다.");
						return false;
					}
				}
			}
		}
		**/
	}
	return true;
}

<%
/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
%>
function ln_Delete2(){
	
	if(!ln_Chk_Delete2(gcds_data02.rowposition))return;

	if (confirm("삭제 하시겠습니까?")){	
		gcds_data02.deleterow(gcds_data02.rowposition);
		gctr_data.KeyValue   = "Account.a400310_t2(I:USER=gcds_data02)";
		gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_t2?";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
		gctr_data.post();
		ln_Query2('','');			
	}	
}

<%
/******************************************************************************************
	Description : 삭제체크
*****************************************************************************************/
%>
function ln_Chk_Delete2(srow){
	
	//전표체크
	//미지급체크
	if(gcds_data02.namevalue(srow,"APPFSDAT")!=""){
		alert(srow+"번째 행의 전표접수번호가 존재합니다. 삭제 불가합니다.");
		return false;
	}
	
	//if(gcds_data02.namevalue(srow,"PAYSTAT")!="1"){
	//	alert(srow+"번째 행의 상태를 확인하십시요. 삭제 불가합니다.");
	//	return false;
	//}
	
	if(gcds_data02.namevalue(srow,"AP_STATUS_M")!="0"){
		alert(srow+"번째 행의 결재상태를 확인하십시요. 삭제 불가합니다.");
		return false;
	}
	
	return true ;
}


/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add2(){
		
	var irow = gcds_data01.rowposition;	
		
	//지급정보의 데이터가 없는 경우 return l
	if(gcds_data01.countrow<1) {
		alert("지급정보의 데이터가 존재하지 않습니다.");
		return false;
	}else{
		
		if(gcds_data01.namevalue(irow,"APPNO")==""){
			alert("지급정보의 신청번호가 존재하지 않습니다.");
			return false;
		}
		
		//상태값이 0 인건만 행 추가 가능	
		if(gcds_data01.namevalue(irow,"AP_STATUS_M")!="0"){
			alert("결재상태를 확인 하십시요. 상세정보 행추가 불가합니다.");
			return false;
		}
	}
	
	
	if(gcds_data02.countrow<1){
		ln_Query2('','');
	}	
	
	if(gs_fdcode=="null"||gs_fdcode==""){
		alert("지점 정보를 확인하십시요.");
		return false;
	}
	
	if(gcem_appdate.text==""){
		alert("신청일 정보를 확인하십시요.");
		return false;
	}
	
	gcds_data02.addrow();
	gcds_data02.namevalue(gcds_data02.rowposition,"FDCODE") = gcds_data01.namevalue(irow,"FDCODE");
	
	//alert("gcds_data02.MAX(2,0,0)::"+gcds_data02.MAX(2,0,0));
	gcds_data02.namevalue(gcds_data02.rowposition,"APPNO") = gcds_data01.namevalue(irow,"APPNO");
	gcds_data02.namevalue(gcds_data02.rowposition,"APPSEQ")= gcds_data02.MAX(2,0,0)+1;
	
		
	//gcds_data01.namevalue(gcds_data01.rowposition,"APPEMPNO") = gs_userid;
	//gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM") = "";ㅓㅛㄴ
	gcds_data02.namevalue(gcds_data02.rowposition,"PAYSTAT") = "1"; // 미지급
	gcds_data02.namevalue(gcds_data02.rowposition,"AP_STATUS_M")= "0"; // 결재상태값
	
	gcds_data02.namevalue(gcds_data02.rowposition,"PAYGB") = gcds_data01.namevalue(irow,"PAYGB");
	gcds_data02.namevalue(gcds_data02.rowposition,"APPFSDAT") = gcds_data01.namevalue(irow,"APPFSDAT");
	
}


/******************************************************************************
Description : 행삭제
******************************************************************************/
function ln_RowDel2(){
	
	if(gcds_data02.countrow<1){
		alert("행 삭제할 행이 존재하지 않습니다.");	
	}	
	
	if(!ln_Chk_Delete2(gcds_data02.rowposition))return;
	
	gcds_data02.deleterow(gcds_data02.rowposition);

}
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
/*^^
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
*/

<%
/******************************************************************************
	Description : 계산서 데이터 저장  && 계산서 번호 업데이트
******************************************************************************/
%>
/*^^
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
*/
<%
/******************************************************************************
Description : 필수항목 체크 
******************************************************************************/
%>
/*^^
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
*/
<%
/******************************************************************************
Description : 원가 / 예산부서 팝업
******************************************************************************/
%>
function ln_Popup_Costct(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gcds_data02.namevalue(row,"COSTGB")=="1"){         //원가
		
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
			gcds_data02.namevalue(row,"COSTCT")   = arrResult[0];  // 코드 
			gcds_data02.namevalue(row,"COSTCTNM") = arrResult[1];  // 원가명
		}else{
			gcds_data02.namevalue(row,"COSTCT")   = "";
			gcds_data02.namevalue(row,"COSTCTNM") = "";
		}
		
	}else if(gcds_data02.namevalue(row,"COSTGB")=="2"){  //예산
		
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
			gcds_data02.namevalue(row,"COSTCT")   = arrResult[0];  // 코드 
			gcds_data02.namevalue(row,"COSTCTNM") = arrResult[1];  // 예산부서명
		}else{
			gcds_data02.namevalue(row,"COSTCT")   = "";
			gcds_data02.namevalue(row,"COSTCTNM") = "";
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
	
	if(gcds_data02.namevalue(row,"COSTGB")=="1"){ //원가
		arrParam[1]='43';	
	}else if(gcds_data02.namevalue(row,"COSTGB")=="2"){ //예산
		arrParam[1]='44';
	}else{
		arrParam[1]='';
	}
	
	
	strURL = "./actcode_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_data02.namevalue(row,"ATCODE")   = arrResult[0];  // 코드 
		gcds_data02.namevalue(row,"ATKORNAM") = arrResult[1];  // 거래처명
	}else{
		gcds_data02.namevalue(row,"ATCODE")   = "";
		gcds_data02.namevalue(row,"ATKORNAM") = "";
	}
}

<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>
/*^^
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

*/
<%
/******************************************************************************
Description : 원가 팝업
******************************************************************************/
%>
/*^^
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
*/
<%
/******************************************************************************
Description : 거래처 계좌 팝업
******************************************************************************/
%>
function ln_Popup_Payacctno(row){
	
	if(gcds_data01.namevalue(row,"PAYGB")==""){
		alert(row+"번째 행의 지급기준이 필요합니다.");
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
	
		
		//계산서에서 데이터를 가져왔을 경우
		if(gcds_data01.namevalue(row,"PURGB")=="T" && gcds_data01.namevalue(row,"TAXNBR")!=""){
			
			//alert("vendid::"+gcds_data01.namevalue(row,"VENDID"));
			
			arrParam[0] = gcds_data01.namevalue(row,"VENDID"); 
			
			//alert("arrParam[0]::"+arrParam[0]);
			
			strURL = "./a400310_popup_lock.jsp";
		    strPos = "dialogWidth:680px;dialogHeight:450px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);
		}else{ 	//일반 거래처 팝업으로 데이터 가져왔을 경우  
			strURL = "./a300060_popup.jsp";
		    strPos = "dialogWidth:680px;dialogHeight:450px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);
	    }
			
		if(result != null) {
			arrResult = result.split(";");
			gcds_data01.namevalue(row,"VENDCD")     = arrResult[0];  // 코드 
			gcds_data01.namevalue(row,"VENDNM")     = arrResult[1];  // 거래처명
			gcds_data01.namevalue(row,"PAYACCTNO")  = arrResult[2];  // 계좌
			gcds_data01.namevalue(row,"VENDID")     = arrResult[3];  // 사업자번호
			gcds_data01.namevalue(row,"ACCT_AUTH")  = arrResult[4];  // 예금주
			gcds_data01.namevalue(row,"VEND_ID_LEN")= arrResult[3].length;
		}else{
			gcds_data01.namevalue(row,"VENDCD")     = "";  // 코드 
			gcds_data01.namevalue(row,"VENDNM")     = "";  // 거래처명
			gcds_data01.namevalue(row,"PAYACCTNO")  = "";  // 계좌
			gcds_data01.namevalue(row,"VENDID")     = "";  // 사업자번호
			gcds_data01.namevalue(row,"ACCT_AUTH")  = "";  // 예금주
			gcds_data01.namevalue(row,"VEND_ID_LEN")="";
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
			gcds_data01.namevalue(row,"ACCT_AUTH")  = "";  // 예금주
			gcds_data01.namevalue(row,"VEND_ID_LEN")= arrResult[5].length;
		} else {
			gcds_data01.namevalue(row,"VENDCD")="";
			gcds_data01.namevalue(row,"VENDNM")="";
			gcds_data01.namevalue(row,"PAYACCTNO")  = "";
			gcds_data01.namevalue(row,"VENDID")     = "";  // 사업자번호
			gcds_data01.namevalue(row,"ACCT_AUTH")  = "";  // 예금주
			gcds_data01.namevalue(row,"VEND_ID_LEN")="";
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
	    strPos = "dialogWidth:680px;dialogHeight:450px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
		
		if(result != null) {
			arrResult = result.split(";");
			txt_vendcd0.value    = arrResult[0];  // 코드 
			txt_vendnm0.value    = arrResult[1];  // 거래처명
			txt_payacctno0.value = arrResult[2];  // 계좌
			txt_vendid0.value    = arrResult[3];  // 사업자번호
			hid_acct_auth0.value = arrResult[4];  // 예금주
		}else{
			txt_vendcd0.value    = "";  // 코드 
			txt_vendnm0.value    = "";  // 거래처명
			txt_payacctno0.value = "";  // 계좌
			txt_vendid0.value    = "";  // 사업자번호
			hid_acct_auth0.value = "";  // 예금주
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
			hid_acct_auth0.value ="";
		} else {
			txt_vendcd0.value="";
			txt_vendnm0.value="";
			txt_payacctno0.value = "";
			txt_vendid0.value    = "";
			hid_acct_auth0.value = "";
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
/*^^
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
*/
<%
/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>
/*^^

function ln_Taxdtl_SetDataHeader(){
	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING,TAXTOT:DECIMAL";
	gcds_taxdtl.SetDataHeader(s_tmp1);
	
}
*/

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


<%
/******************************************************************************
	Description : 계산서 증빙팝업
******************************************************************************/
%>
function ln_Popup_Tax(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strDocumcd="";
	var strDocGB="";
	

	//매입 처리 체크 .....
	//alert("PURGB:::::"+gcds_data01.namevalue(row,"PURGB"));
	if(gcds_data01.namevalue(row,"PURGB")!="T"){
		alert("매입처리를 체크하십시요.")
		return false;
	}
	
	//증빙명 선택 체크....
	
	//동일화면 동일계산서 번호 체크 
	
	//alert("DOCUMCD:::::"+gcds_data01.namevalue(row,"DOCUMCD"));
	
	if (gcds_data01.namevalue(row,"DOCUMCD")=="000"||gcds_data01.namevalue(row,"DOCUMCD")==""){
		alert("증빙명을 선택하십시요.");
		return false;
	}else{
		arrParam[0]= gcds_data01.namevalue(row,"DOCUMCD");
	}
	 	
	//매입 전용 팝업 ...
	strURL = "./com_tax_list1_A.jsp";
	
	strPos = "dialogWidth:900px;dialogHeight:500px;status:no;scroll:no;resizable:no";				
	
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		
		gcds_data01.namevalue(row,"TAXNBR") = arrResult[0];
		gcds_data01.namevalue(row,"SUPAMT") = arrResult[1];
		gcds_data01.namevalue(row,"SUPVATAMT") = arrResult[2];
		gcds_data01.namevalue(row,"VENDCD") = arrResult[3];
		gcds_data01.namevalue(row,"VENDID") = arrResult[4];
		gcds_data01.namevalue(row,"VENDNM") = arrResult[5];
		gcds_data01.namevalue(row,"VEND_ID_LEN") = arrResult[6];
    }else{
    	gcds_data01.namevalue(row,"TAXNBR") = "";
		gcds_data01.namevalue(row,"SUPAMT") = "";
		gcds_data01.namevalue(row,"SUPVATAMT") = "";
		gcds_data01.namevalue(row,"VENDCD") = "";
		gcds_data01.namevalue(row,"VENDID") = "";
		gcds_data01.namevalue(row,"VENDNM") = "";
		gcds_data01.namevalue(row,"VEND_ID_LEN") = "";
    }
}



<%
/******************************************************************************
	Description : 결재선  popup
******************************************************************************/
%>
function fnPopApline() {
	
	/**
	//인감정보 등록 체크 
	if(gcem_app_no.text==""){
		alert(" 신청서 저장 후 결재선지정 가능합니다.");
		return false;
	}
	**/
	
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;
	var strPos;
	var sApproveLine;
	strURL = "<%=dirPath%>/Config/help/sy040h.jsp";
	strPos = "dialogWidth:620px;dialogHeight:500px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
	fnSetApline(arrResult);	
}


function fnSetApline(val){
	//alert("받아온 결재선="+val);
	var apline_tot = new Array();
	var apline_row = new Array();

	if(val!=""){
		ds_apline.clearData();	//먼저 지우고

		apline_tot=val.split(";");	// 결재선 행별로 나눔
		//alert("실제 결재선 행 + 1개 == "+apline_tot.length);	// 1행이면 2 리턴.. ;가 마지막에 들어가 있으니
		for(i=1;i<apline_tot.length;i++){
			apline_row = apline_tot[i-1].split("/");  // 1행부터
			/*
			alert(apline_row.length);	//
			alert("기본결재선(1) : " + apline_row[0]);	//
			alert("순번 : " + apline_row[1]);	//
			alert("결재유형 : " + apline_row[2]);	//
			alert("사번 : " + apline_row[3]);	//
			alert("이름 : " + apline_row[4]);	//
			alert("직위 : " + apline_row[5]);	//
			alert("부서 : " + apline_row[6]);	//
			alert("내 결재선 SID : " + apline_row[7]);	//
			*/
			
			ds_apline.AddRow();
			ds_apline.NameValue(i, "SEQ") 				= apline_row[1];//순번
			ds_apline.NameValue(i, "AP_TYPE") 			= apline_row[2];//결재유형
			ds_apline.NameValue(i, "ENO_NO")			= apline_row[3];//사번
			ds_apline.NameValue(i, "ENO_NM") 			= apline_row[4];//이름
			ds_apline.NameValue(i, "JOB_NM") 			= apline_row[5];//직위
			ds_apline.NameValue(i, "DPT_NM") 			= apline_row[6];//부서
			
			/*
			if(apline_row[1]==1){
				ds_apline.NameValue(i, "AP_STATUS_D") 	= "2";	//==상신
				
			}else{
				ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==미결
			};
			*/
			
			ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==미결
			
			ds_apline.NameValue(i, "U_DATE") 			= "";
			ds_apline.NameValue(i, "AP_DESC") 			= "";
		}
	
	}else{
    	v_job="S_AP";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_dwr_sid=<%=v_dwr_sid%>"
			+ ",v_ap_m_sid=<%=v_ap_m_sid%>"	//결재선sid
			;
		
		//이 결재선 조회도 Ap200I.java로 옮기는게 맞을 듯.. -_-
        ln_TRSetting(tr1, 
        	"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",	
            "JSP(O:DS_APLINE=ds_apline)",
            param);
        tr_post(tr1);
	}
} 


<% //결재선 데이터셋 헤더 %>
function ln_SetDataHeader(){
	if (ds_apline.countrow<1){
		var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
				   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
				   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
		ds_apline.SetDataHeader(s_temp);
	}
}



<% //결재MST %>
function ln_SetDataHeader3(){
	if (gcds_ap_mst.countrow<1){
		var s_temp = "AP_M_SID:DECIMAL(10),DOC_SID:DECIMAL(10),DOC_GU:STRING(10),DOC_GU2:STRING(10),AP_STATUS_M:STRING(10),L_EMPNO:STRING(10),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "NUM_PARAM1:DECIMAL(10),NUM_PARAM2:DECIMAL(10),NUM_PARAM3:DECIMAL(10),NUM_PARAM4:DECIMAL(10),NUM_PARAM5:DECIMAL(10),"
				   + "CH_PARAM1:STRING(20),CH_PARAM2:STRING(20),CH_PARAM3:STRING(20)";
		gcds_ap_mst.SetDataHeader(s_temp);
	}
}


<% //결재DTL %>
function ln_SetDataHeader4(){
	if (gcds_ap_dtl.countrow<1){
		var s_temp = "AP_SID:DECIMAL(10),AP_M_SID:DECIMAL(10),AP_GU:STRING(10),AP_SEQ:DECIMAL(10),AP_TYPE:STRING(10),AP_STATUS_D:STRING(10),"
				   + "AP_EMPNO:STRING(10),AP_REAL_EMPNO:STRING(10),AP_DESC:STRING(100),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "AP_JOBNM:STRING(20),AP_DPTNM:STRING(50)";
		gcds_ap_dtl.SetDataHeader(s_temp);
	}
}


<% //상신  전자결재MST, 전자결재DTL %>
function ln_Apply(){
	
	//
    if(!ln_Chk_Apply())return;
    if(!ln_Chk2_Apply())return;
	
	if (confirm("입력하신 사항을 상신하시겠습니까?")){
			
		ln_Data_Setting();	
		
		gctr_data2.KeyValue = "Account.a400310_t3(I:USER=gcds_ap_mst,I:USER2=gcds_ap_dtl,I:USER3=gcds_data01,O:USER4=gcds_return_ap_m_sid)";
		gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_t3";
		gctr_data2.Parameters = "v_str1="+gs_userid;
		
		//prompt('gcds_ap_mst',gcds_ap_mst.text);
		//prompt('gcds_ap_dtl',gcds_ap_dtl.text);
		//prompt('gcds_data01',gcds_data01.text);
		
		//prompt('gcds_return_ap_m_sid',gcds_return_ap_m_sid.text);
		
		gctr_data2.post();
		
		ln_Query();
		
		//결재선 재조회
		ln_Query_Apline(gcds_return_ap_m_sid.namevalue(gcds_return_ap_m_sid.rowposition,"AP_M_SID"));
	}
}

<% //상신 체크 %>
function ln_Chk_Apply(){	
	
	var intCnt = 0 ;
	for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHKBOX")=="T"){
			intCnt +=1;
			
			//alert("AP_M_SID::"+gcds_data01.namevalue(i,"AP_M_SID")+"::");
			
			//결재마스터 SID 체크 
			if(gcds_data01.namevalue(i,"AP_M_SID")!=0){
				alert("이미 상신하셨습니다.");
				return false;
			}
			
			//alert("APPNO::"+gcds_data01.namevalue(i,"APPNO")+"::");
			
			if(gcds_data01.namevalue(i,"APPNO")==""||gcds_data01.namevalue(i,"APPNO")=="null"){
				alert("신청서번호가 존재하지 않습니다.");
				return false;
			}
		}
		
		//체크 - 결재선 존재 확인 .
		if(ds_apline.countrow<2){
			alert("결재선을 확인 바랍니다.");
			return false;
		}
		
		
		//valid 체크 
		
		
		
		
		/*
		//결재 후에는 상신 불가...
		if(gcds_data.namevalue(gcds_data.rowposition,"AP_M_SID")!=0){
			alert("이미 상신하셨습니다.");
			return false;
		}
		*/
	}
	
	if(intCnt==0){
		alert("지급정보에서 선택하신 건이 존재하지 않습니다.");
		return false;
	}else{
		return true;
	}
}


<% //상신 체크 %>
function ln_Chk2_Apply(){	
	
	var strAppno = "";
	var cnt =0;
	for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHKBOX")=="T"){
			cnt+=1;
			if(cnt==1){
				strAppno ="'"+gcds_data01.namevalue(i,"APPNO")+"'"
			}else{
				strAppno +=",'"+gcds_data01.namevalue(i,"APPNO")+"'"	
			}
		}
	}
	
	ln_Query3(strAppno,gs_fdcode);
	
	if(gcds_data03.countrow>0){
		for(var j=1;j<=gcds_data03.countrow;j++){
			if(gcds_data03.namevalue(j,"OUTAMT") !=gcds_data03.namevalue(j,"SUPAMT")+gcds_data03.namevalue(j,"SUPVATAMT")){
				alert("신청번호 : "+gcds_data03.namevalue(j,"APPNO") +"번의 [지급정보] 지급금액 ≠ 공급가액+부가세액 상태입니다.");
				return false;
			}
			
			if(gcds_data03.namevalue(j,"SUPAMT")!=gcds_data03.namevalue(j,"XSUPAMT") ){
				alert("신청번호 : "+gcds_data03.namevalue(j,"APPNO") +"번의 [지급정보] 공급가액≠ [상세정보] 공급가액 원화 합계 상태입니다.");
				return false;
			}
			
			if(gcds_data03.namevalue(j,"FOUTAMT")!=gcds_data03.namevalue(j,"XFOUTAMT") ){
				alert("신청번호 : "+gcds_data03.namevalue(j,"APPNO") +"번의 [지급정보] 외화 ≠ [상세정보] 외화 합계 상태입니다.");
				return false;
			}
		}
	}else{
		return false;
	}

	return true;
}

<% //데이터 설정 %>
function ln_Data_Setting(){
	var mrow=0;
	var drow=0;
	//결재 MST
	ln_SetDataHeader3();  
	gcds_ap_mst.addrow();
	mrow = gcds_ap_mst.rowposition;
	
	//gcds_ap_mst.namevalue(mrow,"AP_M_SID") ="" ;      //시퀀스에서 가져옴.
	gcds_ap_mst.namevalue(mrow,"DOC_SID") ="3000";      //이건 그냥 임의로 넣음....의미없음. 
	gcds_ap_mst.namevalue(mrow,"DOC_GU") = "12";        //결재문서구분    AP001 - 재무 (12)
	gcds_ap_mst.namevalue(mrow,"DOC_GU2") ="810";       //결재문서구분2 AP006 - 지출신청 (810)
	gcds_ap_mst.namevalue(mrow,"AP_STATUS_M") ="2";     //승인진행
	gcds_ap_mst.namevalue(mrow,"L_EMPNO") =gs_userid;   //최종결재자 - 상신시는 상신자. 계속 update 
	gcds_ap_mst.namevalue(mrow,"I_EMPNO") =gs_userid;   //등록자
	gcds_ap_mst.namevalue(mrow,"I_DATE") ="" ;          //등록일시  
	gcds_ap_mst.namevalue(mrow,"I_IP") = "<%=gusrip%>"; //등록자 IP
	gcds_ap_mst.namevalue(mrow,"U_EMPNO") ="" ;
	gcds_ap_mst.namevalue(mrow,"U_DATE") ="" ;
	gcds_ap_mst.namevalue(mrow,"U_IP") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM1") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM2") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM3") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM4") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM5") ="" ;
	gcds_ap_mst.namevalue(mrow,"CH_PARAM1")  ="" ; //지출신청번호 - 신청일자 + SEQ
	gcds_ap_mst.namevalue(mrow,"CH_PARAM2")  ="" ;
	gcds_ap_mst.namevalue(mrow,"CH_PARAM3")  ="" ;
	
	//결재 DTL (신청팀)
	ln_SetDataHeader4();
	for(var i=1;i<=ds_apline.countrow;i++ ){
		gcds_ap_dtl.addrow();
		drow=gcds_ap_dtl.rowposition;
		//gcds_ap_dtl.namevalue(drow,"AP_SID") =""; //시퀀스에서 가져옴.
		//gcds_ap_dtl.namevalue(drow,"AP_M_SID") =ds_apline2.namevalue(i,""); // MST 시퀀스 가져옴.
		gcds_ap_dtl.namevalue(drow,"AP_GU")   = "1"; //1결재 2참조 3시행 4협조
		gcds_ap_dtl.namevalue(drow,"AP_SEQ")  =ds_apline.namevalue(i,"SEQ");
		gcds_ap_dtl.namevalue(drow,"AP_TYPE") =ds_apline.namevalue(i,"AP_TYPE");
		
		if(ds_apline.namevalue(i,"SEQ")==1){
			gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  ="2"; //상신
		}else{
			gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  =ds_apline.namevalue(i,"AP_STATUS_D");
		}
		gcds_ap_dtl.namevalue(drow,"AP_EMPNO")     =ds_apline.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_REAL_EMPNO")=ds_apline.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_DESC")      =ds_apline.namevalue(i,"AP_DESC");
		gcds_ap_dtl.namevalue(drow,"I_EMPNO")      =gs_userid;
		gcds_ap_dtl.namevalue(drow,"I_DATE")  ="";
		gcds_ap_dtl.namevalue(drow,"I_IP")    ="<%=gusrip%>";
		gcds_ap_dtl.namevalue(drow,"U_EMPNO") ="";
		gcds_ap_dtl.namevalue(drow,"U_DATE")  ="";
		gcds_ap_dtl.namevalue(drow,"U_IP")    ="";
		gcds_ap_dtl.namevalue(drow,"AP_JOBNM") =ds_apline.namevalue(i,"JOB_NM");
		gcds_ap_dtl.namevalue(drow,"AP_DPTNM") =ds_apline.namevalue(i,"DPT_NM");
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
<!--자금신청상세내역 -->
<object id=gcds_data02 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--금액 Vaild Chk -->
<object id=gcds_data03 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--매입계산서 -->

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

<object id=ds_apline classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_gc_apsts_d classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_mst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_dtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_return_ap_m_sid classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>





</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data2 classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
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
			ln_Popup_Costct(row);
		}
		
		if(colid=="ATCODE"){
			ln_Popup_Atcode(row);
		}
		
		if(colid=="CURUNIT"){
			ln_Popup_Curunit(row);
		}
		
		if(colid=="DOCUMCD2"){
			//alert("계산서 리스트");
			ln_Popup_Tax(row)
		}
	}
</script>


<script language="javascript"  for=gcgd_disp01  event=OnClick(row,colid)>

	if(row>0){
		if(colid =="CHKBOX"){
			
			/**** 
			//계산서번호 확인
			if(gcds_data01.namevalue(row,"TAXNBR")!=""){
				alert("계산서번호가 이미 존재합니다.");

				gcds_data01.namevalue(row,"CHKBOX")="F";
				return false;
			}
			****/
			
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
			
		}else if(colid =="PURGB"){ 
			if(gcds_data01.namevalue(row,"PURGB")=="T"){
				//alert("활성");
				gcgd_disp01.ColumnProp("DOCUMCD","Edit")="Any";
				gcgd_disp01.ColumnProp("DOCUMCD2","Edit")="Any";
			}else{
				//alert("비활성");
				gcds_data01.namevalue(row,"DOCUMCD")="";
				gcgd_disp01.ColumnProp("DOCUMCD","Edit")="None";
				gcgd_disp01.ColumnProp("DOCUMCD2","Edit")="None";
			}	
		}else{
			if(gcds_data01.namevalue(row,"AP_STATUS_M")!=0){
				ln_Query_Apline(gcds_data01.namevalue(row,"AP_M_SID"));	
			}else{
				///ln_Query_Apline(99999);	
			}
			
			if(gcds_data01.namevalue(row,"APPNO")!=""){
				ln_Query2(gcds_data01.namevalue(row,"APPNO"),gcds_data01.namevalue(row,"FDCODE"));	
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
		
	
		//계산서번호가 존재하지 않을 경우 
		if(gcds_data01.namevalue(row,"TAXNBR")==""){
			if(colid=="OUTAMT"){
				gcds_data01.namevalue(row,"SUPAMT")=gcds_data01.namevalue(row,"OUTAMT");   //매입처리 자동 체크
			}	
		}
	}
</script>

<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	
	if(row>0){
	
		if(colid=="COSTCT"){
			ln_Popup_Costct(row);
		}
		
		if(colid=="ATCODE"){
			ln_Popup_Atcode(row);
		}	
	}
</script>



<!-- 
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
 -->
 
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

<script language=JavaScript for=gctr_data2 event=OnSuccess()>
	//alert("ap_m_sid::"+gcds_return_ap_m_sid.namevalue(gcds_return_ap_m_sid.rowposition,"AP_M_SID"));
	alert("성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/btn_ReportOver.gif"    style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Apply()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()">
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
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt1 OnClick="_GetCallCalendar('gcem_appdate', 'Text')" style="position:relative;jwidth:20px;left:6px;top:2px;cursor:hand;">&nbsp;
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
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt2 OnClick="__GetCallCalendar('gcem_reqdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
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
				<tr>
					<td class="tab27" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>결재상태</nobr></td>
					<td class="tab28" style="width:120px"  colspan =7 >
						<comment id="__NSID__">
							<object  id=gclx_ap_status_m classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			        value="1^작성중,2^승인진행,3^최종승인,4^부결">
								<param name=CBDataColumns	 		value="CODE,NAME">
								<param name=SearchColumn	     	value=NAME>
								<param name=Sort			        value=false>
								<param name=ListExprFormat       	value="NAME">								
								<param name=BindColumn		     	value="CODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
			    
			    <!-- 
			    <tr>
			        <td colspan =2 ><font size="2" color="blue" ><strong>&nbsp;[자금신청내역]</strong></font>&nbsp;
			        	<input type=checkbox  id=chkbox_all  style="width:15px;position:relative;left:0px;top:-3px"   onclick="ln_CheckAll()">&nbsp;전체
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
								    <input id="hid_acct_auth0"   type="hidden"  style="position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>			
			                    </td>
			    			</tr>
			       		</table>
			       	</td>
			 	</tr>
			 	-->
			 	<tr>
					<td><font size="2" color="blue" ><strong>&nbsp;[지급정보]</strong></font>&nbsp;</td>
				    <td align = right>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Add()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_RowDel()">
					    &nbsp;&nbsp; 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:0px;right:0px" onClick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_delete.gif"	        style="cursor:hand;position:relative;top:0px;right:0px" onClick="ln_Delete()">
					</td>
				</tr>
				
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:185px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
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
								<FC> Name='선택'       ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  edit={Decode(AP_STATUS_M,0,'',none)} </FC>
								<FC> Name='신청번호'    ID=APPNO          HeadAlign=Center HeadBgColor=#B9D4DC Width=50        align=right 	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'   </C>
								<FC> Name='신청일자'    ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee'  show=false </FC>
								<FG> Name='지급정보'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='종류'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Combo, Data='1:수시지급,2:고정지급,3:자동출금,4:지로납부'</FC>
								<FC> Name='요청일'      ID=REQDATE	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  MASK='XXXX/XX/XX' bgcolor={Decode(PAYKND,2,'',3,'',4,'','#eeeeee')} edit={Decode(PAYKND,1,none,'')} </FC>    
								
								<FC> Name='지급기준'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Combo, Data='1:보통예금,2:현금,3:외화보통예금,4:현금(외화)'</FC>
								<FC> Name='지급금액'    ID=OUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80        align=right 	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} SumText=@sum    </C>
								</FG>
								<G> Name='매입정보'   HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='매입'       ID=PURGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    align=center    SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=CheckBox  </C>
									<C> Name='증빙명'	     ID=DOCUMCD 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=95	align=left      SumBgColor=#C3D0DB    edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Combo Data='000:,101:세금계산서,102:계산서,103:신용카드(공제),104:현금영수증(공제)'  BgColor={IF(PURGB='T','White','#eeeeee')} </C>
									<C> Name='+'         ID=DOCUMCD2       HeadAlign=Center HeadBgColor=#B9D4DC Width=25  	align=left      SumBgColor=#C3D0DB    edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Popup	 BgColor={IF(PURGB='T','White','#eeeeee')}</C>
									<C> Name='계산서번호'   ID=TAXNBR 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=center	SumBgColor='#C3D0DB'  edit=none MASK='XXXXXXX-XXXX' bgcolor='#eeeeee'</C>
								    <C> Name='공급가액'    ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum    bgcolor='#eeeeee'</C>
								    <C> Name='부가세액'    ID=SUPVATAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    align=right 	SumBgColor='#C3D0DB'  edit=none  SumText=@sum    bgcolor='#eeeeee'</C> 
								</G>
								<G> Name='거래처정보'   HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Popup </FC>
								<C> Name='등록번호'	  ID=VENDID 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</FC>
								<C> Name='거래처명'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								<C> Name='계좌번호'    ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								<C> Name='예금주'      ID=ACCT_AUTH 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								</G>
								<C> Name='적요'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)}</C>
								
								<G> Name='외화정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='통화명'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} EditStyle=Popup</</C>
								<C> Name='외화'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} SumText=@sum</C>
								<C> Name='환율'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} </C>
								</G>
								<G> Name='신청전표정보'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='접수일자'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='접수번호'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
							    </G>
								<C> Name='결재상태'    ID=AP_STATUS_M    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:작성중,2:승인진행,3:최종승인,4:부결' bgcolor='#eeeeee'</C>
								<C> Name='지급상태'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:미지급,2:접수,3:지급' bgcolor='#eeeeee'</C>							
								
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				<tr>
					<td><font size="2" color="blue" ><strong>&nbsp;[상세정보]</strong></font></td>
				    <td align = right>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:2px;right:0px;" onclick="ln_Add2()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:2px;right:0px;" onclick="ln_RowDel2()">
					    &nbsp;&nbsp; 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:2px;right:0px" onClick="ln_Save2()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_delete.gif"	        style="cursor:hand;position:relative;top:2px;right:0px" onClick="ln_Delete2()">
					</td>
				</tr>
	
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:175px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data02">
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
								<FC> Name='신청번호'   ID=APPNO  	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50        align=right 	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</C>								
								<FC> Name='신청순번'   ID=APPSEQ  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50        align=center 	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</C>
								
								<G> Name='지급상세정보' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='구분'	     ID=COSTGB  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center 	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Combo, Data='1:원가,2:예산,9:기타'</C>
								<C> Name='코드'	     ID=COSTCT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Popup </C>
								<C> Name='원가/예산명'	 ID=COSTCTNM  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								</G>
								
								<G> Name='계정정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)} EditStyle=Popup     show = true </C>
								<C> Name='계정명'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=150  	    align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'    show = true </C>
								</G>
								
								<G> Name='공급금액'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='원화'       ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80        align=right 	SumBgColor='#C3D0DB'   SumText=@sum   </C>
								<C> Name='외화'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(PAYGB,3,'',4,'','#eeeeee')} edit={Decode(PAYGB,1,none,2,none,'')} SumText=@sum</C>
								</G>
								
								<C> Name='AP_STATUS_M'    ID=AP_STATUS_M 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80        align=right 	SumBgColor='#C3D0DB'   SumText=@sum  show=false</C>
								<C> Name='PAYGB'          ID=PAYGB 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80        align=right 	SumBgColor='#C3D0DB'   SumText=@sum   show=false</C>
								
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				
				
				
				<tr>
					<td width="998px" align="left"  style="position:relative;left:5px;padding-top:4px;" colspan=2> 
						<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="position:relative;left:420px;cursor:hand" onclick="fnPopApline()">
					</td>
				</tr>
				
				<tr>
					<td height="30px" style='position:relative;left:5px;width:500px;height:30px;border:1 solid #708090' ><b><font size="2" color="blue">&nbsp;◎ 신청팀 결재선</font></b></td>
					<td height="30px" style='position:relative;left:5px;width:498px;height:30px;border:1 solid #708090' ><b><font size="2" color="blue">&nbsp;◎ 순서</font></b></td>
				</tr>
				 
				<tr>
					<td style="position:relative;left:5px;">
						<nobr>
						<comment id="__NSID__">
				  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='500px' height='100px' border='1'>
							<param name="dataid"		 value="ds_apline">
							<param name="borderstyle"    value="0">
							<param name="indwidth"       value="0">
							<param name="fillarea"		 value="true">
							<param name="colsizing"      value="true">
							<param name="editable"       value="true">
							<param name="format"		 value="  
								<C> Name='순번'	      ID=SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
								<C> Name='유형'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
								<C> Name='사번'	      ID=ENO_NO   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
								<C> Name='이름'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
								<C> Name='직위'		  ID=JOB_NM           HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
								<C> Name='소속'        ID=DPT_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
								<C> Name='결재상태'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
								<C> Name='의견'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=left  	edit=none </C>
						  	 ">
						</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td style="position:relative;left:5px;width:498px;">
						<table cellpadding="1" cellspacing="0" border="0" style='width:498px;height:30px;border:1 solid #708090'>
							<tr>
								<td align=left  style= "height:25px" > <font size="2" color="blue" > * 1.신청 작성 후 저장 버튼 클릭</font></td>
							</tr>
							<tr>
								<td align=left   style= "height:25px" > <font size="2" color="blue" > * 2.결재선지정 버튼 클릭</font></td>
							</tr>
							<tr>
								<td align=left   style= "height:25px" > <font size="2" color="blue" > * 3.상신 버튼 클릭</font></td>
							</tr>
							<tr>
								<td align=left   style= "height:25px" ></td>
							</tr>
						</table>
					</td>
				</tr>
				
				<!-- 
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
				-->
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
