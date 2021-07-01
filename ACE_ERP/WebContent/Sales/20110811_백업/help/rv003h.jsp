<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 운전자  Help 
 * 프로그램ID 	: RV003H
 * J  S  P		: rv003h
 * 서 블 릿		: Rv003H
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-26
 * 기능정의		: 차량 조회 
 * 수정내용		: 
 * 수 정 자		: 
 * 최종수정일자 :  
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	String sClientSid = request.getParameter("sClientSid");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>운전자정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
				cfStyleGrid(getObjectFirst("gr1"), "comn");
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			 
			function fnSubSelect1() {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClientSid=" + client_sid.value
			          + ",sKeyWord=" + sKeyWord.value
			          + ",dsType=1";
			          
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv003H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "DRIVE_SID")  + ";" +	// 운전면허번호
                                     ds1.namevalue(row, "CUST_NM") + ";" +	// 운전자
								 	 ds1.namevalue(row, "MANAGE_NO")   + ";" +	// 주민/여권번호 
								 	 ds1.namevalue(row, "DRIVE_NO") + ";" + // 운전면허번호
								 	 ds1.namevalue(row, "CUST_SID")+";"+ // 고객 SID
								 	 ds1.namevalue(row, "CUST_TYPE")+";"+ // 고객 SID
								 	 ds1.namevalue(row, "WORK_NO")+";"+ // 고객 SID
								 	 ds1.namevalue(row, "N_CARD_NO"); // 고객 SID
			 	fnClose();
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
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			fnAdd();
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>

<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<%=HDConstant.COMMENT_END%>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>



	</head>	
	
<!--  BODY START -->
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="479px">
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:50;height:15;">운전자정보</font>
							</td>
						</tr>
						<tr>
							<td colspan="4" align=right width="479px"><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="운전자를 검색합니다" style="cursor:hand;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
							</td>
						</tr>
						<tr>
							<td width="479px">
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="479px">
									<tr>
										<td class="text" width="110px" height="30" bgcolor="#ffffff">대리점</td>
										<td width="110px"  bgcolor="#ffffff">
											<input type="text" name="client_sid" class="textbox" value="<%=sClientSid%>" onkeydown="if(event.keyCode==13) fnSelect();" size="10"  maxlength="30">
										</td>
										<td class="text" width="149px" height="30"  bgcolor="#ffffff">고객명/운전면허번호</td>
										<td width="110px"  bgcolor="#ffffff">
											<input type="text" name="sKeyWord" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"  size="10"  maxlength="30">
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
					<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;" border="1">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit가능  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="Format" 		value="
						  	<C> name='고객SID'    		ID='cust_sid'   align=left editlimit=12 show=true width=100</C>
			                <C> name='운전면허번호SID'    ID='drive_sid'   align=left editlimit=12 show=true width=100</C>
			                <C> name='운전자'      		ID='cust_nm'     align=left editlimit=30 show=true width=100</C>
			                <C> name='주민/여권번호'    	ID='manage_no'   align=left editlimit=20 show=true width=100</C>
			                <C> name='운전면허번호'     	ID='drive_no'    align=left editlimit=20 show=true width=100</C>
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