<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 고객정보
 * 프로그램ID   : RV012H (코드는 대문자)
 * J  S  P      : rv012h (jsp파일명은 소문자로 한다 )
 * 서 블 릿        : Rv012H
 * 작 성 자        : 안준성
 * 작 성 일        : 2006-07-27
 * 기능정의     : 취소환불화면 고객정보 팝업
 * [ 수정일자 ][수정자] 내용
 * [2008-11-14][심동현] 노쇼자 저장 시 작업유형=환불만 가능하도록 제약
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
	String sClientSid = request.getParameter("sClientSid");	
    String sAcceptSid = request.getParameter("sAcceptSid");
    String sAcceptDate = request.getParameter("sAcceptDate");
    String sAcceptTime = request.getParameter("sAcceptTime");    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>고객정보　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
		        cfStyleGrid(getObjectFirst("gr1"), "comn1");
				fnSelect();		        	        
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			 
			function fnSubSelect1() {
		        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>"; 			
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClientSid=<%=sClientSid%>"
			          + ",sAcceptSid=<%=sAcceptSid%>"
			          + ",sAcceptDate=<%=sAcceptDate%>"
			          + ",sAcceptTime=<%=sAcceptTime%>"
			          + ",sCustNm=" + sCustNm.value
			          + ",dsType=1";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv012H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
				if(ds1.namevalue(row, "status_cd")=="NS"){ <%//노쇼인 경우%>
					alert("예약상태가 NoShow인 경우 요청이 불가능합니다.\n먼저 운영팀에 예약상태=취소로 수정해달라고 요청해주세요.");
					return;
				}

				window.returnValue = ds1.namevalue(row, "cust_sid") + ";" +		//0
									 ds1.namevalue(row, "cust_nm")  + ";" +
								 	 ds1.namevalue(row, "manage_no")   + ";" +
                                     ds1.namevalue(row, "company_nm") + ";" +
								 	 ds1.namevalue(row, "positions") + ";" +
								 	 ds1.namevalue(row, "mobile_no") + ";" +
								 	 ds1.namevalue(row, "upjang_sid") + ";" +
								 	 ds1.namevalue(row, "a_room_type_sid") + ";" +
								 	 ds1.namevalue(row, "rsv_sid") + ";" +
								 	 ds1.namevalue(row, "a_sal_amt") + ";" +
								 	 ds1.namevalue(row, "pay_amt") + ";" +		//10
								 	 ds1.namevalue(row, "a_room_type_cd") + ";" +
								 	 ds1.namevalue(row, "a_room_type_nm") + ";" +
								 	 ds1.namevalue(row, "upjang_cd") + ";" +
								 	 ds1.namevalue(row, "upjang_nm") + ";" +
								 	 ds1.namevalue(row, "depart_date") + ";" +	//15
								 	 ds1.namevalue(row, "depart_time") + ";" +
								 	 ds1.namevalue(row, "charge_rate") + ";" +
								 	 ds1.namevalue(row, "goods_nm") + ";" + 	//상품명
								 	 ds1.namevalue(row, "goods_sid") + ";" + 	//상품sid
								 	 ds1.namevalue(row, "confirm_yn") + ";" + 	//운영마감
								 	 ds1.namevalue(row, "status_nm") + ";" + 	//예약상태명
								 	 ds1.namevalue(row, "status_cd");			//예약상태코드
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
// Description 	:  그리드 더블클릭 이벤트 발생
//
%>			
	<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		fnAdd();
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
		<table border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="479px">
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">고객정보</font>
							</td>
						</tr>
						<tr>
							<td>
								<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
									<tr>
										<td class="text" width="80px" height="30" style="border:1 solid #708090">성명</td>
										<td width="110px" style="border:1 solid #708090;border-left-width:0px">
											<input type="text" name="sCustNm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
										</td>
									</tr>
								</table>
							</td>	
							<td>
								<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
									<tr>
										<td align=right>
										    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="고객정보를 검색합니다" style="position:relative;left:8px;top:0px;cursor:pointer;" onclick="fnSelect();">&nbsp;&nbsp;
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:pointer;" onClick="fnClose()">                          
										</td>
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
					<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:280px;" border="1">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit가능  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
                        <param name="SortView"      value="Right">						
						<param name="LineColor" 	value="#dddddd">
						<param name="ViewSummary" 	value="1">
						<param name="Format" 		value="
                            <FC> name=''            ID='{String(CURROW)}'        Width=25    align=center </FC>
			                <C> name='고객SID'			ID='cust_sid'    align=left editlimit=12 show=false</C>
			                <C> name='한글성명'			ID='cust_nm'  width=80   align=left editlimit=30 show=true sort=true  Sumtext=@cnt</C>
			                <C> name='주민/여권번호'	ID='manage_no'  width=110 align=center editlimit=20 show=true sort=true  Sumtext='명'</C>
			                <C> name='운영\\마감'		ID='CONFIRM_YN'  width=50 align=center show=true </C>
			                <C> name='예약\\상태'		ID='STATUS_CD'  width=50 align=center show=true </C>
			                <C> name='직장명'   		ID='company_nm' width=100 align=left editlimit=30 show=true</C>
			                <C> name='직위'    			ID='positions' width=50  align=left editlimit=30 show=true</C>
			                <C> name='휴대폰'    		ID='mobile_no' width=90  align=left editlimit=15 show=true</C>
			                <C> name='업장SID'   		ID='upjang_sid'  align=left editlimit=12 show=false</C>
							<C> name='업장'				ID='upjang_cd'	 width=60 align=center editlimit=10 show=true</C>
							<C> name='업장명'			ID='upjang_nm'	width=110 align=left editlimit=50 show=true</C>			                
			                <C> name='신청객실타입SID'  ID='a_room_type_sid'     align=left editlimit=12 show=false</C>
							<C> name='신청객실타입'		ID='a_room_type_cd' width=80	 align=center editlimit=10 show=true</C>
							<C> name='신청객실타입명'	ID='a_room_type_nm'	width=90 align=left editlimit=50 show=true</C>			                
			                <C> name='예약SID'      	ID='rsv_sid'     align=left editlimit=12 show=false</C>
			                <C> name='판매액'    		ID='a_sal_amt' width=70  align=right editlimit=33 show=true Value={Number(a_sal_amt)}</C>
			                <C> name='입금액'      		ID='pay_amt'   width=70  align=right editlimit=33 show=true Value={Number(pay_amt)}</C>
   			                <C> name='출경일자'      	ID='depart_date'   width=70  align=center show=true mask=XXXX-XX-XX</C>
			                <C> name='출경시간'      	ID='depart_time'   width=60  align=center show=true</C>			                			                
			                <C> name='표준공제율'		ID='charge_rate'  width=70   align=right dec=0 show=true</C>			                			                			                
						">
					</object>
					<%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td>
				<!--  상태바 플레쉬  -->
			<iframe id="LowerFrame" 
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.jpg" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>