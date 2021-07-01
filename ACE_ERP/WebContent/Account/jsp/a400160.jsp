<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인감관리 - 인감날인 신청관리
+ 프로그램 ID	: a400160.jsp
+ 기 능 정 의	: 인감정보
+ 최 초 이 력	: 2017.05.08 jys
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a400160_s1, a400160_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
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
var gs_yymm = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date1  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + "01";
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
    gcds_signet_gb_0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2270&v_str2=&v_str3=&v_str4=C";   
	gcds_signet_gb_0.Reset();	
	
	gcds_ap_status_m.DataID = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP002&s_item1=Y";   
	gcds_ap_status_m.Reset();	
	
	gcem_seal_yymm.text = gs_yymm ; 
	
	gcem_seal_date_fr.text = gs_date1;
	gcem_seal_date_to.text = gs_date2;
	
	ln_Query();
}

<%
/******************************************************************************
	Description : 조회
******************************************************************************/
%>
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400160_s1?v_str1="+gclx_signet_gb_0.bindcolval
			                                                            +"&v_str2="+gcem_seal_date_fr.text
																		+"&v_str3="+gcem_seal_date_to.text
																		+"&v_str4="+gclx_ap_status_m.bindcolval;
   //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


<% //인감증명서 관리번호 UPDATE %>
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("인감증명서 관리번호를 입력하시겠습니까?")){	
			
		gctr_data2.KeyValue = "Account.a400160_t2(I:USER3=gcds_data)";
		gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400160_t2";
		gctr_data2.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_data',gcds_data.text);
		gctr_data2.post();
		ln_Query();
		}	
	}
}

<% //인감증명서 관리번호 UPDATE 체크 %>
function ln_Chk_Save(){
	
	if(gcem_app_no.text==""){
		alert("신청번호가 존재하지 않습니다. 확인하십시요.");
		return false;
	}
	
	
	if(gclx_doc_gu2.bindcolval!="210"){
		alert("법인인감만 인감증명서 관리번호 입력 가능합니다.");
		return false;
	}
	
	return true;
}

<%
/******************************************************************************
	Description : 반출일시저장
******************************************************************************/
%>
function ln_Send(){
	if(!ln_Chk_Send())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("반출일시를 입력하시겠습니까?")){	
			
		His_Data_Add('S');		
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400160_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_data',gcds_data.text);
		//prompt('gcds_data_his',gcds_data_his.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

<%
/******************************************************************************
	Description : 반출체크
******************************************************************************/
%>
function ln_Chk_Send() {
    //필수항목 체크     
    
    if(gcem_send_date_confirm.text!=""){
    	alert("이미 반출확인 했습니다. ");
    	return false;
    }
    
	
	return true;
}

<%
/******************************************************************************
	Description : 반출일시저장
******************************************************************************/
%>
function ln_Receive(){
	if(!ln_Chk_Receive())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("반입일시를 입력하시겠습니까?")){	
			
		His_Data_Add('R');		
		gctr_data.KeyValue = "Account.a400160_t1(I:USER3=gcds_data,I:USER4=gcds_data_his)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400160_t3";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_data',gcds_data.text);
		//prompt('gcds_data_his',gcds_data_his.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Receive() {
    //필수항목 체크     
    
    if(gcem_receive_date.text!=""){
    	alert("이미 반입확인 했습니다. ");
    	return false;
    }
    
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){
			
			//결재상태가 최종승인 건만 처리 가능 
			if(gcds_data.namevalue(i,"AP_STATUS_M") != "3"){ 			
				alert("결재상태가 최종승인건만 반입 처리 가능합니다.");
				return false;
			}
		}
	} 
    	
	return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
}

<%	
/******************************************************************************
	Description : 삭제
******************************************************************************/
%>
function ln_Delete(){
	
}

<%//리포트 head생성%>
function fnReportSetDataHeader() {
	 var s_temp = "SEAL_YYMM:STRING";
	 gcds_rptmst.SetDataHeader(s_temp);
}

<%
/******************************************************************************
	Description : 출력
******************************************************************************/
%>
function ln_Print(){

    var str_seal_date_fr="";
    var str_seal_date_to="";
	
    if(gclx_signet_gb_0.bindcolval!="1"&&gclx_signet_gb_0.bindcolval!="2"){
		alert("인감구분을 선택하십시요.");
		return false;
	}
    
	if(gclx_signet_gb_0.bindcolval==""){
    	alert("출력시 인감구분은 필수 항목입니다.");
    	return false;
    }

    if(gcem_seal_yymm.text==""){
    	alert("출력시 날인년월은 필수 항목입니다.");
    	return false;
    }
    
    
    str_seal_date_fr = gcem_seal_yymm.text+"01";
    str_seal_date_to = gcem_seal_yymm.text+"31";
    
    
    gcds_rptdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400160_s1?v_str1="+gclx_signet_gb_0.bindcolval
																	      +"&v_str2="+str_seal_date_fr
																		  +"&v_str3="+str_seal_date_to
																		  +"&v_str4=3";
	//prompt('',gcds_rptdtl.DataID);
	gcds_rptdtl.Reset();
    
	fnReportSetDataHeader();
	gcds_rptmst.addrow();

	gcds_rptmst.namevalue(gcds_rptmst.rowposition,"SEAL_YYMM")= gcem_seal_yymm.text;
	
	if(gclx_signet_gb_0.bindcolval=="1"){
		gcrp_print.preview();	
	}else if (gclx_signet_gb_0.bindcolval=="2"){
		gcrp_print2.preview();
	}
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
function His_Data_Add(strGB){
	
	var hrow=0;
	His_SetDataHeader();
	
	//사용인감id 중 사용건.
	gcds_signet_info.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_s2?v_str1="+gcds_data.namevalue(gcds_data.rowposition,"SIGNET_ID");
	gcds_signet_info.Reset();
	
	for(var i=1;i<=gcds_signet_info.countrow;i++){
		
		gcds_data_his.AddRow();
		hrow = gcds_data_his.rowposition;
		
		gcds_data_his.namevalue(hrow,"SIGNET_ID")     = gcds_signet_info.namevalue(i,"SIGNET_ID");
		gcds_data_his.namevalue(hrow,"SIGNET_SEQ")    = 0;
		gcds_data_his.namevalue(hrow,"MGR_TEAMCD")    = gcds_signet_info.namevalue(i,"MGR_TEAMCD");
		gcds_data_his.namevalue(hrow,"MGR_TEAMNM")    = gcds_signet_info.namevalue(i,"MGR_TEAMNM");
		gcds_data_his.namevalue(hrow,"MAIN_EMPID")    = gcds_signet_info.namevalue(i,"MAIN_EMPID");
		gcds_data_his.namevalue(hrow,"SUB_EMPID")     = gcds_signet_info.namevalue(i,"SUB_EMPID");
		gcds_data_his.namevalue(hrow,"SEND_DATE")     = "";
		gcds_data_his.namevalue(hrow,"DISUSE_DATE")   = "";
		gcds_data_his.namevalue(hrow,"DISUSE_REASON") = "";
		gcds_data_his.namevalue(hrow,"RECE_DATE")     = "";
		gcds_data_his.namevalue(hrow,"RECE_REASON")   = "";
		gcds_data_his.namevalue(hrow,"USEGB")         = gcds_signet_info.namevalue(i,"USEGB");
		gcds_data_his.namevalue(hrow,"USE_REMARK")    = "";
		gcds_data_his.namevalue(hrow,"ETC")           = "";
		gcds_data_his.namevalue(hrow,"WRID")          = "";
		
		gcds_data_his.namevalue(hrow,"SEND_DATE_CONFIRM") = "";
		gcds_data_his.namevalue(hrow,"RECEIVE_DATE")="";

		if(strGB=="S"){
			gcds_data_his.namevalue(hrow,"WORK_GB")="4";//반출일자
		}else if(strGB=="R"){
			gcds_data_his.namevalue(hrow,"WORK_GB")="5";//반입일자
		}
	}
}

<%//법인인감 팝업%>
function ln_Popup_Signet_Cor(row){
	
	var result="";
    var arrParam	= new Array();
    var arrResult	= new Array();
    //alert("AP_M_SID::"+gcds_data.namevalue(row,"AP_M_SID"));
	
	arrParam[0]=gcds_data.namevalue(row,"DOC_GU2");    //210                        
	arrParam[1]=gcds_data.namevalue(row,"DOC_SID");    //요청SID      3000 
	arrParam[2]="";                                    //결재선정보 
	arrParam[3]=gcds_data.namevalue(row,"AP_M_SID");   //결재마스터 SID 12159
	arrParam[4]=gcds_data.namevalue(row,"CH_PARAM1");  //신청번호
	strURL = "<%=dirPath%>/Account/jsp/a400140_approve_view.jsp";
	strPos = "dialogWidth:1020px;dialogHeight:700px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);
}

<%//사용인감 팝업%>
function ln_Popup_Signet_Use(row){
	var result="";
    var arrParam	= new Array();
    var arrResult	= new Array();
    
    //alert("AP_M_SID::"+gcds_data.namevalue(row,"AP_M_SID"));
	
	arrParam[0]=gcds_data.namevalue(row,"DOC_GU2");    //220                        
	arrParam[1]=gcds_data.namevalue(row,"DOC_SID");    //요청SID      3000 
	arrParam[2]="";                                    //결재선정보 
	arrParam[3]=gcds_data.namevalue(row,"AP_M_SID");   //결재마스터 SID 12159
	arrParam[4]=gcds_data.namevalue(row,"CH_PARAM1");  //신청번호
	strURL = "<%=dirPath%>/Account/jsp/a400150_approve_view.jsp";
	strPos = "dialogWidth:1020px;dialogHeight:700px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);
}

<%//날인년월%>
function ln_Seal_yymm() {
	
	if(gcem_seal_yymm.text==""){
		
		gcem_seal_date_fr.text = "";
		gcem_seal_date_to.text = "";
	}else{
			
		__GetCallMonth('gcem_seal_yymm', 'Text');
		
		gcem_seal_date_fr.text = gcem_seal_yymm.text+"01";
		gcem_seal_date_to.text = gcem_seal_yymm.text+"31";
		
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
	
	<object id=gcds_data_his classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</object>
	
	<object id=gcds_signet_gb_0 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
	
	<object id=gcds_ap_status_m classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
	
	<object id=gcds_signet_info classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
	
	<object id=gcds_rptmst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
	
	<object id=gcds_rptdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
 	<object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a400160_t1(I:USER3=gcds_data,I:USER4=gcds_data_his)">
	</object>

	<object id=gctr_data2 classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	</object>
</comment><script>__ws__(__NSID__);</script>

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
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="전체";
    gclx_signet_gb_0.index = 0;
</script>

<script language="javascript" for="gcds_ap_status_m" event="onloadCompleted(row,colid)">
	gcds_ap_status_m.InsertRow(1);
	gcds_ap_status_m.NameValue(1,"DETAIL")="";
	gcds_ap_status_m.NameValue(1,"DETAIL_NM")="전체";
	gclx_ap_status_m.index = 0;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcgd_data event=OnDblClick(row,colid)>
	if (colid !="CHKBOX") {

	 	if(gcds_data.namevalue(row,"DOC_GU2")=="210"){
	 		//alert("법인인감");
	 		ln_Popup_Signet_Cor(row);
	 	}else if(gcds_data.namevalue(row,"DOC_GU2")=="220"){
	 		//alert("사용인감");
	 		ln_Popup_Signet_Use(row);
	 	}
	}
 </script>
 
 <script language="javascript"  for=gcgd_data event="OnClick(row,colid)">
	if (colid =="CHKBOX") {
		
		if(gcds_data.namevalue(row,"CHKBOX") != "T"){
			gcds_data.namevalue(row,"CHKBOX") = "T";
		}else{
			gcds_data.Undo(row);
		}
			
		for (var i=1; i<=gcds_data.countrow;i++) {
			if(i != row && gcds_data.namevalue(i,"CHKBOX") == "T") {
				//gcds_data.namevalue(i,"CHKBOX") = "F";
				gcds_data.Undo(i);
			}
		}
	
		if(gcds_data.namevalue(row,"DOC_GU2")=="210"){// 법인인감을 경우
			
			gcem_send_date_confirm.readonly = true;
			gcem_receive_date.readonly = true;
			
			if(gcds_data.namevalue(row,"CHKBOX") == "T"){
				gcem_signet_certi_no.readonly= false;
			}else{
				gcem_signet_certi_no.readonly= true;
			}
		}else if (gcds_data.namevalue(row,"DOC_GU2")=="220"){  //사용인감.
			gcem_signet_certi_no.readonly= true;
			
		    if(gcds_data.namevalue(row,"CHKBOX") == "T"){	
				gcem_send_date_confirm.readonly = false;
				gcem_receive_date.readonly = false;
			}else{
				gcem_send_date_confirm.readonly = true;
				gcem_receive_date.readonly = true;
			}
		}
	}
</script>
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

<script language="javascript" for="gctr_data2" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data2" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"	style="cursor:hand" onClick="ln_Print()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
	 	<td colspan=2>
			<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="70px" align=center  bgcolor="#eeeeee" class="tab15" >검색</td>
					<td width="70px;" class="tab18"  bgcolor="#eeeeee" align="center">인감구분</td>
					<td width="130px"  class="tab18"  align=left  >
				    	<comment id="__NSID__">
							<object  id=gclx_signet_gb_0  classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
									<param name=ComboDataID      value="gcds_signet_gb_0">
									<param name=CBDataColumns	 value="CDCODE,CDNAM">
									<param name=SearchColumn	 value="CDNAM">
									<param name=Sort			 value=true>
									<param name=SortColumn       value="CDCODE">
									<param name=ListExprFormat   value="CDNAM^0^100">								
									<param name=BindColumn		 value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					
					<td width="70px"  class="tab18"  bgcolor="#eeeeee" align=center >날인년월</td>
					<td class="tab18" >&nbsp;
						<comment id="__NSID__">
							<object  id=gcem_seal_yymm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:0px;width:55px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment      value=0>
							<param name=Border          value=true>
							<param name=Format           value="YYYY/MM">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
						</comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Seal_yymm()" style="position:relative;width:20px;top:3px;left:0px;cursor:hand;">  
					</td> 
					
					<td width="70px;" class="tab18"  bgcolor="#eeeeee" align="center">날인일자</td>
					<td width="250px"  class="tab18"  align=left  >
				    	<comment id="__NSID__">
							<object  id=gcem_seal_date_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_seal_date_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					    ~
					    <comment id="__NSID__">
							<object  id=gcem_seal_date_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_seal_date_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					
					<td class="tab18" width="70px;" bgcolor="#eeeeee" align="center">결재상태</td>
					<td class="tab18" >&nbsp;
						<comment id="__NSID__">
							<object  id=gclx_ap_status_m classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:-2px;top:2px;font-size:12px;width:100px;">
									<param name=ComboDataID      value="gcds_ap_status_m">
									<param name=CBDataColumns	 value="DETAIL,DETAIL_NM">
									<param name=SearchColumn	 value="DETAIL_NM">
									<param name=Sort			 value=true>
									<param name=SortColumn       value="DETAIL">
									<param name=ListExprFormat   value="DETAIL_NM^0^100">								
									<param name=BindColumn		 value="DETAIL">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td> 	 
				</tr>
				
			</table>
		</td>
	<tr>
		<td colspan=2 height="2"></td>
	</tr>	
	<tr>
		<td colspan=2>
			<!--Grid-->
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:998px;border:0 solid #708090;">
				<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__">
						<object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_data style="WIDTH:998px;HEIGHT:350px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"		VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="true">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="sortview"     value=left>
						 <PARAM NAME="Editable"		VALUE="true">
					     <PARAM NAME="Format"		VALUE="  
							<C>ID=SysSts name=SysStatus width=70 Value={SysStatus}     Align=Center  show = false </C>
							
							<FC>ID=CHKBOX	          Name=선택,	            width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false EditStyle=CheckBox </FC>
							<FG> Name='인감정보'      HeadAlign=Center    HeadBgColor=#B9D4DC
							<FC>ID=DOC_GU2            Name=구분,    	        width=55,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none EditStyle=Combo,  Data='210:법인인감,220:사용인감'</FC>
							<FC>ID=APP_NO             Name=신청번호,          width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none </FC>
							<FC>ID=SIGNET_ID          Name=ID,    	        width=40,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none </FC>
							<FC>ID=SIGNET_MGR_NO      Name=관리번호,          width=135,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none </FC>
							</FG>
							<C> ID=APP_TEAMNM         Name=신청팀,	        width=75,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true  edit=none  </C>
							<C> ID=APP_EMPNM          Name=신청자,	        width=75,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true  edit=none  </C>
							<C> ID=APP_DATE           Name=신청일자,	        width=75,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none MASK='XXXX/XX/XX' </C>
							<C> ID=SEAL_DATE          Name=날인일자,    	    width=75,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none MASK='XXXX/XX/XX' </C>
							<C> ID=SEND_DATE_CONFIRM  Name=반출일시,    	    width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none  </C>
							<C> ID=RECEIVE_DATE       Name=반입일시,    	    width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none  </C>
							<C> ID=SIGNET_USE         Name=용도,       	    width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none </C>
							<C> ID=SIGNET_SUBMIT      Name=제출처,       	    width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none </C>
							<C> ID=SIGNET_CERTI_NO    Name=인감증명서\\관리번호, width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none </C>
							<C> ID=REMARK             Name=비고,       	     width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none </C>
							<C> ID=AP_STATUS_M_NM     Name=결재상태,           width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false edit=none </C>
						">
					 	</object></comment><script>__ws__(__NSID__);</script> 
					</td>
			  	</tr>
			 </table>
		</td>
	</tr>	
	<tr>
		<td colspan=2 height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
	</tr>	
	
	<tr>
		<td colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:998px;border:0 solid #708090;">
				<tr> 			
					<td colspan=2><font size="2" color="blue" ><strong>[ 관리자 처리 내역 - 반출일시, 반입일시, 인감증명서 관리번호 ]</strong></font>&nbsp;
			  	</tr>
			  	 <tr height='25px'>
			    	<td style="position:relative;left:0px;" colspan=2>
			    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
			    			<tr>                                                                     
			                    <td align="center" class="text" width="120">구분</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                      	<comment id="__NSID__">
										<object  id=gclx_doc_gu2 classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:-2px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			        value="210^법인인감,220^사용인감">
											<param name=CBDataColumns	 		value="CODE,NAME">
											<param name=SearchColumn	     	value=NAME>
											<param name=Sort			        value=false>
											<param name=ListExprFormat       	value="NAME">								
											<param name=BindColumn		     	value="CODE">
											<param name=Enable                  value="false">
										</object>
									</comment><script>__ws__(__NSID__);</script>   
			                    </td>
			                    <td align="center" class="text" width="120">신청번호</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_app_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:0px;top:2px;width:100px;height:20px;" class="txtbox">
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
			                 </tr>
			                 <tr>
			                    <td align="center" class="text" width="120">반출일시</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_send_date_confirm classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:120px;height:20px;position:relative;left:0px;top:2px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD HH:NN">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#C0C0C0">
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_send_date_confirm', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_send.gif"	style="cursor:hand" onclick="ln_Send()">
			                    </td>
			                    <td align="center" class="text" width="120">반입일시</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_receive_date classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:120px;height:20px;position:relative;left:0px;top:2px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD HH:NN">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#C0C0C0">
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_receive_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
									
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_send.gif"	style="cursor:hand" onclick="ln_Receive()">
									
			                    </td>
			                 </tr>
			                  <tr>
			                    <td align="center" class="text" width="120">인감증명서 관리번호</td>
			                    <td bgcolor="#FFFFFF" colspan=3>&nbsp;
			                      	<comment id="__NSID__">
									<object id=gcem_signet_certi_no classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:300px;height:20px;position:relative;left:0px;top:2px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#C0C0C0">
                                    <param name=GeneralEdit   value="true">
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									&nbsp;
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_save.gif"	style="cursor:hand" onclick="ln_Save()">
			                    </td>
			                 </tr>
			       		</table>
			       	</td>
			 	</tr>
			 </table>
		</td>
	</tr>	
</table>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
 <object id="gcrp_print" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"		value="gcds_rptmst">
	<param name="DetailDataID"		value="gcds_rptdtl">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"    value="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="MargineY"          value="100">
	<param name="SuppressColumns"	value="1:pageskip,APP_TEAMNM">
	<param name="Format"			value="
    <B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=373 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=1897 ,top=95 ,right=2831 ,bottom=373 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='담  당' ,left=1902 ,top=98 ,right=2127 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=2135 ,top=98 ,right=2360 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=2368 ,top=98 ,right=2593 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승  인' ,left=2601 ,top=98 ,right=2826 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=153 ,right=2826 ,bottom=153 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1897 ,top=302 ,right=2826 ,bottom=302 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2006 ,top=310 ,right=1982 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2707 ,top=307 ,right=2683 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2482 ,top=310 ,right=2458 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2246 ,top=307 ,right=2223 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2365 ,top=95 ,right=2365 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2130 ,top=93 ,right=2130 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2596 ,top=93 ,right=2596 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='법인인감 날인대장' ,left=706 ,top=201 ,right=1349 ,bottom=325 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SEAL_YYMM', left=1339, top=235, right=1749, bottom=296, align='left' ,mask='( XXXX 년 XX 월)', face='굴림', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=317 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='관리번호' ,left=169 ,top=204 ,right=402 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청팀' ,left=410 ,top=204 ,right=638 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='날인내역' ,left=987 ,top=204 ,right=1654 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='날인' ,left=918 ,top=212 ,right=982 ,bottom=259 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='횟수' ,left=918 ,top=254 ,right=982 ,bottom=302 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='날인사본' ,left=1659 ,top=212 ,right=1871 ,bottom=259 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보관장소' ,left=1659 ,top=254 ,right=1871 ,bottom=302 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제출처' ,left=1879 ,top=204 ,right=2146 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인감증명서' ,left=2151 ,top=212 ,right=2416 ,bottom=259 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리번호' ,left=2151 ,top=254 ,right=2416 ,bottom=302 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='APP_TEAMNM', left=164, top=95, right=574, bottom=156, align='left', face='굴림', size=14, bold=false, underline=true, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=164 ,top=198 ,right=164 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=407 ,top=198 ,right=407 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=984 ,top=198 ,right=984 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1656 ,top=198 ,right=1656 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=198 ,right=2828 ,bottom=198 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=312 ,right=2828 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1876 ,top=198 ,right=1876 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=198 ,right=2151 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2421 ,top=198 ,right=2421 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=198 ,right=2831 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=640 ,top=198 ,right=640 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=915 ,top=198 ,right=915 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=751 ,top=198 ,right=751 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='비고' ,left=2424 ,top=204 ,right=2823 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청자' ,left=643 ,top=204 ,right=749 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='날인일자' ,left=754 ,top=204 ,right=915 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=101 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=164 ,top=85 ,right=2828 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SIGNET_MGR_NO', left=169, top=3, right=402, bottom=79 ,mask='XX-XX-XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='APP_TEAMNM', left=410, top=3, right=638, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEAL_CNT', left=918, top=3, right=982, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SIGNET_USE', left=987, top=3, right=1654, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SIGNET_SUBMIT', left=1879, top=3, right=2146, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SIGNET_CERTI_NO', left=2151, top=3, right=2418, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=2426, top=3, right=2826, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=164 ,top=0 ,right=164 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=407 ,top=0 ,right=407 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=640 ,top=0 ,right=640 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=915 ,top=0 ,right=915 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=984 ,top=0 ,right=984 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1656 ,top=0 ,right=1656 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1876 ,top=0 ,right=1876 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=0 ,right=2151 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2421 ,top=0 ,right=2421 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=0 ,right=2831 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='APP_EMPNM', left=643, top=3, right=749, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=751 ,top=0 ,right=751 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SEAL_DATE', left=754, top=3, right=915, bottom=79 ,mask='XXXX.XX.XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='자체보관' ,left=1659 ,top=40 ,right=1871 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PLACE', left=1659, top=3, right=1871, bottom=45, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
</B>
">
</object>

<object id="gcrp_print2" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"		value="gcds_rptmst">
	<param name="DetailDataID"		value="gcds_data">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"    value="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="MargineY"          value="100">
	<param name="SuppressColumns"	value="1:pageskip,APP_TEAMNM">
	<param name="Format"			value="
   <B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=373 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=1897 ,top=95 ,right=2831 ,bottom=373 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='담  당' ,left=1902 ,top=98 ,right=2127 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=2135 ,top=98 ,right=2360 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=2368 ,top=98 ,right=2593 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승  인' ,left=2601 ,top=98 ,right=2826 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=153 ,right=2826 ,bottom=153 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1897 ,top=302 ,right=2826 ,bottom=302 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2006 ,top=310 ,right=1982 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2707 ,top=307 ,right=2683 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2482 ,top=310 ,right=2458 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2246 ,top=307 ,right=2223 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2365 ,top=95 ,right=2365 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2130 ,top=93 ,right=2130 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2596 ,top=93 ,right=2596 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='사용인감 날인대장' ,left=706 ,top=201 ,right=1349 ,bottom=325 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SEAL_YYMM', left=1339, top=235, right=1749, bottom=296, align='left' ,mask='( XXXX 년 XX 월)', face='굴림', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=312 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='날인사본' ,left=1725 ,top=212 ,right=1937 ,bottom=259 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보관장소' ,left=1725 ,top=254 ,right=1937 ,bottom=302 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제출처' ,left=1945 ,top=204 ,right=2212 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='APP_TEAMNM', left=164, top=95, right=574, bottom=156, align='left', face='굴림', size=14, bold=false, underline=true, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=164 ,top=198 ,right=164 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=508 ,top=198 ,right=508 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1720 ,top=198 ,right=1720 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=198 ,right=2828 ,bottom=198 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=312 ,right=2828 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1939 ,top=198 ,right=1939 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2215 ,top=198 ,right=2215 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=198 ,right=2831 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=699 ,top=198 ,right=699 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=984 ,top=198 ,right=984 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=812 ,top=198 ,right=812 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='신청자' ,left=704 ,top=204 ,right=810 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='날인일자' ,left=818 ,top=204 ,right=979 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용내역' ,left=990 ,top=204 ,right=1717 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2521 ,top=243 ,right=2521 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='신청팀' ,left=513 ,top=204 ,right=693 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='반입일시' ,left=2527 ,top=259 ,right=2826 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='반출일시' ,left=2220 ,top=259 ,right=2519 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2828 ,top=254 ,right=2215 ,bottom=254 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='반출/반입' ,left=2220 ,top=206 ,right=2820 ,bottom=254 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리번호' ,left=169 ,top=204 ,right=503 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=84 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=164 ,top=85 ,right=2828 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SIGNET_SUBMIT', left=1945, top=3, right=2212, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=164 ,top=0 ,right=164 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=0 ,right=2831 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='자체보관' ,left=1725 ,top=40 ,right=1937 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PLACE', left=1725, top=3, right=1937, bottom=45, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='SIGNET_USE', left=990, top=3, right=1717, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RECEIVE_DATE', left=2527, top=3, right=2826, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2521 ,top=0 ,right=2521 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SEND_DATE_CONFIRM', left=2220, top=3, right=2519, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2215 ,top=0 ,right=2215 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1939 ,top=0 ,right=1939 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1720 ,top=0 ,right=1720 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=984 ,top=0 ,right=984 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SEAL_DATE', left=818, top=3, right=979, bottom=79 ,mask='XXXX.XX.XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=812 ,top=0 ,right=812 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='APP_EMPNM', left=704, top=3, right=810, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=699 ,top=0 ,right=699 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='APP_TEAMNM', left=513, top=3, right=693, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=508 ,top=0 ,right=508 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SIGNET_MGR_NO', left=169, top=3, right=503, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>

">
</object>

</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp2 classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=DOC_GU2               Ctrl=gclx_doc_gu2             Param=bindcolval</C>
	<C>Col=APP_NO                Ctrl=gcem_app_no              Param=text</C>
	<C>Col=SEND_DATE_CONFIRM     Ctrl=gcem_send_date_confirm   Param=text</C>
	<C>Col=RECEIVE_DATE          Ctrl=gcem_receive_date        Param=text</C>
	<C>Col=SIGNET_CERTI_NO       Ctrl=gcem_signet_certi_no     Param=text</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



