<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 객실정보 보기 (투숙)
 * 프로그램ID   : rm120h
 * J  S  P      : RM120H
 * 서 블 릿     : RM120H
 * 작 성 자     : 이병욱
 * 작 성 일     : 2006-08-16
 * 기능정의		: 객실 평면(객실배정, 이용현황)에서 파라미터를 받아서
 *				  해당기간 + 객실의 사용정보를 보여준다.
 * [수  정   일  자][수정자] 내용
 * [2008-02-20][심동현] 투숙인원 보기 (상태 4,5)
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
   	String	sRoomStatus = HDUtil.nullCheckStr(request.getParameter("sRoomStatus")); // 방상태 
	int 	sRoomSid	= HDUtil.nullCheckNum(request.getParameter("sRoomSid"));	// 방sid
   	String	sBgnDate	= HDUtil.nullCheckStr(request.getParameter("sBgnDate")); 	// 사용시작일자
   	String	sEndDate	= HDUtil.nullCheckStr(request.getParameter("sEndDate")); 	// 사용종료일자
    
			          
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/***************************************************************************
 *                            사용자 정의 Java Script                       *
 ***************************************************************************/
%>
<script language="javascript">
    
	function fnOnLoad() {
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
        	  	+ ",dsType=1"
				+ ",sRoomSid=<%=sRoomSid%>"
				+ ",sRoomStatus=<%=sRoomStatus%>"
				+ ",sBgnDate=<%=sBgnDate%>"
				+ ",sEndDate=<%=sEndDate%>";
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm120H",
		    "JSP(O:DS1=ds1)",
		    param);
		tr_post(tr1);
    }
    
    //창 닫기
	function hidePop()
	{
		var win = parent.window.document.all.roomInfoWin;
		win.src = "";
		win.style.display = "none";
	};
	
	
	// Description 	:  행추가 (그리드별)
	function fnAddRow() {
		ds1.addRow();
		ds1.namevalue(ds1.rowposition,"ROOM_SID") 	= <%=sRoomSid%>;
		ds1.namevalue(ds1.rowposition,"KEY_SEQ") 	= 0;
		ds1.namevalue(ds1.rowposition,"ROOM_STATUS")= "OO";
	};

	// Description 	:  행삭제 (그리드별)
	function fnDeleteRow() {
		ds1.DeleteRow(ds1.RowPosition);
	};

	// Description 	:  적용
	function fnApply() {
		if (ds1.IsUpdated) {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
					+ ",sRoomSid=<%=sRoomSid%>";
			ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm120H",
		    "JSP(I:DS1=ds1,O:RESULT=ds_result)",
		    param);
            
	   		tr_post(tr1);
		}	
	};
	
	// Description :  취소
	function fnCancel() {
        ds1.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
	}
		
	
</script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
//            document.all.LowerFrame.style.visibility="visible"; 
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
//            document.all.LowerFrame.style.visibility="hidden";
if(row==0){
    alert("<%=HDConstant.S_MSG_NO_DATA%>");
//                window.close();
}
</script>
<script language=JavaScript  for=ds1 event="OnLoadError()">
    ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//    document.all.LowerFrame.style.visibility="hidden";
</script>


<%=HDConstant.COMMENT_START%>       
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head> 
    
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<!-- 여기가 화면폼 -->
<table border="0" cellpadding="0" cellspacing="0" width="350">
  <tr>
	<td align=center>

<%
if(sRoomStatus.equals("6")) {	//고장객실의 경우
%>
		<table border="0" cellspacing="0" cellpadding="0" bgcolor="#fdfde7">
			<tr height=30>
				<td background="<%=dirPath%>/Sales/images/map/w_bg.gif" align="center"><input type=text  id=box_txt1 style="border:0 solid #ffffff;font-size:14px;font-weight:bold;color:white;width:100%;text-align:center;background:#73be10;"></td>	
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td align="center">
					<table width="290" height="120" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_1.gif"></td>
							<td background="<%=dirPath%>/Sales/images/map/wr_2.gif"></td>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_3.gif"></td>
						</tr>
						<tr>
							<td background="<%=dirPath%>/Sales/images/map/wr_8.gif">&nbsp;</td>
							<td bgcolor="#FFFFFF" align=center>
								<table border="0" cellspacing="0" cellpadding="0">
									<tr height=26>
										<td align="RIGHT" colspan=3>
											<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
											<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">
											<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
											<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
										</TD>
									</TR>
									<tr height=26>
										<td align="center" colspan=3>
											<%
											/*---------------------------------------------------------------------------->
												Object ID   : 그리드 , gr1
												Data ID     : ds1
												관광객 리스트
											-----------------------------------------------------------------------------*/
											%>
											<%=HDConstant.COMMENT_START%>
											<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='500' height='160px' border=1>
												<param name="DataID"        value="ds1">
												<param name="BorderStyle"   value="0"> 
												<param name="ColSizing"     value="true">
												<param name="Fillarea"      value="true">
												<param name="AutoResizing"  value=true> 
												<param name="Editable"      value="true">
												<param name="SuppressOption"    value="1">
												<param name=ViewSummary     value=0>
												<param name="Format"        value="
													<C> name='No.'			ID='{CURROW}'	width=30 align=center editlimit=52 show=true edit=none</C>
													<C> name='고장 시작'	ID='BGN_DATE'	 	width=60 align=center editlimit=50 show=true</C>
													<C> name='고장 종료'	ID='END_DATE'	 	width=60 align=center editlimit=50 show=true</C>
													<C> name='사유'			ID='REMARKS'	width=260 align=LEFT editlimit=52 show=true</C>
													<C> name='등록자'		ID='EMP_NM'	 	width=80 align=center editlimit=50 show=true edit=none</C>
													<C> name='룸SID'		ID='ROOM_SID'	 	width=80 align=center editlimit=50 show=true edit=none</C>
													<C> name='키'			ID='KEY_SEQ'	 	width=80 align=center editlimit=50 show=true edit=none</C>
													<C> name='상태'			ID='ROOM_STATUS'	width=80 align=center editlimit=50 show=true edit=none</C>
												">
											</object>
											<%=HDConstant.COMMENT_END%> 
										</td>	
									</tr>
								
								</table>
							</td>
							<td background="<%=dirPath%>/Sales/images/map/wr_4.gif">&nbsp;</td>
						</tr>
						<tr>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_7.gif"></td>
							<td background="<%=dirPath%>/Sales/images/map/wr_6.gif"></td>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_5.gif"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
		</table>
<%
} else {	// 나머지 배정객실의 경우
%>


		<table border="0" cellspacing="0" cellpadding="0" bgcolor="#fdfde7">
			<tr height=30>
				<td background="<%=dirPath%>/Sales/images/map/w_bg.gif" align="center"><input type=text  id=box_txt1 style="border:0 solid #ffffff;font-size:14px;font-weight:bold;color:white;width:100%;text-align:center;background:#73be10;"></td>	
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td align="center">
					<table width="290" height="120" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_1.gif"></td>
							<td background="<%=dirPath%>/Sales/images/map/wr_2.gif"></td>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_3.gif"></td>
						</tr>
						<tr>
							<td background="<%=dirPath%>/Sales/images/map/wr_8.gif">&nbsp;</td>
							<td bgcolor="#FFFFFF" align=center>
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td colspan=3 bgcolor=#cccccc height=1></td>
									</tr>

									<tr height=26>
										<td align="center" colspan=3>
											<%
											/*---------------------------------------------------------------------------->
												Object ID   : 그리드 , gr1
												Data ID     : ds1
												관광객 리스트
											-----------------------------------------------------------------------------*/
											%>
											<%=HDConstant.COMMENT_START%>
											<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='500' height='160px' border=1>
												<param name="DataID"        value="ds1">
												<param name="BorderStyle"   value="0"> 
												<param name="ColSizing"     value="true">
												<param name="Fillarea"      value="true">
												<param name="AutoResizing"  value=true> 
												<param name="Editable"      value="false">
												<param name="SuppressOption"    value="1">
												<param name=ViewSummary     value=0>
												<param name="Format"        value="
													<C> name='No.'			ID='{CURROW}'	width=30 align=center editlimit=52 show=true</C>
													<C> name='성명'			ID='CUST_NM'	width=60 align=center editlimit=52 show=true</C>
													<C> name='주민/여권'	ID='MANAGE_NO'	width=100 align=center editlimit=52 show=true</C>
													<C> name='관계'			ID='JOIN_NM'	width=50 align=center editlimit=50 show=true</C>
													<C> name='반'			ID='CLASS_NM'	width=50 align=center editlimit=50 show=true</C>
													<C> name='조'			ID='TEAMS'	 	width=30 align=center editlimit=50 show=true</C>
													<C> name='투숙기간'		ID='PERIOD'	 	width=120 align=center editlimit=50 show=true</C>
													<C> name='신청서번호'	ID='ACCEPT_NO'	width=100 align=center editlimit=50 show=true</C>
													<C> name='상품'			ID='GOODS_NM'	width=80 align=center editlimit=50 show=true</C>
													<C> name='대리점'		ID='CLIENT_NM'	width=100 align=center editlimit=50 show=true</C>
												">
											</object>
											<%=HDConstant.COMMENT_END%> 
										</td>	
									</tr>
								
								</table>
							</td>
							<td background="<%=dirPath%>/Sales/images/map/wr_4.gif">&nbsp;</td>
						</tr>
						<tr>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_7.gif"></td>
							<td background="<%=dirPath%>/Sales/images/map/wr_6.gif"></td>
							<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_5.gif"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
		</table>
<%
};
%>
	</TD>
  </tr>
  <tr>
	<td align=center><img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="hidePop();"></td>
  </tr>
</table>

<!-- 데이터 바인딩 : USERFILE  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
  <PARAM NAME="DataID" VALUE="ds1">
  <PARAM NAME="BindInfo" VALUE="
	<C>Col=ROOM_TITLE Ctrl=box_txt1 Param=value</C>
  ">
</OBJECT>
<%=HDConstant.COMMENT_END%> 


</body>
<!-- BODY END -->
</html>