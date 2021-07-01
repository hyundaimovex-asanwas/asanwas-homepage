<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 차량  Help 
 * 프로그램ID 	: RV002H
 * J  S  P		: rv002h
 * 서 블 릿		: Rv002H
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-26
 * 기능정의		: 차량 조회 
 * [ 수정일자 ][수정자] 내용
 * [2015-09-17][심동현] 차량번호 like 검색 추가
 * [2018-08-21][심동현] 대리점 조건 제거. help/Rv002H.java의 쿼리부분 조건절, 셀렉절 수정함~
 *                      본 파일 그리드에 협력업체명 추가
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	String sClientSid = request.getParameter("sClientSid");
	String sClientNm = HDUtil.nullCheckStr(request.getParameter("sClientNm"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>차량 검색　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
				cfStyleGrid(getObjectFirst("gr1"), "comn");
				
				var strParam = new Array();
				strParam=window.dialogArguments;
				sClient_sid.value = strParam[0];
				sClientNm.value = strParam[1];
				sCarNo.focus();
				
			}
			
			function fnSelect() {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClientSid=" + sClient_sid.value
			          + ",sCarNo=" + sCarNo.value	//차량등록번호
			          + ",dsType=1";
			          
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv002H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "CAR_SID")  + ";" +	// 차량등록 SID
                                     ds1.namevalue(row, "CAR_NO") + ";" +	// 차량등록 번호 
								 	 ds1.namevalue(row, "CAR_NM")   + ";" +	// 차명
								 	 ds1.namevalue(row, "CAR_TYPE");
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



	</head>	
	
<!--  BODY START -->
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table   border="0" cellpadding="0" cellspacing="0" width=479px>
			<tr>
				<td height="24px">
					<table  border="0" cellpadding="0" cellspacing="0" width=479px>
					  <tr>
						<td align="left">
							<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;height:15;">차량 정보</font>
						</td>
						<td align=right >
							<img src="<%=dirPath%>/Sales/images/p_find.gif" alt="차량을 검색합니다" style="cursor:pointer;" onclick="fnSelect();">
						    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:pointer;" onClick="fnAdd()">                            
						    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:pointer;" onClick="fnClose()">                          
						</td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  border="0" cellpadding="0" cellspacing="0" width=479px>
					  <tr>
						<td class="text" width="70px" height="30" style="border:1px solid #708090">협력업체명</td>
						<td style="border:1px solid #708090;border-width:1 1 1 0;">&nbsp;
							<input type="text" 		name="sClientNm" 	value="<%=sClientNm%>" 		class="input01" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30" readonly="readonly">
							<input type="hidden" 	name="sClient_sid" 	value="<%=sClientSid%>" 	class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
						</td>
						<td class="text" width="70px" style="border:1px solid #708090; border-width:1 1 1 0;">차량번호</td>
						<td style="border:1px solid #708090; border-width:1 1 1 0;">&nbsp;
							<input type="text" 		name="sCarNo" 	value="" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" maxlength="30">
						</td>

					  </tr>
					</table>
				</td>
			</tr>

			<tr height="10px">
				<td width=479px></td>
			</tr>
			
			<tr>
				<td width='479px' align='center'>
					<table cellpadding="0" cellspacing="0" border="0" width=479px>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: 그리드 , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:479px; height:248px;border:1 solid #777777;">
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
									<param name="SortView"      value="Right">
									<param name="Format" 		value="
									   <C> name='차량SID'   		ID='car_sid'    width=80  align=left editlimit=12 show=false</C>
									   <C> name='협력업체명'     ID='client_nm'  width=100 align=left editlimit=30 show=true sort=true</C>
						               <C> name='차량등록번호'     ID='car_no'     width=100 align=center editlimit=30 show=true sort=true</C>
						               <C> name='차    명'     		ID='car_nm'     width=130 align=center editlimit=32 show=true sort=true</C>
						               <C> name='차    종'     		ID='car_type'   width=120 align=center editlimit=30 show=true sort=true</C>
									">
								</object>
								
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
								name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;"
								 Frameborder="0" src="<%=dirPath%>/Common/include/loadingSales.jsp" 
								 width="400px" height="146px"></iframe>
							</td>
						</tr>
					</table>				
				</td>
			</tr>
		</table>

	</body>
	<!-- BODY END -->
</html>