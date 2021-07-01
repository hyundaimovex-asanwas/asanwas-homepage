<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 인원  Help 
 * 프로그램ID 	: RV004H
 * J  S  P		: rv004h
 * 서 블 릿		: Rv004H
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-26
 * 기능정의		: 방북신청시 사업자 인원정보 팝
 * [ 수정 일자][수정자] 내용
 * [2009-12-23][심동현] 차량도 같이 사용할 타이밍에 재점검
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	
	String sClientSid = HDUtil.nullCheckStr(request.getParameter("sClientSid"));
	String sClientNm = HDUtil.nullCheckStr(request.getParameter("sClientNm"));
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>인원정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
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
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv004H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "CUST_SID")  + ";" +	<%// 운전면허번호%>
                                     ds1.namevalue(row, "CUST_NM") + ";" +		<%// 운전자%>
								 	 ds1.namevalue(row, "MANAGE_NO") + ";" +	<%// 주민/여권번호 %>
								 	 ds1.namevalue(row, "CUST_TYPE") + ";" +	<%// 할인유형%>
								 	 ds1.namevalue(row, "N_CARD_NO") + ";" +	<%// 방북증번호%>
								 	 ds1.namevalue(row, "WORK_NO");				<%// 실무번호%>
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
		<table border="0" cellpadding="0" cellspacing="0" width='479px' style="position:relative;top:1px;width:50;height:15;left:3;">
			
			<tr>
				<td align='center' width='479px' colspan='4'>
					<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:50;height:15;">인원정보</font>
							</td>
						</tr>
						
						<tr>
							<td width=479 colspan="4">
								<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
									<tr>
										<td align=right width="479px">
											<img src="<%=dirPath%>/Sales/images/p_find.gif" alt="운전자를 검색합니다" style="cursor:hand;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr>
							<td colspan='4' width='479'>
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width=479>
									<tr>
									<!-- <td class="text" width="80px" height="30" bgcolor="#ffffff">협력업체</td>
										<td width="200px"  bgcolor="#ffffff" >&nbsp;&nbsp;
									  	 <input type='text' name='sClientNm' value="<%//=sClientNm%>" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" size="20"  maxlength="30" readonly="readonly">   -->
											<input type="hidden" name="client_sid" value="<%=sClientSid%>" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" size="20"  maxlength="30">
										</td>
										<td class="text" width="180px" height="30" bgcolor="#ffffff">성명/주민등록번호</td>
										<td width="150px"  bgcolor="#ffffff" >&nbsp;&nbsp;
											<input type='text' name='sKeyWord' value="" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" size="10"  maxlength="30"> 
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="5px" >
				<td colspan='4'></td>
			</tr>
			
			<tr>
				<td width='479px' align='center' colspan='4'>
					<table cellpadding="0" cellspacing="0" border="0" width='479px'>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: 그리드 , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								<%=HDConstant.COMMENT_START%>
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:260px;" border="1">
									<param name="DataID"		value="ds1">
									<param name="BorderStyle" 	value="0"> 
									<param name="ColSizing"     value="true">
									<param name="AutoResizing" 	value=true> 
									<param name="Editable"  	value="false">
									<param name="AddSelectRows" value=true>
									<param name=SortView  		value="Right">
                                    <param name=ViewSummary  value="1">
									<param name="Format" 		value="
									  	<C> name='고객SID'    		ID='cust_sid'	align=left editlimit=12 show=false width=100 </C>
						                <C> name='성명'      		ID='cust_nm'	align=left editlimit=30 show=true width=110 sumtext=@count Sort=True</C>
						                <C> name='주민/여권번호'   	ID='manage_no'	align=left editlimit=20 show=true width=130 sumtext=명 Sort=True</C>
						                <C> name='방북증번호' 	ID='N_CARD_NO'	align=CENTER editlimit=20 show=true width=120 </C>
						                <C> name='실무번호'     	ID='work_no'	align=CENTER editlimit=20 show=true width=100 </C>
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