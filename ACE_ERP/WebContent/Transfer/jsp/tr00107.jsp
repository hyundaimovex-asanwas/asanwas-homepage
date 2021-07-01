<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	물류관리 - 반출배차관리
+ 프로그램 ID	: TR00107.HTML
+ 기 능 정 의	: 조회,저장,엑셀
+ 변 경 이 력	: 
+ 서 블 릿 명	: 
------------------------------------------------------------------------------
+ 수 정 내 용  :  EDI 관련 수신 팝업 추가
+ 수   정  자  :  정영식
+ 수 정 일 자  :  2008. 10. 21
----------------------------------------------------------------------------->
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	get_cookdata();
	//lfn_init();
	
	var lb_boolean1 =  false ; 
	var lb_allocation = false ; 
	
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!


			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			Start();//선조회

			window.status="완료";

		}

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/

	function Start(){

			gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
			gcDs_etc1.Reset();
			
			gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //적재구분 
			gcDs_etc5.Reset();
			
			gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
			gcDsgetdate.Reset() ;

		if(gcDsgetdate.CountRow > 0 ) {
			FROM_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 
			gcem_yymm_to.Text = gcDsgetdate.NameValue(1,"APP_DT1") ;  
		}

			
	}

	/******************************************************************************
		Description :  조회
	******************************************************************************/ 
	function ln_Query(){
	
		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPerson?NOH=Y";  //운전자정보
		gcDs_etc2.Reset();

		var parm = "&gstr0=O"
						 + "&gstr1=" + CAR_SEQ_NO.Text
						 + "&gstr2=" + FROM_DATE.Text
						 + "&gstr3=" + FROM_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr5=" + ORDER_NO.Text
						 + "&gstr7=O";

		btn_check.checked = false;

		gcDs1.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsList?NOH=Y"+parm ; 
		gcDs1.Reset() ; 
		
	}

	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoice(obj){
	
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "=선택 or 입력=" ;   
	}

	/******************************************************************************
		Description : 일괄적용
	******************************************************************************/
	function ln_ChkB(){
	
		var pam1 = new Array("gcem_time_to","gcem_yymm_to","gcem_time_to1");
		var pam2 = new Array("START_TIME","RTRN_DATE","RTRN_TIME");

		if (gcDs1.countrow<1) return;

		if (btn_check.checked) {
			for (var i=0; i<pam1.length; i++) {
				for (var j=0; j<=gcDs1.countrow; j++){
					gcDs1.namevalue(j,pam2[i]) = eval(pam1[i]).text;
				}
			}
		}	else {
			for (var i=0; i<pam1.length; i++) {
				for (var j=0; j<=gcDs1.countrow; j++){
					gcDs1.namevalue(j,pam2[i]) = "";
				}
			}
		}
	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
	
		if (gcDs1.isUpdated){
		
			if (!ln_ChkData()) return;

			if (confirm("입력하신 정보를 저장하시겠습니까 ?  ")) {

				gcDs2.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsList?NOH=N"; 
				gcDs2.Reset() ; 

				if(gcDs2.countrow < 1){

				}
				
				for (var i=1; i<=gcDs1.countrow; i++){
					if (gcDs1.namevalue(i,"CAR_NO")!="") gcDs1.namevalue(i,"CAR_TYPENM") = Grid1.VirtualString(i,"CARTYPENO");
				}
				
        for (var j=1; j<=gcDs1.countrow; j++) {
        
					if (gcDs1.namevalue(j,"START_TIME")!="" && gcDs1.namevalue(j,"CAR_NO")!="" ) gcDs2.ImportData(gcDs1.ExportData(j,1,false));
				}


				var cnt = gcDs2.countrow+1;

				for (var s=cnt; s<=gcDs2.countrow; s++) gcDs2.namevalue(s,"IN_OUT") = "I";

				var sdate = gcDs1.namevalue(1,"EDT_DATE");
				
				var sparm = "v_str1=" + sdate.substring(2,8) +
										",v_str2=" + sdate +
										",v_str3=" + gusrid
										",v_str4=" + LINE_PART.BindColVal;

				gcDs2.SortExpr = "+CAR_SEQ_NO+START_TIME-IN_OUT";
				
				gcDs2.Sort();

				gctr_data.KeyValue = "tr00107_t1(I:DATA=gcDs2)";
				
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00107_t1";

				gctr_data.Parameters = sparm;
				
				gctr_data.post();

				gcDs2.SortExpr = "";
				
				gcDs2.Sort();

			}
		}
	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_ChkData(){
		var row = gcDs1.countrow;

		var parm = "&gstr1="+CAR_SEQ_NO.Text ; 
				parm = parm + "&gstr2="+gcDs3.namevalue(1,"EDT_DATE");
				parm = parm + "&gstr4="+LINE_PART.BindColVal ; 
				parm = parm + "&gstr5="+ORDER_NO.Text ; 
				parm = parm + "&gstr7=I"; 

		gcDs3.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00107_s1?NOH=Y"+parm ; 
		gcDs3.Reset() ; 

		var prow = 0;
		for (var j=1; j<=row; j++) {
			if (gcDs1.sysStatus(j)=="3") {
				prow = j;
				break;
			}
		}

		for (var j=1; j<=row; j++) {
			if (gcDs1.sysStatus(j)=="3") {

				var stime = fRtrim(gcDs1.namevalue(j,"START_TIME"));
				if (stime=="" || stime.length<4) {
					alert("출발시간을 정확히 입력해 주십시오.");
					return false;
				}

				var rdate = fRtrim(gcDs1.namevalue(j,"RTRN_DATE"));
				if (rdate=="" || rdate.length<8) {
					alert("복귀일자를 정확히 입력해 주십시오.");
					return false;
				}

				var rtime = fRtrim(gcDs1.namevalue(j,"RTRN_TIME"));
				if (rtime=="" || rtime.length<4) {
					alert("복귀시간을 정확히 입력해 주십시오.");
					return false;
				}

				var sdate = fRtrim(gcDs1.namevalue(j,"EDT_DATE"));
				var sdt = sdate + stime;
				var rdt = rdate + rtime;
				if (sdt>=rdt) {
					alert("복귀일시는 출발일시 보다 이후여야 합니다.");
					return false;
				}

				if (gcDs1.namevalue(1,"LINE_PART")!=gcDs1.namevalue(j,"LINE_PART")) {
					alert("동일한 프로젝트를 선택해 주십시오.");
					return false;
				}

				for (var k=1; k<=row; k++){
					if (gcDs1.namevalue(k,"CAR_NO")!="") {
						if (j!=k) {

							if (gcDs1.namevalue(k,"CAR_NO")==gcDs1.namevalue(j,"CAR_NO") && gcDs1.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //출발일시
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //복귀일시
								var v3 = gcDs1.namevalue(k,"EDT_DATE") + gcDs1.namevalue(k,"START_TIME"); //출발일시
								var v4 = gcDs1.namevalue(k,"RTRN_DATE") + gcDs1.namevalue(k,"RTRN_TIME"); //복귀일시
								
							}

							if (gcDs1.namevalue(k,"PERSON_NO")==gcDs1.namevalue(j,"PERSON_NO")  && gcDs1.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {

						
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //출발일시
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //복귀일시
								var v3 = gcDs1.namevalue(k,"EDT_DATE") + gcDs1.namevalue(k,"START_TIME"); //출발일시
								var v4 = gcDs1.namevalue(k,"RTRN_DATE") + gcDs1.namevalue(k,"RTRN_TIME"); //복귀일시
								
								if (v3<=v1) {						
									if (v4>v1) {

									if (gcDs1.namevalue(j,"PERSON_NO")!="") {
										alert("동일인은 지정하실 수 없습니다.");
										return false;
									}

									}
								}
							}
						}
					}
				}

				for (var k=1; k<=gcDs3.countrow; k++){
					if (gcDs3.namevalue(k,"CAR_NO")!="") {

						if (gcDs1.namevalue(j,"ACCESS_NO")!=gcDs3.namevalue(k,"ACCESS_NO")){
							if (gcDs3.namevalue(k,"CAR_NO")==gcDs1.namevalue(j,"CAR_NO") && gcDs3.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //출발일시
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //복귀일시
								var v3 = gcDs3.namevalue(k,"EDT_DATE") + gcDs3.namevalue(k,"START_TIME"); //출발일시
								var v4 = gcDs3.namevalue(k,"RTRN_DATE") + gcDs3.namevalue(k,"RTRN_TIME"); //복귀일시

								if (v3<=v1) {
									if (v4>v1) {
										alert(gcDs3.namevalue(k,"CAR_NO") + " 차량은 지정하실 수 없습니다.");
										return false;
									}
								}
							}

							if (gcDs3.namevalue(k,"PERSON_NO")==gcDs1.namevalue(j,"PERSON_NO") && gcDs3.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //출발일시
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //복귀일시
								var v3 = gcDs3.namevalue(k,"EDT_DATE") + gcDs3.namevalue(k,"START_TIME"); //출발일시
								var v4 = gcDs3.namevalue(k,"RTRN_DATE") + gcDs3.namevalue(k,"RTRN_TIME"); //복귀일시
								
								if (v3<=v1) {
									if (v4>v1) {
										alert("동일인은 지정하실 수 없습니다.");
										return false;
									}
								}
							}
						}
					}
				}
			}
		}

		return true;
	}

	/******************************************************************************
		Description : 출발 & 복귀일자 셋팅
	******************************************************************************/
	function ln_Callendar(){
		__GetCallCalendar('FROM_DATE', 'Text');
		gcem_yymm_to.text = FROM_DATE.text;
	}

 	/******************************************************************************
		Description : 출발 & 복귀일자 셋팅
	******************************************************************************/
	function ln_Cancel(){
		for(i=1;i<=gcDs1.countrow; i++){
			if(gcDs1.NameValue(i,"CHECK")=="T"){
				gcDs1.NameValue(i,"CAR_NO")  = ""; //차량번호
				gcDs1.NameValue(i,"PERSON_NO")  = ""; 
			}
		}
  }


 /******************************************************************************
		Description : 배차수신
 *****************************************************************************/
 function ln_EDI_Receive(){
 		var strURL = "tr00104_EDI_Receive.jsp";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();
		
		arrParam[0]="B"; //배차
		
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
 }

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1	classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"			VALUE="false">
</OBJECT>

<OBJECT id=gcDs2	classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"			VALUE="true">
</OBJECT>

<OBJECT id=gcDs3	classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"			VALUE="true">
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="false">
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="true">
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="false">
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>

<script language=JavaScript for=Grid1 event=OnPopup(row,colid,data)>

	var car_type = gcDs1.NameValue(gcDs1.RowPosition,"CARTYPENO") ; 
	
	var result = window.showModalDialog('tr00106_e1.jsp?gstr1='+car_type,window,"dialogWidth:500px; dialogHeight:580px");
	if( result != null ) {
		gcDs1.NameValue(gcDs1.RowPosition,"CAR_NO")  = result[0]; //차량번호
		gcDs1.NameValue(gcDs1.RowPosition,"PERSON_NO")  = result[1]; 
	}
	
</script>

<script language=JavaScript for=gctr_data event=OnSuccess()>
	gcDs1.Reset();
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=FROM_DATE event=onKeyUp(kcode,scode)>
	gcem_yymm_to.text = FROM_DATE.text;
</script>

<script language="javascript"  for=Grid1 event=OnClick(row,colid)>

    if(row>0){
			if(colid =="CHECK"){		  
				 if(gcDs1.namevalue(row,"CHECK")=="T"){
						gcDs1.namevalue(row,"CHECK")="F";
				 }else{
            gcDs1.namevalue(row,"CHECK")="T";
				 }
			}
		}else{

		}
 </script>
 
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="../../../Common/img/btn/btn_edi_re.gif"  style="cursor:hand" onclick="ln_EDI_Receive()">
				<img src="../../../Common/img/com_b_excel.gif" style="cursor:hand" onclick="if (gcDs1.countrow>0) ExcelDialog(Grid1,'배차정보');">				
				<img src="../../../Common/img/com_b_save.gif"	style="cursor:hand" onClick="ln_Save()">
				<img src="../../../Common/img/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12_left" bgcolor="#eeeeee" width=80 style="text-align:center">반출일자</td>
						<td class="tab12_left" >&nbsp;
						 <%=HDConstant.COMMENT_START%>
						 <OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:67px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:0px;top:1px;cursor:hand" onclick="ln_Callendar();">
						</td>
						<td class="tab12_left" bgcolor="#eeeeee"  width=80 style="text-align:center">주문번호</td>
						<td class="tab12_left"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag   value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab12_left" bgcolor="#eeeeee"  width=80 style="text-align:center">배정번호</td>
						<td class="tab12_left"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=CAR_SEQ_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>     
						</td>
						<td class="tab12_left" bgcolor="#eeeeee"  width=80 style="text-align:center">사업명</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;width:160px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td> 
					</tr> 
				</table> 
			</td>
		</tr>
		<tr><td height=5></td></tr>
		<tr>
			<td height="1px" colspan=2>
			(출발시간 :&nbsp;
			<%=HDConstant.COMMENT_START%>
			<OBJECT id=gcem_time_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:0px;top:4px" style="height:14;width:32;">
				<param name=Alignment		value="0">
				<param name=Border			value="0">
				<param name=Enable			value="1">
				<param name=Format			value="00:00">
				<param name=Text				value="0900">
				<param name=PromptChar	value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
				&nbsp;&nbsp;복귀일자:&nbsp;
				<%=HDConstant.COMMENT_START%>
				<OBJECT id=gcem_yymm_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:62;height:17px;position:relative; left:0px;top:7px">
				<param name=Alignment		value="0">
				<param name=Border			value="0">
				<param name=Format			value="YYYY/MM/DD">
				<param name=PromptChar	value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
				&nbsp;&nbsp;복귀시간:&nbsp;
				<%=HDConstant.COMMENT_START%>
				<OBJECT id=gcem_time_to1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="height:14;width:32;" style="position:relative; left:0px;top:4px">
				<param name=Alignment		value="0">
				<param name=Border			value="0">
				<param name=Enable			value="1">
				<param name=Format			value="00:00">
				<param name=Text				value="2400">
				<param name=PromptChar	value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%> &nbsp;&nbsp;) 
				<input type="checkbox" id=btn_check style="position:relative;top:2px;left:5px;cursor:hand" onclick="ln_ChkB()">
				<span style="position:relative;top:1px;cursor:hand" onclick="if (btn_check.checked!=true) btn_check.checked=true; else btn_check.checked=false;ln_ChkB();">일괄적용</span>
			 
				<span style="position:relative;top:8px;left:380px;cursor:hand"> 
					<img src="../../../Common/img/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()">			 
				</span>
			</td>
		</tr>
		<tr><td height=10></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:870px;height:300px;font-size:9pt;background-color:#ffffff;border:0 solid #708090" >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:876px;height:398px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true">  
								<PARAM NAME="Format"			VALUE="  
									<C> Name='▣'		ID=CHECK HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center EditStyle=CheckBox show=true </C> 
									<C> Name='No.'	ID=GRAYY HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center Value={ToString(RowCount-CurRow+1)}</C> 
									<G> Name='배차정보' HeadBgColor=#FAFCA7
										<C> Name='출발시간'				ID=START_TIME 		HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center		MASK='XX:XX' EditLimit =4</C>
										<C> Name='복귀일자'				ID=RTRN_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center		MASK='XXXX/XX/XX' EditLimit =8</C>
										<C> Name='복귀시간'				ID=RTRN_TIME			HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center		MASK='XX:XX' EditLimit =4</C>
										<C> Name='차량번호'				ID=CAR_NO				HeadAlign=Center HeadBgColor=#eeeeee Width=115  align=right		EditStyle=PopupFix</C> 
										<C> Name='운전자번호'			ID=PERSON_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center,	show=false</C>
										<C> Name='운전자명'				ID=PERSON_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=center		EditStyle=Lookup Data='gcDs_etc2:PERSON_NO:PSN_KNAME'</C>
									</G>
									<G> Name='배정정보' HeadBgColor=#D5EDFB 
										<C> Name='신청업체'				ID=USERNM				HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=LEFT,	edit=none  show=false</C>										
									  	<C> Name='실화주'				  	ID=SHIPPER_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=LEFT,	edit=none </C>										
										<C> Name='배정번호'				ID=CAR_SEQ_NO 	HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=left,		edit=none</C>
										<C> Name='차량종류'				ID=CARTYPENO		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left			EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME', edit=none</C> 										
										<C> Name='구분'						ID=TYPE					HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=center,	edit=none  </C>
										<C> Name='대표품목'				ID=CTN_STDRD		HeadAlign=Center HeadBgColor=#eeeeee Width=137 align=LEFT,		edit=none</C> 
										<C> Name='총용적'					ID=GRAYY				HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center,	edit=none , show=false</C> 
										<C> Name='총중량'					ID=GRAYY				HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center,	edit=none , show=false</C>  										
										<C> Name='반출/반입'				ID=IN_OUT				HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=center		Editstyle='combo' Data='I:반입,O:반출', edit=none, show=false</C>

										<C> Name='PROJECT'				ID=LINE_PART			HeadAlign=Center HeadBgColor=#eeeeee Width=135 align=left			EditStyle=Lookup Data='gcds_etc1:MINORCD:MINORNM', edit=none, show=FALSE</C>
										<C> Name='입고예정일자'			ID=LD_DATE				HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center		MASK ='XXXX-XX-XX', edit=none, show=FALSE</C>
										<C> Name='반출일자'				ID=EDT_DATE			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center		MASK ='XXXX-XX-XX', edit=none, show=FALSE</C> 
										<C> Name='상차지'					ID=LD_CARGO_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=LEFT,	edit=none </C>										
										<C> Name='하차지'					ID=OFF_CARGO_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left,	edit=none </C>		
										<C> Name='주문번호'				ID=ORDER_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center,	edit=none</C>  
										</G>
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table> 
			</td>
		</tr> 
	</table>
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

