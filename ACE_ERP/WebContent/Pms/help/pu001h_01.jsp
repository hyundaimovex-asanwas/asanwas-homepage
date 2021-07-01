<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	: 품목  Help 
 * 프로그램ID 	: PU001H_01
 * J  S  P		: pu001h_01
 * 서 블 릿		: Pu001H_01
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-11-18
 * 기능정의		: 품목조회
 *****************************************************************************/
%>
<%@ page import="pms.common.*"%>
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
		<title>품목정보　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<jsp:include page="/Pms/common/include/head.jsp"/>
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
                       // + ",v_code_no=" 	+ v_code_no.value			//자재코드
                        + ",v_item_nm=" 	+ v_item_nm.value;			//자재명
                       // + ",v_item_kind=" 	+ v_item_kind.value;		//분류코드
                        //alert(v_param);
                ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Pu001H_01",
                "JSP(O:MASTER=ds1)",
                v_param);
            tr_post(tr1);
           }
           
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue =
                                     ds1.namevalue(row, "ITEM_SID") + ";" +			// 품목SID
								 	 ds1.namevalue(row, "ITEM_NM") + ";" +			// 품명
								 	 ds1.namevalue(row, "ITEM_SIZE") + ";" + 		// 규격
									 ds1.namevalue(row, "ITEM_UNIT") + ";" ;			// 단위

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
		
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
		<table border="0" cellpadding="0" cellspacing="0" width='370px' style="position:relative;top:1px;width:50;height:15;left:3;">
			
			<tr>
				<td align='center' width='370px' colspan='4'>
					<table  border="0" cellpadding="0" cellspacing="0" width='370px'>
						<tr>
							<td colspan=4 height=25 width="370px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:50;height:15;">폼목조회</font>
							</td>
						</tr>
						
						<tr>
							<td width=370 colspan="4">
								<table  border="0" cellpadding="0" cellspacing="0" width='370px'>
									<tr>
										<td align=right width="370px">
											<img src="<%=dirPath%>/Sales/images/p_find.gif" style="cursor:hand;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr>
							<td colspan='4' width='370'>
							<table width=370 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="20px">
							    <td align=middle class="text" width="100px">자재명
                               	</td>
			                    <td align=middle bgcolor="#ffffff" >&nbsp;<input type="text" name="v_item_nm" size="20" maxlength="13" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
			                    </td>
							 </tr>
                        </table>
				</td>
			</tr>
			<tr height="5px" >
				<td colspan='4'></td>
			</tr>
			
			<tr>
				<td width='370px' align='center' colspan='4'>
					<table cellpadding="0" cellspacing="0" border="0" width='370px'>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: 그리드 , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								<%=HDConstant.COMMENT_START%>
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=550px; height:260px;" border="1">
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
   						                <C> name='자재코드'   	ID='CODE_NO'		align=left editlimit=20 show=false width=100 </C>
   						                <C> name='자재명'   		ID='ITEM_NM'		align=left editlimit=20 show=true width=200 </C>   						                
   						                <C> name='자재분류'   	ID='ITEM_KIND'	align=left editlimit=20 show=false width=100 </C>   						                
									    <C> name='품목SID'      	ID='ITEM_SID'		align=left editlimit=30 show=false width=50 </C>
    						            <C> name='규격'  			ID='ITEM_SIZE'	align=left editlimit=30 show=true width=100 </C>
									    <C> name='단위'      		ID='ITEM_UNIT'	align=left editlimit=30 show=true width=70 </C>
    						           ">
								</object>
								<%=HDConstant.COMMENT_END%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>