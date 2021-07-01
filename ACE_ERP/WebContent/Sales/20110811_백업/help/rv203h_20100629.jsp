<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	: 인원  Help 
 * 프로그램ID 	: RV203H
 * J  S  P		: rv203h
 * 서 블 릿		: Rv203H
 * 작 성 자		: 박경국
 * 작 성 일		: 2010-06-29
 * [2010-06-29][박경국] 결제안내 쪽지/메일 팝업창.
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
		<title>인원정보　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
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
           /*	if(getObjectFirst("v_manage_no").value==""){
                alert("주민/여권번호를 검색하시시길 바랍니다.");
                return;
            }
           */
            if(getObjectFirst("v_fr_date").Text.trim()=="" || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("일자 (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
          
                        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_fr_date=" + v_fr_date.Text		//출발일자
                        + ",v_manage_no=" + v_manage_no.value	//주민/여권번호
                        + ",v_cust_nm=" + v_cust_nm.value;		//성명
                ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv203H",
                "JSP(O:MASTER=ds1)",
                v_param);
            tr_post(tr1);
           }
           
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue =
                                     ds1.namevalue(row, "CUST_NM") + ";" +			// 입금액 대체 받는사람의 성명		
								 	 ds1.namevalue(row, "MANAGE_NO") + ";" +		// 입금액 대체 받는사람의 주민/여권번호
								 	 ds1.namevalue(row, "D_TOT_PAY_AMT") + ";" + 	// 입금액 대체 받는사람의 잔액		
									 ds1.namevalue(row, "D_RSV_SID") + ";" ;		// 입금액 대체 받는사람의 예약sid

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
											<img src="<%=dirPath%>/Sales/images/p_find.gif" style="cursor:hand;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr>
							<td colspan='4' width='479'>
							<table width=550 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="20px">
                                <td align=middle class="text"  width="100">출발일자
                                </td>
			                        <td align=middle bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
			                                <param name=Text        value="<%=toDay%>">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>  
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>                                                                                                                         
                               	<td align=middle class="text" width="100px">주민/여권번호
                               	</td>
			                    <td align=middle bgcolor="#ffffff" >&nbsp;<input type="text" name="v_manage_no" size="15" maxlength="13" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
			                    </td>
			      		             <td align=left class="text" width="70px">성명</td>
			        			<td align=left bgcolor="#ffffff" >&nbsp;
						        	<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
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
									    <C> name='상품'      		ID='GOODS_NM'	align=left editlimit=30 show=true width=110 </C>
    						            <C> name='신청서번호'  		ID='ACCEPT_NO'	align=left editlimit=30 show=true width=110 </C>
									    <C> name='성명'      		ID='cust_nm'	align=left editlimit=30 show=true width=70 sumtext=@count</C>
						                <C> name='주민/여권번호'   	ID='manage_no'	align=left editlimit=20 show=true width=100 sumtext=명</C>
										<C> name='예약SID'    		ID='D_RSV_SID'	align=left editlimit=12 show=true width=60 </C>
    						            <C> name='받을사람금액 '    ID='D_TOT_PAY_AMT'	align=RIGHT editlimit=12 show=true width=80 dec=0</C>
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