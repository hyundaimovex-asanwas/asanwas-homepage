<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 방장 정보 팝업 (취소복구할 때 사용함..)
 * 프로그램ID   : RV017H (코드는 대문자)
 * J  S  P      : rv017h (jsp파일명은 소문자로 한다 )
 * 서 블 릿     : Rv012H
 * 작 성 자     : 심동현
 * 작 성 일     : 2008-03-28
 * 기능정의     : 방장 정보 팝업 (취소복구- rv505i.jsp에서 사용함..)
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
	String sClientSid = request.getParameter("sClientSid");	
    String sAcceptSid = request.getParameter("sAcceptSid");	//신청서번호
    String sAcceptDate = request.getParameter("sAcceptDate");
    String sAcceptTime = request.getParameter("sAcceptTime");    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>방장 선택　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
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
//				fnShowLoading(410,180);	//로딩바 띄우기
			    var v_param = "proType=S"
			                + ",v_accept_sid=<%=sAcceptSid%>" 
			                + ",v_accept_check=N";
			    ln_TRSetting(tr1, 
			                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv200I",
			                "JSP(O:TOUR=ds1)",
			                v_param);
			    tr_post(tr1);
			}
			 
			
			function fnAdd() {
				var row = ds1.rowposition;
				
				if(ds1.namevalue(row, "join_cd")=="01"){
					window.returnValue = ds1.namevalue(row, "cust_nm")  + ";" +
									 	 ds1.namevalue(row, "rsv_sid") + ";" 
					fnClose();					
				}else{
					alert("본인(노랑색)을 선택하셔야 합니다.");
					return false;
				}

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
		if(ds1.namevalue(row, "max_persons")>ds1.namevalue(row, "ppl_in_room")){
			fnAdd();			
		}else{
			alert("최대 정원에 도달하여 선택한 방에 들어갈 수 없습니다.\n 다른 방장을 선택해주세요.");
			return false;
		};

	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			fnHideLoading();		
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
	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>
	
		<table border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="479px">
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">방장 선택</font>
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
										    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="고객정보를 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">&nbsp;&nbsp;
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
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
	                <object classid=<%=HDConstant.CT_GRID_CLSID%> id=gr1 style="width=479px; height:290" border="1">
	                    <param name="DataID"        VALUE="ds1">
	                    <param name="BorderStyle"   VALUE="0">
	                    <param name=ColSizing       value="true">
	                    <param name="editable"      value="true">
	                    <Param Name="SuppressOption"      value="1">
	                    <param name=ViewSummary     value=1>
	                    <Param Name="SortView"     value="Right">
	                    <param name="Format"         VALUE="
	                        <C> name='객실등급'   	ID='ROOM_TYPE_CD'  Width=70   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left SumText='인원/금액' suppress=1 sort=true</C>
	                        <C> name='성명 성별(방장)'	ID='CUST_NM'   Width=160   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left SumText=@count SumTextAlign=right sort=true</C>
	                        <C> name='주민등록번호' ID='MANAGE_NO'     Width=90   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left</C>
	                        <C> name='최대정원'     ID='MAX_PERSONS'  Width=70   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right</C>
	                        <C> name='동숙인원'     ID='PPL_IN_ROOM'  Width=70   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right</C>
	                        <C> name='판매가'       ID='TOUR_AMT'      Width=65   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right SumText=@sum SumTextAlign=right dec=0 Show=False</C>
	                    ">
	                </object>
	                <%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>