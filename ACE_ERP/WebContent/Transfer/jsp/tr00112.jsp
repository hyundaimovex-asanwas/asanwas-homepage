<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 포장주문검색
+ 프로그램 ID	: TR00112.HTML
+ 기 능 정 의	: 포장주문검색
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
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ; 
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

		FROM_DATE.Text = gs_date1 ; 
		TO_DATE.Text = gs_date ; 	

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0016";  //
		gcDs_etc1.Reset();  

		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0017";  //납품구분 
		gcDs_etc2.Reset(); 
		
		gcDs_etc3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0019";  //물류창고
		gcDs_etc3.Reset(); 
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/ 
	function ln_Query(){  
		var parm = "&gstr1=" + PORDER_NO.Text
						 + "&gstr2=" + CUST_NM.value
						 + "&gstr3=" + FROM_DATE.Text
						 + "&gstr4=" + TO_DATE.Text;

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderPkg?NOH=Y" + parm ; 
		gcDs1.Reset() ;  
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

<script language=JavaScript for=gcDs1 event=OnDataError(row,colid)>
	TheStatusEnd(row) ; 
</script>

<script language=JavaScript for=Grid1 event=OnDblClick(row,colid)>
	if (row<1) return;
	window.location.href="../../Transfer/html/TR00113.html?gstr1=update&gstr2="+gcDs1.NameValue(row,"PORDER_NO") ; 
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
				<img src="../../../Common/img/com_b_excel.gif" style="cursor:hand" onclick="ExcelDialog(Grid1,'포장주문조회')"> 
				<img src="../../../Common/img/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=75>주문번호</td>
						<td class="tab23" >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag   value=1>  
							</OBJECT>
							<%=HDConstant.COMMENT_END%>  
						</td>
						<td class="tab12" style="text-align:cetner" bgcolor="#eeeeee" width=75>요청일자</td>
						<td class="tab23">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
							
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('FROM_DATE', 'Text');"> ~&nbsp;
						  <%=HDConstant.COMMENT_START%>
						  <OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_"> 
							 </OBJECT>
							 <%=HDConstant.COMMENT_END%>
							 <img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('TO_DATE', 'Text');"> 
						</td>
						<td class="tab12" style="text-align:cetner" bgcolor="#eeeeee" width=75>업체</td>
						<td>&nbsp;
						<input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:170;position:relative;left:0px;top:0px;ime-mode:active'></td> 
					</tr> 
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:874;height:441px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="ColSizing"   VALUE="true">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='Order No'		ID=PORDER_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center</C> 
									<C> Name='신청일자'		ID=ORDER_DATE	HeadAlign=Center HeadBgColor=#eeeeee Width=80 align=center MASK='XXXX-XX-XX' </C>
									<C> Name='업체명'			ID=VEND_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=180  align=left</C> 
									<C> Name='현재상태'		ID=ENTER_STS	HeadAlign=Center HeadBgColor=#eeeeee Width=60 align=left, editstyle=LookUp data='gcds_preduc:minorcd:minornm'</C> 
									<C> Name='입고형태'		ID=WORK_FORM  HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center, editstyle=LookUp data='gcDs_etc1:minorcd:minornm'</C>  
									<C> Name='포장수'			ID=PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=right </C>
									<C> Name='포장형태'		ID=PKG_FORM		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left, editstyle=LookUp data='gcDs_etc2:minorcd:minornm'</C>
									<C> Name='물류창고'		ID=WAREHOUSE	HeadAlign=Center HeadBgColor=#eeeeee Width=150 align=left, editstyle=LookUp data='gcDs_etc3:minorcd:minornm'</C>  
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

