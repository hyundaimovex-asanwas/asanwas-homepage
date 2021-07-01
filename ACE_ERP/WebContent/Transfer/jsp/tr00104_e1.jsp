<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 배정차량 정보
+ 프로그램 ID	: TR00104_E1.HTML
+ 기 능 정 의	: 배정차량 정보
+ 변 경 이 력	: 정미선
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
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
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>

var	lb_boolean1 =  false ;  
var gs_car_seq_no  = null ; 
var type  = null ; 
var gs_ordno = null ; 
var gs_inout = "O";

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Start(){
	
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();  
		
		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //적재구분 
		gcDs_etc5.Reset(); 

		getParameters();

		if(gs_car_seq_no == null || type== "insert") {
		
			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s2?NOH=N";  //Project 
			gcDs1.Reset();  
			
		} else if (gs_car_seq_no != null || type== "update") {
		
			gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s2?NOH=Y&gstr2="+gs_car_seq_no ;  //Project 
			gcDs1.Reset(); 
			
		}	else {
		
			alert("Error :담당자에게 문의하십시오" ) ; 
			window.close(); 
			
		}
	}
 
	/******************************************************************************
		Description :  GET PARAMETER
	******************************************************************************/ 
	function getParameters(){
	
		if(location.search){ //주소중 파라메터 부분이 있으면,
			var str0=location.search.split("&")[0];
			var str1=location.search.split("&")[1];
			var str2=location.search.split("&")[2];

			gs_car_seq_no = str0.split("=")[1]; 
			type = str1.split("=")[1];

			gs_inout = str2.split("=")[1];

			if (gs_inout=="O") ft_inout.innerText = "반출일자";
			else ft_inout.innerText = "반입일자";
		} 
	}

	/******************************************************************************
		Description :  GET PARAMETER
	******************************************************************************/ 
	function DataSetTransfer(){
	
		if (gcDs1.CountRow > 0 	){
		
			CAR_TYPE.BindColVal  = gcDs1.NameValue(1,"CARTYPENO");
			ETD_DATE.Text		= gcDs1.NameValue(1,"EDT_DATE");
			LD_DATE.Text		= gcDs1.NameValue(1,"LD_DATE");
			CTN_STDRD.value = gcDs1.NameValue(1,"CTN_STDRD");
			LINE_PART.index = LINE_PART.IndexOfColumn("MINORCD",gcDs1.NameValue(1,"LINE_PART"));
			
		}	else {
		
			gcDs1.AddRow() ; 
			gcDs1.NameValue(1,"ORDER_NO") = "";
			CAR_TYPE.index	= 0;
			ETD_DATE.Text		= "";
			LD_DATE.Text		= "";
			CTN_STDRD.value = "";
			
		} 
		
	}

	/******************************************************************************
		Description : TextToDataSet
	******************************************************************************/ 
	function TextToDataSet(){
	
		gcDs1.NameValue(1,"CARTYPENO")  = CAR_TYPE.BindColVal;
		gcDs1.NameValue(1,"EDT_DATE")		= ETD_DATE.Text;
		gcDs1.NameValue(1,"LD_DATE")		= LD_DATE.Text;
		gcDs1.NameValue(1,"CTN_STDRD")	= CTN_STDRD.value;
		gcDs1.NameValue(1,"LINE_PART")	= LINE_PART.BindColVal;
		gcDs1.NameValue(1,"IN_OUT")			= gs_inout;
		gcDs1.NameValue(1,"CREATE_USR")	= gusrid;
		gs_ordno = gcDs1.NameValue(1,"ORDER_NO")
		
	}

	/******************************************************************************
		Description :  저장
	******************************************************************************/ 
	function ln_Save(){

		if (confirm("입력하신 정보를 저장하시겠습니까 ? ")) {
		
			TextToDataSet();	alert(gs_ordno);
			
			gcTr01.KeyValue = "trOrderCar(I:USER=gcDs1)";
			
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderCar";
			
			gcTr01. Parameters = "gstr1="+gs_ordno ; //주문번호
			
			gcTr01.post();
			
		}
	}

	/******************************************************************************
		Description :   Project
	******************************************************************************/  
	function AddChoice(obj){
	
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "=선택 or 입력=" ;  
		
	}

 </SCRIPT> 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1 event=OnLoadCompleted(rowcnt)>
	DataSetTransfer() ; 
</script>

<script language=JavaScript for=gcTr01 event=OnSuccess()>
	alert("정상적으로 배정차량 정보가 저장되었습니다.");
	window.close();
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>
 
</HEAD>

<BODY onLoad="Start();">
	<table width="325" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px">
		<tr><td colspan=2>&nbsp;</td></td>
		</tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:325px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width=100>차량종류</td>
						<td class="tab13_left">
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=CAR_TYPE  style='border:0;position:relative;left:8px;top:1px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  >
								<param name=ComboDataID			value=gcDs_etc5>  
								<param name=CBDataColumns		value="CAR_TYPE,CAR_NAME">
								<param name=SearchColumn		value="CAR_NAME">
								<param name=SortColumn			value="CAR_TYPE"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="CAR_NAME^0^100"> 
								<param name=BindColumn			value="CAR_TYPE">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					</tr> 
					<tr>
						<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" ><font id=ft_inout></font></td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px;width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:10px;top:1px;" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td> 
					</tr> 
					<tr>
						<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" >입고일자</td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px;width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:10px;top:1px;" onclick="__GetCallCalendar('LD_DATE', 'Text');"> 
						</td> 
					</tr> 
					<tr>
						<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" >대표물품</td>
						<td class="tab13_left"><input id="CTN_STDRD" name="CTN_STDRD" type="text" class="txt11" style='width:180;position:relative;left:8px;top:1px' >  
						</td> 
					</tr> 
					<tr>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee">Project</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;width:150px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>  
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr><td style="height:10px;"></td></tr>
		<tr>
			<td height=10px style="text-align:center" colspan=2>
				<img src="../../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
				<img src="../../../Common/img/btn/com_b_close.gif" style="cursor:hand" onclick="window.close()">
			</td>
		</tr>
	</table>
</BODY>
</HTML>
