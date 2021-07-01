<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 출금 - 지출신청 결재
+ 프로그램 ID	: a400310_approve.jsp
+ 기 능 정 의	: 지출신청 결재 
+ 최 초 이 력	: 2017.11.02 jys
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a400310_approve_s1, a400310_approve_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% 
   //ContextPath 변수 설정.
   String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정.
   
   String v_dwr_sid  = request.getParameter("v_dwr_sid");	    //
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
var g_row=0;

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
	
	ln_Query(g_WinParam[3] );
	
	/*
	txt_app_teamcd.value = gdeptcd;
	txt_app_teamnm.value = gdeptnm;
	txt_app_empno.value = gusrid;
	txt_app_empnm.value = gusrnm;
	*/
	
	
	
	//인감관리번호 팀명 + 인감기준번호 + 년월 + 순번
	//gcem_signet_mgr_no.text = gs_yymm ;
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// 결재유형 AP005 - 공통모듈쪽 공통코드 읽어오기
	
	ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// 결재상태_D AP003 - 공통모듈쪽 공통코드 읽어오기
	
	gcem_ap_desc.style.background ="#99CC00";
	
	
}
<%
/******************************************************************************
	Description : 조회
******************************************************************************/
%>
function ln_Query(strAp_m_sid){
	
	//지출신청  
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_approve_s0?v_str1="+strAp_m_sid;                                                  
	gcds_data.Reset();
	
	//결재선 MST 조회
	gcds_ap_mst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s2?v_str1="+strAp_m_sid;                                                  
	gcds_ap_mst.Reset();
	
	//신청팀 결재선 조회 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_approve_s1?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
	
	//신청팀 결재선
	_line_chk1:
	for(var i=ds_apline.countrow;i>=1;i--){
		//alert(i+"::AP_TYPE::"+ ds_apline.namevalue(i,"AP_TYPE"));
		if(ds_apline.namevalue(i,"AP_EMPNO")==gs_userid&&ds_apline.namevalue(i,"AP_STATUS_D")=="1"){  // 미결인 경우
			g_ap_sid = ds_apline.namevalue(i,"AP_SID");
			g_row = i;
			break _line_chk1;
		}
	}
}


<%
/******************************************************************************
	Description : 저장
******************************************************************************/
%>
function ln_Save(){
		
	ds_apline.namevalue(g_row,"AP_DESC") = gcem_ap_desc.text;
	if(!ln_Chk_Save())return;
	else if (ds_apline.IsUpdated) {
		if (confirm("입력하신 의견을 등록하시겠습니까?")){
			gctr_data.KeyValue = "Account.a400310_approve_t1(I:USER=ds_apline)";	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_approve_t1";
			gctr_data.Parameters = "v_str1="+gs_userid;
			
			gctr_data.post();
			//ln_Query(gcem_app_no.text);
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
	
	//alert("AP_M_SID::"+gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_M_SID"));
	//alert("g_ap_gu2::"+g_ap_gu2);
    if(!ln_Chk_Apply_1())return;
	
	if (confirm("입력하신 사항을 승인하시겠습니까?")){
		
		ln_Data_Apply_1();
		
		gctr_data.KeyValue = "Account.a400310_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_approve_t2";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_ap_mst',gcds_ap_mst.text);
		//prompt('ds_apline',ds_apline.text);
		gctr_data.post();
	}

}

<% //승인 체크 %>
function ln_Chk_Apply_1(){
	
	//결재상태 체크 
	//SID 체크 
	
	
	/*
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
	*/
	
	return true;
}

<% //승인시 데이터 반영  %>
function ln_Data_Apply_1(){
	
	var sTemp_Ap_type ="";
			
	//for 문으로  마지막 유형을 찾음.....desc로 조회됨. 
	for(var i=1;i<=ds_apline.countrow;i++){
		if(i==1){
			sTemp_Ap_type = ds_apline.namevalue(i,"AP_TYPE");
			//alert("i::"+i+"sTemp_Approve_tpype::"+ds_apline.namevalue(i,"AP_TYPE"));	
		}
	}
	
	//마지막 유형과 현재의 유형이 같으면 최종승인 그렇지 않으면 승인진행함.
	if(sTemp_Ap_type ==ds_apline.namevalue(g_row,"AP_TYPE")){
		gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "3"; //최종승인.
	}else{
		gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "2"; //승인진행
	}
		
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	//결재선
	ds_apline.namevalue(g_row,"AP_STATUS_D") = "3";                            //승인
	ds_apline.namevalue(g_row,"U_EMPNO") = gs_userid;
	ds_apline.namevalue(g_row,"U_IP") ="<%=gusrip%>";
}


<% //반송  전자결재MST, 전자결재DTL %>
function ln_Return(){
	
	//alert("AP_M_SID::"+gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_M_SID"));
	//alert("g_ap_gu2::"+g_ap_gu2);
    if(!ln_Chk_Return_1())return;
	
	if (confirm("반송 하시겠습니까?")){
		
		ln_Data_Return_1();
		
		gctr_data.KeyValue = "Account.a400310_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400310_approve_t2";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_ap_mst',gcds_ap_mst.text);
		//prompt('ds_apline',ds_apline.text);
		
		gctr_data.post();
	}

}

<% //반송 체크 %>
function ln_Chk_Return_1(){
	
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
		
	}

	window.status = "정상적으로 조회되었습니다.";
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
			<b><font size="2" color="blue">&nbsp;◎ 지출 신청 내역</font></b>
		<td>
	</tr>

	<tr>
		<td colspan=2 >
			<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
				<tr>
					<td><nobr>
						<comment id="__NSID__">
				  		<object id=gcgd_data classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='360px' border='1'>
							<param name="dataid"		 value="gcds_data">
							<param name="borderstyle"    value="0">
							<param name="indwidth"       value="0">
							<param name="fillarea"		 value="true">
							<param name="colsizing"      value="true">
							<param name="editable"       value="true">
							<PARAM NAME="viewSummary"	 VALUE="1">
							<param name="format"		 value="   
								<C> Name='신청번호'	  ID=APPNO      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center	SumBgColor='#C3D0DB' edit=none </C>
								<G> Name='업체정보'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	      ID=VENDCD   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='업체명'	      ID=VENDNM   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=180    align=left      SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='사업자번호'   ID=VENDID       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center	SumBgColor='#C3D0DB' edit=none mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</C>
								</G>
								<G> Name='지급정보'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='종류'        ID=PAYKND           HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:수시지급,2:고정지급,3:자동출금,4:지로납부'</C>
								<C> Name='요청일'      ID=REQDATE  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=70     align=center  	SumBgColor='#C3D0DB' edit=none MASK='XXXX/XX/XX'</C>
								<C> Name='지급기준'     ID=PAYGB 		      HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB' edit=none  EditStyle=Combo, Data='1:보통예금,2:현금,3:외화보통예금,4:현금(외화)'</FC>
								<C> Name='금액'		  ID=OUTAMT           HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=right	    SumBgColor='#C3D0DB' edit=none </C>
								</G>
								<G> Name='계좌정보'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='은행'        ID=BANK_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70     align=left  	SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='계좌'        ID=PAYACCTNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	SumBgColor='#C3D0DB' edit=none </C>
								<C> Name='예금주'      ID=ACCT_AUTH   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	SumBgColor='#C3D0DB' edit=none </C>
								</G>
						  	 ">
						</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
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
			  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='100px' border='1'>
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
							<C> Name='의견'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=560    align=left  	edit=none </C>
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
	<C>Col=SIGNET_ID               Ctrl=gcem_signet_id        Param=text</C>
	<C>Col=SIGNET_USE              Ctrl=gcem_signet_use       Param=text</C>
	<C>Col=SIGNET_SUBMIT           Ctrl=gcem_signet_submit    Param=text</C>
	<C>Col=PAPER_CNT               Ctrl=gcem_paper_cnt        Param=text</C>
	<C>Col=SEAL_CNT                Ctrl=gcem_seal_cnt         Param=text</C>
	<C>Col=SIGNET_CERTI_CNT        Ctrl=gcem_signet_certi_cnt Param=text</C>
	<C>Col=REGI_CNT                Ctrl=gcem_regi_cnt         Param=text</C>
	<C>Col=CUR_CAN_GB              Ctrl=gcra_cur_can_gb       Param=codevalue</C>
	<C>Col=SEAL_DATE               Ctrl=gcem_seal_date        Param=text</C>
	<C>Col=SIGNET_MGR_NO           Ctrl=gcem_signet_mgr_no    Param=text</C>
	<C>Col=APP_TEAMCD              Ctrl=txt_app_teamcd        Param=value</C>
	<C>Col=APP_TEAMNM              Ctrl=txt_app_teamnm        Param=value</C>
	<C>Col=APP_JOBCD               Ctrl=txt_app_jobcd         Param=value</C>
	<C>Col=APP_EMPNO               Ctrl=txt_app_empno         Param=value</C>
	<C>Col=APP_EMPNM               Ctrl=txt_app_empnm         Param=value</C>
	<C>Col=APP_DATE                Ctrl=gcem_app_date         Param=text</C>
	<C>Col=REMARK                  Ctrl=gcem_remark           Param=text</C>
	<C>Col=WRID                    Ctrl=txt_wrid              Param=value</C>
	<C>Col=WRDT                    Ctrl=txt_wrdt              Param=value</C>
	<C>Col=UPID                    Ctrl=txt_upid              Param=value</C>
	<C>Col=UPDT                    Ctrl=txt_updt              Param=value</C>
	<C>Col=ATT_FILE_NAME           Ctrl=txt_real_file    	  Param=value</C>
	'>
  </object>
  
  
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>




