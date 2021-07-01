<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 모객률 타입 정보
 * 프로그램ID 	 : RM530I
 * J  S  P		 : rm530i
 * 서 블 릿		 : RM530I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-06-14
 * 기능정의		 : 모객률 타입 정보 (조회, 생성, 저장, 삭제)
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
		fnInit();
	}

	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
			var s_temp1 = "cust_rate_type:STRING,bgn_rate:NUMBER,end_rate:NUMBER,refund_rate:NUMBER";
			ds1.SetDataHeader(s_temp1);
		}
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sCustRateType=" + sCustRateType.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm530I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow() {
		ds1.addrow();
	}
	/*
	 * 행삭제(그리드별)
	 */
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
	/*
	 * 적용
	 */
	function fnApply() {
        v_job = "I";	
		if(ds1.IsUpdated) {
            window.status="저장 중입니다. 잠시만 기다려 주십시오...";

            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm530I",
                "JSP(I:DEFAULT=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
		}
	}
	/*
	 * 취소
	 */
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
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
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert(" 검색된 데이타가 없습니다."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">	
						            			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
						            			<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
						            			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >            									            			
						            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
						            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr> 
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left width=70 class="text">&nbsp;모객률타입</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sCustRateType" type="text" class="txtbox" size=10></td>
			            				</tr>											            				
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>																           
            	<tr>
            		<td height=10  border="0"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:390px" border="1">
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="Editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="
                                            <FC> name=''             ID='{String(CURROW)}'           Width=25    align=center</FC>
                                            <FC> name='모객률 타입'    ID='cust_rate_type'          Width=90   align=left  editlimit=2 Sort=True</FC>
                                            <G> name='모객률 범위'
	                                            <C> name='시작(이상)'   ID='bgn_rate'    Width=70   align=right      Edit=Numeric	editlimit=3</C>
	                                            <C> name='종료(미만)'   ID='end_rate'    Width=70    align=right      Edit=Numeric editlimit=3</C>
   											</G>
                                            <C> name='환불률'    ID='refund_rate'          Width=60   align=right   Edit=Numeric editlimit=3 </C>   											
                            			">
                            		</object>
                            		<%=HDConstant.COMMENT_END%>
                				</td>
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


