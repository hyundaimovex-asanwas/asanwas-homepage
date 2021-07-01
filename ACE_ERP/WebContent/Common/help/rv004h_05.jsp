<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	: 사원  Help 
 * 프로그램ID 	: RV004H_05
 * J  S  P		: rv004h_05
 * 서 블 릿		: Rv004H_05
 * 작 성 자		: 박경국
 * 작 성 일		: 2010-05-20
 * 기능정의		: 받은쪽지함/보낸쪽지함 에서 인원 (현대아산직원 + 대리점담당자) 조회
 * [2011-10-12][심동현] 쪽지 대상을 불러오는 쿼리 (SALES.PR_RV004H_05) 수정. 정확히는 VIEW를 수정~
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String toDay     = m_today.format(date.getTime());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>이용자 정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
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
	            v_job = "S";
    			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",UID="   + UID.value
                        + ",UNAME="  + UNAME.value
                        + ",UCLIENT="  + UCLIENT.value;
                ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Rv004H_05",
	                "JSP(O:MASTER=ds1)",
	                v_param);
            tr_post(tr1);
           }
           
           function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue =
								     ds1.namevalue(row, "UID")		+";"+ 
   								     ds1.namevalue(row, "UNAME")		+";"+ 
								     ds1.namevalue(row, "UCLIENT");
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
//			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
//			ft_cnt1.innerText="Cnt : " + row;
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
//			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
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
		
		<script language=JavaScript for=v_fr_date event=OnKillFocus()>
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
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
	</head>	<!--  BODY START -->
	  <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table border="0" cellpadding="0" cellspacing="0" width='400px' style="position:relative;top:1px;height:15;left:3;">
			<tr>
				<td align='center' width='400px'>
					<table  border="0" cellpadding="0" cellspacing="0" width='400px'>
						<tr>
							<td height=25 width="400px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">이용자 정보</font>
							</td>
						</tr>
						<tr>
							<td width=400>
								<table  border="0" cellpadding="0" cellspacing="0" width='400px'>
									<tr>
										<td align=right width="400px">
											<img src="<%=dirPath%>/Sales/images/p_find.gif" style="cursor:hand;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width='400'>
								<table width=400 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
            		                <tr height="20px">
                    		           	<td align=middle class="text" width="70px">사번</td>
						                <td align=middle bgcolor="#ffffff" >&nbsp;<input type="text" name="UID" size="10" maxlength="15" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" OnKeyUp="cfLengthCheck(this, 15);"></td>
			    	  		            <td align=left class="text" width="60px">성명</td>
			        					<td align=left bgcolor="#ffffff" >&nbsp;<input type="text" name="UNAME" size="8" maxlength="8" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" OnKeyUp="cfLengthCheck(this, 10);"></td>
		        						<td align=middle class="text" width="80px">회사|부서</td>
						                <td align=middle bgcolor="#ffffff" >&nbsp;<input type="text" name="UCLIENT" size="12" maxlength="50" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" OnKeyUp="cfLengthCheck(this, 15);"></td>
			      	         		</tr>
                        		</table>
							</td>
						</tr>
					<tr height="5px" >
				<td></td>
			</tr>
			<tr>
				<td width='400px' align='center'>
					<table cellpadding="0" cellspacing="0" border="0" width='400px'>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: 그리드 , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								<%=HDConstant.COMMENT_START%>
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=550px; height:200px;" border="1">
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
                                    <param name=ViewSummary  value="1">
									<param name="Format" 		value="
									    <C> name='사번'      	ID='UID'		align=left editlimit=20 show=true width=80 </C>
						                <C> name='성명'   		ID='UNAME'		align=left editlimit=20 show=true width=60 </C>
						                <C> name='회사명|부서명'  	ID='UCLIENT'	align=left editlimit=20 show=true width=260 </C>
										">
								</object>
								<%=HDConstant.COMMENT_END%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
				<td>
				&nbsp;&nbsp;※ 현대아산 ERP ID + 금강산관광 사이트 대리점 담당자 ID<br>
				</td>
			</tr>
		</table>
	</body>	<!-- BODY END -->
</html>