<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 포캐스팅/블록 재집계
 * 프로그램ID 	 : rm320i.jsp
 * J  S  P		 : rm320i
 * 서 블 릿		 : RM320I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-17
 * 기능정의		 :  포캐스팅/블록 재집계
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
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());
   	date.add(date.MONTH,+1);
    String lastday = m_today.format(date.getTime());
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

		var v_job = "H";
		v_req_date.text='<%=firstday%>';
		v_req_date2.text='<%=lastday%>';
		v_req_date3.text='<%=firstday%>';
		v_req_date4.text='<%=lastday%>';
		fnInit();
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "INIT";
      	 window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:UPJANG=ds1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
		if ( v_req_date.text.trim() == '' ) {
			alert("작업년월을 입력해 주세요.");
			return;
		}
	        v_job = "I";
	         window.status="집계 중입니다. 잠시만 기다려 주십시오...";

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	           + "v_upjang_sid=" + v_upjang_sid.ValueOfIndex("upjang_sid", v_upjang_sid.Index)
	           + ",v_req_date=" + v_req_date.text
	            + ",v_req_date2=" + v_req_date2.text;

	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm320I",
	            "JSP(I:DEFAULT=ds2,O:RESULT=msgDS)",
	            param);
	        tr_post(tr1);
	}
		function fnApply1() {
		if ( v_req_date.text.trim() == '' ) {
			alert("작업년월을 입력해 주세요.");
			return;
		}
	        v_job = "I";
	         window.status="집계 중입니다. 잠시만 기다려 주십시오...";

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	           + "v_req_date3=" + v_req_date3.text
	            + ",v_req_date4=" + v_req_date4.text;

	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm320I",
	            "JSP(I:DEFAULT=ds2,O:RESULT=msgDS)",
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
             alert("집계가 완료되었습니다");
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
<!-- 	<script language="javascript" for="tr1" event="onfail()">
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
	</script>		-->

	<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
   window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="")
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
				<tr height="50px">
       				<td align="left"   width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
						  <tr>
       				        <td  width="645px">
								<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
									<tr>
	                             		<td align=left class="text"  width="100" >블록실적 재집계</td>
										<td width="260px" height="25px" bgcolor="#ffffff" colspain=2></td>
										<td align=left class="text"  width="70"><b>기간</b></td>
										<td align=left bgcolor="#ffffff">&nbsp;
											<%=HDConstant.COMMENT_START%>
											<object id=v_req_date3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
											<param name=Text     value="">
											<param name=Alignment   value=1>
											<param name=Format      value="0000-00-00">
											<param name=Cursor      value="iBeam">
											<param name=Border      value="false">
											<param name=InheritColor      value="true">
											<param name=ReadOnly    value="false">
											<param name=SelectAll   value="true">
											<param name=SelectAllOnClick     value="true">
											<param name=SelectAllOnClickAny     value="false">
											</object>
											<%=HDConstant.COMMENT_END%>&nbsp;~
											<%=HDConstant.COMMENT_START%>
											<object id=v_req_date4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
											<param name=Text     value="">
											<param name=Alignment   value=1>
											<param name=Format      value="0000-00-00">
											<param name=Cursor      value="iBeam">
											<param name=Border      value="false">
											<param name=InheritColor      value="true">
											<param name=ReadOnly    value="false">
											<param name=SelectAll   value="true">
											<param name=SelectAllOnClick     value="true">
											<param name=SelectAllOnClickAny     value="false">
											</object>
											<%=HDConstant.COMMENT_END%>
										</td>
									</tr>
								</table>
							</td>
							<td align="right" height="30px"><img src="<%=dirPath%>/Sales/images/save.gif"      style="cursor:hand" onClick="fnApply1();">
							</td>
						  </tr>
						</table>
					</td>
				</tr>
				<tr height="40px"><td>&nbsp;</td></tr>
				<tr height="30px">
					<td> * 블록실적 재집계 적용 후 포캐스팅 재집계를 하셔야지 포캐스팅이 정확하게 반영됩니다...</td>
				</tr>
				<tr height="50px">
					<td align="left"   width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr height="30">
								<td  width="645px">
	    							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	    								<tr bgcolor="#6f7f8d">
	    							    	<td align=left class="text"  width="100">포케스팅 재집계</td>
	    							        <td width="100px" height="25px" class="text">업장명</td>
	    							        <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
	    							        	<object id=v_upjang_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
	    							            <param name=ComboDataID		value=ds1>
												<param name=EditExprFormat	value="%;upjang_nm">
												<param name=ListExprFormat  value="upjang_nm^0^120">
	    	            						</object>
	    	            						<%=HDConstant.COMMENT_END%>
	    	        						</td>
											<td align=left class="text"  width="70"><b>기간</b></td>
	    	        						<td align=left bgcolor="#ffffff">&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=v_req_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
													<param name=Text 		value="">
													<param name=Alignment 	value=1>
													<param name=Format 		value="0000-00-00">
													<param name=Cursor	 	value="iBeam">
													<param name=Border	 	value="false">
													<param name=InheritColor      value="true">
													<param name=ReadOnly  	value="false">
													<param name=SelectAll  	value="true">
													<param name=SelectAllOnClick  	value="true">
													<param name=SelectAllOnClickAny  	value="false">
												</object>
												<%=HDConstant.COMMENT_END%>&nbsp;~
												<%=HDConstant.COMMENT_START%>
												<object id=v_req_date2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
													<param name=Text 		value="">
													<param name=Alignment 	value=1>
													<param name=Format 		value="0000-00-00">
													<param name=Cursor	 	value="iBeam">
													<param name=Border	 	value="false">
													<param name=InheritColor      value="true">
													<param name=ReadOnly  	value="false">
													<param name=SelectAll  	value="true">
													<param name=SelectAllOnClick  	value="true">
													<param name=SelectAllOnClickAny  	value="false">
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>
										</tr>
									</table>
								</td>
								<td align="right" height="30px"><img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
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

