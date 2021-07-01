<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 상차확정정보
+ 프로그램 ID	: TR00218.HTML
+ 기 능 정 의	: 상차확정정보
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


<!-- /******************************************************************************
	Description : DataSet 선언
******************************************************************************/ -->    
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ; 
	var gs_ordno = null ; 
	var gs_seq = null ; 
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
		Description :
	******************************************************************************/ 
	function Start(){
		gcem_edt.Text = gs_date; 

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

	}
  
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){

		var parm = "?gstr1=" + gcem_edt.Text + "&gstr2=" + order_no.Text;
	 
		gcDs1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadFix" + parm;
		gcDs1.Reset();
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Excel(){
		ExcelDialog(gcGR1,'상차확정정보');
	}
 
</SCRIPT> 

 <!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1 event="OnLoadStarted()"> 
	OnStatusStart() ;  
</script>

<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
	TheStatusEnd(row) ; 
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
			<td><img src="../img/TR00118_head.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../../common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel();"> 
				<img src="../../common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="width:80px;height:30px;text-align:center" bgcolor="#eeeeee">반입일자</td>
						<td class="tab12_left" style="width:150px;">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_edt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_edt', 'Text');">
						</td>
						<td class="tab12" style="width:80px;text-align:center" bgcolor="#eeeeee">주문번호</td>
						<!--<td class="tab12_left" style="width:140px;">&nbsp;-->
						<td>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=order_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:100px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<!--
						<td class="tab12" style="width:80px;text-align:center" bgcolor="#eeeeee">PROJECT</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;width:160px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td> 
						-->
					</tr>
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:0 solid #708090;border-rigth-width:1px" >
					<tr>
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:874;height:442px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true">  
								<PARAM NAME="Format"			VALUE="   
									<F>	Name='No.'		  ID=SeralNo		HeadAlign=Center HeadBgColor=#eeeeee Width=25		align=Center, Bgcolor='#efefef',	Value={CurRow}	</F> 
									<F> Name='주문번호' ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center	suppress=1</F> 
									<F> Name='배정번호' ID=CAR_SEQ_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center	suppress=2</F> 
									<C> Name='수량'			ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right</C> 
									<G> Name='단위포장' HeadBgColor=#eeeeee
										<C> Name='길이(CM)'		ID=PKG_LNGTH			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right</C> 
										<C> Name='폭(CM)'			ID=PKG_HEIGHT			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right</C> 
										<C> Name='높이(CM)'		ID=PKG_WIDTH			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right</C> 
										<C> Name='수량'				ID=PUNIT_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right</C> 
										<C> Name='중량(KG)'		ID=PUNIT_WEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right</C> 
									</G>
									<G> Name='상차정보' HeadBgColor=#eeeeee
										<C> Name='완료일자'		ID=UPEND_DT			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center, Mask='XXXX-XX-XX'</C> 
										<C> Name='시간'		ID=UPEND_TIME		HeadAlign=Center HeadBgColor=#eeeeee Width=40		align=right, Mask='XX:XX'</C> 
									</G>
									<C> Name='비고'		ID=REMARK		HeadAlign=Center HeadBgColor=#eeeeee Width=137		align=right</C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 

			</td>
		</tr> 
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

