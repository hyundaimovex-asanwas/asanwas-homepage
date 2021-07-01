<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인감관리 - 사용인감날인신청 결재
+ 프로그램 ID	: a400150_approve.jsp
+ 기 능 정 의	: 사용인감날인신청 결재
+ 최 초 이 력	: 2017.04.28 jys
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a400140_approve_s1, a400140_approve_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% 
   //ContextPath 변수 설정.
   String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정.
   
   String v_dwr_sid  = request.getParameter("v_dwr_sid");	    //작업일보 index
   String v_status	 = request.getParameter("v_status");	    //페이지 작업 구분자 : 상태 010작성중, 011현장결재진행중, 012현장결재완료
   String v_ap_m_sid = request.getParameter("v_ap_m_sid");	    //결재마스터 sid : 반려시에는 스냅샷을 찍는게 아니므로 일보 인덱스가 겹친다.
   
   String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
%>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_mgr_date= gcurdate.substring(2,4) + gcurdate.substring(5,7);

var gs_userid = gusrid;
var gs_yymm = gcurdate.substring(2,4) + gcurdate.substring(5,7); 


var g_WinParam = window.dialogArguments;
var g_ap_sid =0;
var g_ap_gu="";
var g_row=0;
var g_ap_status_d="";
var g_ap_sid2 =0;
var g_ap_gu2="";
var g_row2=0;
var g_ap_type2="";
var g_ap_status_d2="";

var g_ap_m_sid="";

//alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]+"::g_WinParam[2]::"+g_WinParam[2]+"::g_WinParam[3]::"+g_WinParam[3]+"::g_WinParam[4]::"+g_WinParam[4]);

/*
var array1= new Array();
var array2= new Array();
var array3= new Array();
var array4= new Array();

var strAppline_gb=""; //결재선라인 조회 구분 

if(g_WinParam[2]!=""){
	
	array1= g_WinParam[2].split(";");
	array2 =array1[0].split("/");  //담당
	array3 =array1[1].split("/");  //검토
	array4 =array1[2].split("/");  //확인
	array5 =array1[3].split("/");  //승인
	strAppline_gb="1"; //상신
	
}else{
	strAppline_gb="2"; // 미결재함에서 처리 할 경우 
}

*/

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(){
	
	ln_Query(g_WinParam[4],g_WinParam[3] );
	
	g_ap_m_sid = g_WinParam[3];
	
	/*
	txt_app_teamcd.value = gdeptcd;
	txt_app_teamnm.value = gdeptnm;
	txt_app_empno.value = gusrid;
	txt_app_empnm.value = gusrnm;
	*/
	
	//직위 조회
	gcds_jobcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_job_cd_s1?v_str1="+txt_app_empno.value;
	gcds_jobcd.Reset();
	
	txt_app_jobcd.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBCD");
	txt_app_jobnm.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBNM");
	
	//인감관리번호 팀명 + 인감기준번호 + 년월 + 순번
	//gcem_signet_mgr_no.text = gs_yymm ;
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// 결재유형 AP005 - 공통모듈쪽 공통코드 읽어오기
	
	ds_gc_apsts_d.DataId= "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// 결재상태_D AP003 - 공통모듈쪽 공통코드 읽어오기
	
	gcem_ap_desc.style.background ="#99CC00";
	
	//사용인감id 중 사용건.
	gcds_signet_id.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_s1?v_str1=2&v_str2=1";
	gcds_signet_id.Reset();
}
<%
/******************************************************************************
	Description : 조회
******************************************************************************/
%>
function ln_Query(strAppno,strAp_m_sid){
	
	//사용인감 데이터 조회 
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400150_approve_s0?v_str1="+strAppno;                                                  
	gcds_data.Reset();
	
	//결재선 MST 조회
	gcds_ap_mst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s2?v_str1="+strAp_m_sid;                                                  
	gcds_ap_mst.Reset();

	//신청팀 결재선 조회 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s1?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
	
	//주관팀 결재선 조회 
	ds_apline2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s1?v_str1="+strAp_m_sid+"&v_str2=4";                                                  
	ds_apline2.Reset();
	
	//alert("ds_apline2.countrow::"+ds_apline2.countrow);
	
	//신청팀 결재선
	_line_chk1:
	for(var i=ds_apline.countrow;i>=1;i--){
		//alert(i+"::AP_TYPE::"+ ds_apline.namevalue(i,"AP_TYPE"));
		if(ds_apline.namevalue(i,"AP_EMPNO")==gs_userid&&ds_apline.namevalue(i,"AP_STATUS_D")=="1"){
			g_ap_sid = ds_apline.namevalue(i,"AP_SID");
			g_ap_gu  = ds_apline.namevalue(i,"AP_GU");
			g_row = i;
			g_ap_status_d=ds_apline.namevalue(i,"AP_STATUS_D");
			break _line_chk1;
		}else{
			g_ap_sid="";
			g_ap_gu="";
			g_row="0";
			g_ap_status_d="";
		}
	}
	
	//주관팀 결재선
	_line_chk2:
	for(var j=ds_apline2.countrow;j>=1;j--){
		//alert(j+"::AP_TYPE::"+ ds_apline2.namevalue(j,"AP_TYPE")+"::"+ds_apline2.namevalue(j,"AP_EMPNO")+"::"+gs_userid);
		if(ds_apline2.namevalue(j,"AP_EMPNO")==gs_userid&&ds_apline2.namevalue(j,"AP_STATUS_D")=="1"){
			g_ap_sid2 = ds_apline2.namevalue(j,"AP_SID");
			g_ap_gu2  = ds_apline2.namevalue(j,"AP_GU");
			g_row2 = j;
			g_ap_type2 = ds_apline2.namevalue(j,"AP_TYPE");
			g_ap_status_d2=ds_apline2.namevalue(j,"AP_STATUS_D");
			break _line_chk2;
		}else{
			g_ap_sid2 ="";
			g_ap_gu2  = "";
			g_row2 = "0";
			g_ap_type2 = "";
			g_ap_status_d2="";
		}
	}
}


<%
/******************************************************************************
	Description : 저장
******************************************************************************/
%>
function ln_Save(){
		
	if(g_ap_gu=="1"){         //신청팀 결재선 
		
		ds_apline.namevalue(g_row,"AP_DESC") = gcem_ap_desc.text;
		if(!ln_Chk_Save())return;
		else if (ds_apline.IsUpdated) {
			if (confirm("입력하신 의견을 등록하시겠습니까?")){
				gctr_data.KeyValue = "Account.a400140_approve_t1(I:USER=ds_apline)";	
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t1";
				gctr_data.Parameters = "v_str1="+gs_userid;
				
				gctr_data.post();
				//ln_Query(gcem_app_no.text);
			}	
		}
		
	}else if (g_ap_gu2=="4") { //주관팀 결재선 
		ds_apline2.namevalue(g_row2,"AP_DESC") = gcem_ap_desc.text;
		if(!ln_Chk_Save())return;
		else if (ds_apline2.IsUpdated) {
			if (confirm("입력하신 의견을 등록하시겠습니까?")){
				gctr_data.KeyValue = "Account.a400140_approve_t1(I:USER=ds_apline2)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t1";
				gctr_data.Parameters = "v_str1="+gs_userid;
				gctr_data.post();
				//ln_Query(gcem_app_no.text);
			}	
		}
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
   //AP_SID 체크      
   return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	
}
<%
/******************************************************************************
	Description : 출력
******************************************************************************/
%>
function ln_Print(){

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

<% //승인  전자결재MST, 전자결재DTL %>
function ln_Apply(){
	
	alert("g_ap_sid:;"+g_ap_sid); 
	alert("g_ap_gu:;"+g_ap_gu);
	alert("g_ap_type2:;"+g_ap_type2);
	
	//alert("AP_M_SID::"+gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_M_SID"));
	//alert("g_ap_gu2::"+g_ap_gu2);
	if(g_ap_gu=="1"){         //신청팀 결재선 
	    if(!ln_Chk_Apply_1())return;
		
		if (confirm("입력하신 사항을 승인하시겠습니까?")){
			
			ln_Data_Apply_1();
			
			gctr_data.KeyValue = "Account.a400140_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline,I:USER3=gcds_data,I:USER4=gcds_data_his)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400150_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_ap_mst',gcds_ap_mst.text);
			//prompt('ds_apline',ds_apline.text);
			gctr_data.post();
			
			ln_Query(gcem_app_no.text,g_ap_m_sid);
		}
	}else if (g_ap_gu2=="4") { //주관팀 결재선 
		if(!ln_Chk_Apply_2())return;
		if (confirm("입력하신 사항을 승인[주관팀]하시겠습니까?")){
			ln_Data_Apply_2();
			
			gctr_data.KeyValue = "Account.a400140_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline2,I:USER3=gcds_data,I:USER4=gcds_data_his)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400150_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_ap_mst',gcds_ap_mst.text);
			//prompt('ds_apline2',ds_apline2.text);
			//prompt('gcds_data',gcds_data.text);
			//prompt('gcds_data_his',gcds_data_his.text);
			gctr_data.post();
			
			ln_Query(gcem_app_no.text,g_ap_m_sid);
		}
	}
}

<% //승인 체크 %>
function ln_Chk_Apply_1(){
	
	//결재상태 체크 
	//SID 체크 
	//ap_sid의 상태값을 체크함.
	if (g_ap_status_d=="3") {     //승인
		alert("이미 승인하였습니다.");
		return false;
	}
	
	//신청번호 체크
	if(gcem_app_no.text==""){
		alert("신청번호가 존재하지 않습니다. 확인 바랍니다.");
		return false;
	}	
	
	//체크 - 결재선 존재 확인 .
	if(ds_apline.countrow<2){
		alert("신청팀 결재선을 확인 바랍니다.");
		return false;
	}
		
	return true;
}



<% //승인 체크 %>
function ln_Chk_Apply_2(){
	var strChk="0";
	
	
	//ap_sid의 상태값을 체크함.
	if (g_ap_status_d2=="3") {  //승인
		alert("이미 승인하였습니다.");
		return false;
	}
	
	//신청번호 체크
	if(gcem_app_no.text==""){
		alert("신청번호가 존재하지 않습니다. 확인 바랍니다.");
		return false;
	}	
	
	//체크 - 결재선 존재 확인 .
	if(ds_apline2.countrow<2){
		alert("주관팀 결재선을 확인 바랍니다.");
		return false;
	}

	_line_chk1:
		for(var i=ds_apline.countrow;i>=1;i--){
			//alert(i+"::AP_TYPE::"+ ds_apline.namevalue(i,"AP_TYPE"));
			if(ds_apline.namevalue(i,"AP_STATUS_D")=="1"){
				strChk="1";
				break _line_chk1;
			}
		}
	
	if(g_ap_gu2==4&&strChk=="1"){
		alert("신청팀의 결재가 진행중입니다.");
		return false;
	}
		
	return true;
}



<% //승인시 데이터 반영  %>
function ln_Data_Apply_1(){
	//결재MST
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") = "2";
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	//결재선
	ds_apline.namevalue(g_row,"AP_STATUS_D") = "3";
	ds_apline.namevalue(g_row,"U_EMPNO") = gs_userid;
	ds_apline.namevalue(g_row,"U_IP") ="<%=gusrip%>";
}


<% //주관팀 승인시 데이터 반영  %>
function ln_Data_Apply_2(){
	
	//결재MST
	//결재선이 주간팀 승인일 때 결재상태는 최종승인으로 변경함.
	if(g_ap_type2=="4"){  //담당 검토  확인 승인 중...주관팀 승인 일경우
		gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "3"; //최종승인.
		gcds_data.namevalue(gcds_data.rowposition,"SEAL_DATE") = gs_date2;   //승인일자 반영.
		gcds_data.namevalue(gcds_data.rowposition,"SIGNET_MGR_NO") = gcem_signet_mgr_no.text;   //인감관리번호=팀+(기준번호)+년+월
		
		if(gcem_send_date.text!=""){  //반출일자가 존재하는 경우 이력에 추가 
			//이력관리에 추가해야지...
			His_Data_Add();
		}
		
	}else{
		gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "2"; //승인진행
	}
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	//결재선
	ds_apline2.namevalue(g_row2,"AP_STATUS_D") = "3";
	ds_apline2.namevalue(g_row2,"U_EMPNO") = gs_userid;
	ds_apline2.namevalue(g_row2,"U_IP") ="<%=gusrip%>";
}


<% //반송  전자결재MST, 전자결재DTL %>
function ln_Return(){
	
	//alert("AP_M_SID::"+gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_M_SID"));
	//alert("g_ap_gu2::"+g_ap_gu2);
	
	if(g_ap_gu=="1"){         //신청팀 결재선 
   
	    if(!ln_Chk_Return_1())return;
		
		if (confirm("반송 하시겠습니까?")){
			
			ln_Data_Return_1();
			
			gctr_data.KeyValue = "Account.a400150_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400150_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_ap_mst',gcds_ap_mst.text);
			//prompt('ds_apline',ds_apline.text);
			
			gctr_data.post();
		}
	}else if (g_ap_gu2=="4") { //주관팀 결재선 
				
		if (confirm("반송 하시겠습니까?")){
			
			ln_Data_Return_2();
				
			gctr_data.KeyValue = "Account.a400150_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline2)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400150_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_ap_mst',gcds_ap_mst.text);
			//prompt('ds_apline2',ds_apline2.text);
			gctr_data.post();
		}	
	}
}

<% //반송 체크 %>
function ln_Chk_Return_1(){
	
	//결재상태 체크 
	//SID 체크 
	
	return true;
}

<% //반송 체크 %>
function ln_Chk_Return_2(){
	
	//최종승인건은 반송불가....
	//결재상태 체크 
	//SID 체크 
	
	return true;
}


<% //신청팀 반송시 데이터 반영  %>
function ln_Data_Return_1(){
	//결재MST
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "4"; //부결
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	
	//결재선
	ds_apline.namevalue(g_row,"AP_STATUS_D") = "4";  //반려
	ds_apline.namevalue(g_row,"U_EMPNO") = gs_userid;
	ds_apline.namevalue(g_row,"U_IP") ="<%=gusrip%>";
}


<% //주관팀 반송시 데이터 반영  %>
function ln_Data_Return_2(){
	//결재MST
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "4";
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	//결재선
	ds_apline2.namevalue(g_row2,"AP_STATUS_D") = "4";  //반려
	ds_apline2.namevalue(g_row2,"U_EMPNO") = gs_userid;
	ds_apline2.namevalue(g_row2,"U_IP") ="<%=gusrip%>";
}


<%
/******************************************************************************
Description : 이력내역 데이터 셋 헤드 설정 
******************************************************************************/
%>
function His_SetDataHeader() {
	 var s_temp = "SIGNET_ID:STRING,SIGNET_SEQ:DECIAML,WORK_GB:STRING,MGR_TEAMCD:STRING,MGR_TEAMNM:STRING,"
		        + "MAIN_EMPID:STRING,SUB_EMPID:STRING,SEND_DATE:STRING,DISUSE_DATE:STRING,DISUSE_REASON:STRING,"
		        + "RECE_DATE:STRING,RECE_REASON:STRING,USEGB:STRING,USE_REMARK:STRING,ETC:STRING,"
		        + "WRID:STRING,WRDT:STRING,SEND_DATE_CONFIRM:STRING,RECEIVE_DATE:STRING";
	 gcds_data_his.SetDataHeader(s_temp);
}


<%
/******************************************************************************
Description : 이력내역 데이터 추가 
******************************************************************************/
%>
function His_Data_Add(){
	var hrow=0;
	His_SetDataHeader();
	
	//사용인감id 중 사용건.
	gcds_signet_info.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_s2?v_str1="+gcds_data.namevalue(gcds_data.rowposition,"SIGNET_ID");
	gcds_signet_info.Reset();
	
	
	for(var i=1;i<=gcds_signet_info.countrow;i++){
		
		//alert("i:::"+i+"::::"+gcds_signet_info.namevalue(i,"SIGNET_ID"));
		
		gcds_data_his.AddRow();
		hrow = gcds_data_his.rowposition;
		
		gcds_data_his.namevalue(hrow,"SIGNET_ID")     = gcds_signet_info.namevalue(i,"SIGNET_ID");
		gcds_data_his.namevalue(hrow,"SIGNET_SEQ")    = 0;
	
		gcds_data_his.namevalue(hrow,"MGR_TEAMCD")    = gcds_signet_info.namevalue(i,"MGR_TEAMCD");
		gcds_data_his.namevalue(hrow,"MGR_TEAMNM")    = gcds_signet_info.namevalue(i,"MGR_TEAMNM");
		gcds_data_his.namevalue(hrow,"MAIN_EMPID")    = gcds_signet_info.namevalue(i,"MAIN_EMPID");
		gcds_data_his.namevalue(hrow,"SUB_EMPID")     = gcds_signet_info.namevalue(i,"SUB_EMPID");
		gcds_data_his.namevalue(hrow,"SEND_DATE")     = gcem_send_date.text;
		gcds_data_his.namevalue(hrow,"DISUSE_DATE")   = "";
		gcds_data_his.namevalue(hrow,"DISUSE_REASON") = "";
		gcds_data_his.namevalue(hrow,"RECE_DATE")     = "";
		gcds_data_his.namevalue(hrow,"RECE_REASON")   = "";
		gcds_data_his.namevalue(hrow,"USEGB")         = gcds_signet_info.namevalue(i,"USEGB");
		gcds_data_his.namevalue(hrow,"USE_REMARK")    = "";
		gcds_data_his.namevalue(hrow,"ETC")           = "";
		gcds_data_his.namevalue(hrow,"WRID")          = "";
		gcds_data_his.namevalue(hrow,"SEND_DATE_CONFRIM") = "";
		gcds_data_his.namevalue(hrow,"RECEIVE_DATE")      = "";
		
	
		if(gcem_send_date.text!=""){
			gcds_data_his.namevalue(hrow,"WORK_GB")="4";//반출
		}
	}
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_ap_mst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_dtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_gc_apsts_d classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_signet_id classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_jobcd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_signet_info classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data_his classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		//alert("검색된 데이타가 없습니다.");
	}else{
		if(gcds_data.namevalue(gcds_data.rowposition,"SEAL_PAPER_CHK") == "Y"){
			chkbox_seal_paper.checked=true;
		}else{
			chkbox_seal_paper.checked=false;
		}
	}

	window.status = "정상적으로 조회되었습니다.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="전체";
    gclx_signet_gb_0.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="998px" align="right"  style="padding-top:4px;"> 
						<img src="<%=dirPath%>/Sales/images/btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="ln_Apply();">
	    	            <img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="ln_Return();">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;◎ 사용인감 날인 신청작성</font></b>
		<td>
	</tr>

	<tr>
		<td colspan=2 >
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:1 solid #708090'>
			<tr>
			    <td class="tab11" width="50px" bgcolor="#eeeeee" rowspan=5><nobr>공통</nobr> </td>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>신청번호</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_app_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#00000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
 						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>소속</nobr> </td>
				<td class="tab21">
					 <input id="txt_app_teamcd"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; "  >
				     <input id="txt_app_teamnm"  type="text"  style= "position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36"  readOnly>			
			    </td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>직위</nobr> </td>
				<td class="tab21">
					 <input id="txt_app_jobcd"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_jobnm"  type="text"  style= "position:relative;top:0px;left:4px;width:80px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>신청자</nobr> </td>
				<td class="tab22">
					 <input id="txt_app_empno"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_empnm"  type="text"  style= "position:relative;top:0px;left:4px;width:80px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
		    </tr>
		    <tr>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>인감ID</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object  id=gclx_signet_id  classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:120px;">
								<param name=ComboDataID      value="gcds_signet_id">
								<param name=CBDataColumns	 value="SIGNET_ID,MGR_TEAMNM,SIGNET_HEAD_NO">
								<param name=SearchColumn	 value=SIGNET_ID>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="SIGNET_ID^0^30,SIGNET_HEAD_NO^0^20,MGR_TEAMNM^0^100">								
								<param name=BindColumn		 value="SIGNET_ID">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>인감관리번호</nobr> </td>
				<td class="tab21">
					<comment id="__NSID__">
						<object id=gcem_signet_mgr_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:150px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=IsComma       value=false>
							<param name=GeneralEdit   value="true">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>신청일자</nobr> </td>
				<td class="tab21">
					<comment id="__NSID__">
						<object  id=gcem_app_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:0px;left:4px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>날인일자</nobr> </td>
				<td class="tab22">
					<comment id="__NSID__">
						<object  id=gcem_seal_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:0px;left:4px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
				</td>
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>용도</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_signet_use  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>제출/사용처</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_signet_submit  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		      <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>비고</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_remark  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		     <tr>
		        <td class="tab11" width="50px" bgcolor="#eeeeee" rowspan=2><nobr>날인</nobr> </td>
		    	<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>서류수</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_paper_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>날인수량</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_seal_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>날인서류사본</nobr> </td>
				<td class="tab22" colspan=3>
					<input type=checkbox  id=chkbox_seal_paper  style="width:15px;position:relative;left:0px;top:-3px">&nbsp;신청팀 자체 보관
				</td>
		    </tr>
		     <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>사본미첨부사유</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_attach_reason  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		     <tr>
		        <td class="tab11" width="50px" bgcolor="#eeeeee"><nobr>반출</nobr> </td>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>반출일자</nobr> </td>
				<td class="tab21" colspan=3>
					<comment id="__NSID__">
						<object  id=gcem_send_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
					<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_send_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
				</td>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>반입일시</nobr> </td>
				<td class="tab22" colspan=3>
					<comment id="__NSID__">
						<object  id=gcem_receive_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD HH:NN:SS">
						<param name=PromptChar	  value="_">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
					<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_receive_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							
				</td>
		    </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			&nbsp;
		</td>
	</tr>
	 <tr>
	    <td colspan=2>
	    <table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:1 solid #708090'>
	    <tr>
    	<td class="tab11" style="width:120px;height:20px;" bgcolor="#eeeeee"><nobr><font size="2" color="blue">의견</font></nobr> </td>
		<td class="tab21" >
			<comment id="__NSID__">
				<object id=gcem_ap_desc  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative; left:4px;top:2px;width:800px;height:20px;" class="txtbox">
					<param name=Alignment	       value=0>
					<param name=Border	           value=true>
					<param name=UpperFlag          value=1>
					<param name=GeneralEdit        value=true>
					<param name=MaxLength          value=50>
					<param name=InheritColor		value=true>
				</object>
			</comment><script>__ws__(__NSID__);</script>&nbsp;
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="cursor:hand" onclick="ln_Save()">
		</td>
		</tr>
		</table>
		</td>
    </tr>
    <tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			&nbsp;
		</td>
	</tr>
	
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090' colspan=2><b><font size="2" color="blue">&nbsp;◎ 신청팀 결재선</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
			<tr>
				<td><nobr>
					<comment id="__NSID__">
			  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='순번'	      ID=AP_SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='유형'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='사번'	      ID=AP_EMPNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='이름'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='직위'		  ID=AP_JOBNM         HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='소속'        ID=AP_DPTNM   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='결재상태'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='의견'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=565    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090' colspan=2><b><font size="2" color="blue">&nbsp;◎ 주관팀 결재선</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
			<tr>
				<td><nobr>  
					<comment id="__NSID__">
			  		<object id=gcgd_supteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline2">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='순번'	      ID=AP_SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='유형'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='사번'	      ID=AP_EMPNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='이름'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='직위'		  ID=AP_JOBNM         HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='소속'        ID=AP_DPTNM   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='결재상태'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='의견'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=565    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
 ------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=APP_NO                  Ctrl=gcem_app_no           Param=text</C>
	<C>Col=SIGNET_ID               Ctrl=gclx_signet_id        Param=bindcolval</C>
	<C>Col=SIGNET_USE              Ctrl=gcem_signet_use       Param=text</C>
	<C>Col=SIGNET_SUBMIT           Ctrl=gcem_signet_submit    Param=text</C>
	<C>Col=PAPER_CNT               Ctrl=gcem_paper_cnt        Param=text</C>
	<C>Col=SEAL_CNT                Ctrl=gcem_seal_cnt         Param=text</C>
	<C>Col=SEAL_PAPER_CHK          Ctrl=chkbox_seal_paper     Param=value</C>
	<C>Col=ATTACH_REASON           Ctrl=gcem_attach_reason    Param=text</C>
	<C>Col=SEND_DATE               Ctrl=gcem_send_date        Param=text</C>
	<C>Col=RECEIVE_DATE            Ctrl=gcem_receoive_date    Param=text</C>
	<C>Col=SEAL_DATE               Ctrl=gcem_seal_date        Param=text</C>
	<C>Col=SIGNET_MGR_NO           Ctrl=gcem_signet_mgr_no    Param=text</C>
	<C>Col=APP_TEAMCD              Ctrl=txt_app_teamcd        Param=value</C>
	<C>Col=APP_TEAMNM              Ctrl=txt_app_teamnm        Param=value</C>
	<C>Col=APP_JOBCD               Ctrl=txt_app_jobcd         Param=value</C>
	<C>Col=APP_EMPNO               Ctrl=txt_app_empno         Param=value</C>
	<C>Col=APP_EMPNM               Ctrl=txt_app_empnm         Param=value</C>
	<C>Col=APP_DATE                Ctrl=gcem_app_date         Param=text</C>
	<C>Col=REMARK                  Ctrl=gcem_remark           Param=text</C>
	'>
  </object>
  
  
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>




