<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 반현황  Help 
 * 프로그램ID 	: RV006H
 * J  S  P		: rv006h
 * 서 블 릿		: Rv006H
 * 작 성 자		: 안준성
 * 작 성 일		: 2006-07-04
 * 기능정의		: 반현황
 * 수정내용		: 
 * 수 정 자		: 
 * 최종수정일자 :  
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	String sSaupSid = request.getParameter("sSaupSid");	
	
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>반현황&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                
				sDepartDate.text='<%=firstday%>';			
				
		        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>"; 
		        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
		            + "sSaupSid=<%=sSaupSid%>,"
		            + "sDepartDate=" + sDepartDate.text;
		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv006H",
		            "JSP(O:DS2=ds2,O:DS3=ds3)",
		            param);
        		tr_post(tr1);				
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			 
			function fnSubSelect1() {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sDepartDate=" + sDepartDate.text
			          + ",sGoodsSid=" + ds3.namevalue(ds3.rowposition,"goods_sid")
			          + ",sDepartTime=" + ds2.namevalue(ds2.rowposition,"depart_time")
		              + ",sSaupSid=<%=sSaupSid%>"			          
			          + ",dsType=1";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv006H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnExcel() {
            
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:반현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("반현황", "반현황.xls", 32);
            }
			
			function fnClose() {
				window.close();
			}
			
			
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  그리드 더블클릭 이벤트 발생
//
%>			

<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
	</head>	
	
<!--  BODY START -->
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="479px">
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=absmiddle> <font style="position:relative;top:1px;width:50;height:15;">반현황</font>
							</td>
						</tr>
						<tr>
							<td colspan="4" align=right width="479px"><img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand;" onClick="fnExcel()">
							<img src="<%=dirPath%>/Sales/images/p_find.gif" alt="반현황을 검색합니다" style="cursor:hand;" onclick="fnSelect();">
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
							</td>
						</tr>
						<tr>
							<td width="479px">
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="479px">
									<tr>
										<td class="text" width="60px" height="30" bgcolor="#ffffff">출발일자</td>
										<td width="200px"  bgcolor="#ffffff">&nbsp;
		  							      	<%=HDConstant.COMMENT_START%>
	      									<object id=sDepartDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=absmiddle class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="false">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll  	value="true">
												<param name=SelectAllOnClick  	value="true">																					
											</object>
											<%=HDConstant.COMMENT_END%>&nbsp;
    										<%=HDConstant.COMMENT_START%>
				                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
												<param name=ComboDataID		value=ds2>
												<param name=BindColumn      value="depart_time">
                                                <param name=BindColVal      value="depart_time">
												<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
												<param name=ListExprFormat  value="depart_time_nm^0^60"></object>
											<%=HDConstant.COMMENT_END%>												
										</td>
										<td class="text" width="60px" height="30"  bgcolor="#ffffff">상품정보</td>
										<td width="200px"  bgcolor="#ffffff">&nbsp;
    										<%=HDConstant.COMMENT_START%>
				                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
												<param name=ComboDataID		value=ds3>
												<param name=BindColumn      value="goods_sid">
                                                <param name=BindColVal      value="goods_sid">
												<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
												<param name=ListExprFormat  value="goods_nm^0^120"></object>
											<%=HDConstant.COMMENT_END%>&nbsp
										<td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<%=HDConstant.COMMENT_START%>
					<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=479px; height:248px;" border="1">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit가능  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
                        <param name="ViewSummary"       value="1">
						<param name="Format" 		value="
						  	<C> name='반'    		ID='CLASS' align=left editlimit=12 show=true width=80 </C>
			            <C> name='조'    		ID='TEAMS' align=left editlimit=12 show=true width=50</C>
			            <C> name='인원'       ID='COUNT' align=right editlimit=30 show=true width=50 SumText=@sum</C>
						">
					</object>
					<%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<!--  상태바 플레쉬  -->
			<iframe id="LowerFrame" 
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>