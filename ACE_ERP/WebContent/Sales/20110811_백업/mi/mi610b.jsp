<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 월별 집계작업
 * 프로그램ID 	 : Mi610B
 * J  S  P		 : mi610b
 * 서 블 릿		 : MI610B
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-17
 * 기능정의		 :  월별 집계작업 (집계)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMM");
   String firstday = m_today.format(date.getTime());		   
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

			sBgnDate.text='<%=firstday%>';		
			fnInit();
		}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    }
	/*
	 * 집계
	 */
	function fnApply() {
		if ( sBgnDate.text.trim() == '' ) {
			alert("작업년월을 입력해 주세요.");
			return;
		}
	        v_job = "I";	
	         window.status="집계 중입니다. 잠시만 기다려 주십시오...";
		
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	           + "sBgnDate=" + sBgnDate.text;
	
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_MI%>Mi610B",
	            "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	            param);
	        tr_post(tr1);
	}
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "집계가 완료되었습니다";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
            
        //메시지 처리
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);              
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "집계중에 오류가 발생하였습니다.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
        
        //에러 메시지 처리
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
		    
        //메시지 처리
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);  		    
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
												<tr>
													<td align="right" colspan="2">
														<table border="0"  cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td align="right" height="30px">		
																	<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
													 			</td>
															</tr>	
														</table>
													</td>											
												</tr>
												<tr height="50px">
													<td align="left"  colspan='2' width="845px">
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="845px">
											                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											                            <tr bgcolor="#6f7f8d">
											            					<td align=left class="text"  width="70"><b>작업년월</b></td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																							
   							      												<%=HDConstant.COMMENT_START%>
   							      												<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
																					<param name=Text 		value="">
																					<param name=Alignment 	value=1>
																					<param name=Format 		value="0000-00">
																					<param name=Cursor	 	value="iBeam">
																					<param name=Border	 	value="false">		
																					<param name=InheritColor      value="true">																																																				
																					<param name=ReadOnly  	value="false">
																					<param name=SelectAll  	value="true">
																					<param name=SelectAllOnClick  	value="true">		
																					<param name=SelectAllOnClickAny  	value="false">																							
																				</object>
																				<%=HDConstant.COMMENT_END%>&nbsp;	
																			</td>																							
											            				</tr>
											            			</table>
																</td>
															</tr>															
														</table>	
													</td>											
												</tr>
												<tr height="10">
													<td colspan='2'></td>
												</tr>
											</table>
										</td>
									</tr>
									
								</table>
							</td>
						</tr>
					</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

