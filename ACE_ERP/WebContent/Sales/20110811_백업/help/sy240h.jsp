<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 회계 전표분개 기초등록 (ACTCODE) 팝업 
 * 프로그램ID 	: SY
 * J  S  P		: tsy240_pop
 * 서 블 릿		: Tsy240
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-01
 * 기능정의		: 계정코드 조회, 등록, 삭제 엑셀, 팝업조회 , 검색 
 * 수정내용		: 
 * 수 정 자		: 
 * 최종수정일자 	: 
 * TODO			: 1. xxxxxx 미처리
 * TODO			: 2. yyyyyy 미처리 
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	String atCode = sales.common.HDUtil.nullCheckStr(request.getParameter("atcode"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>계정코드&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
		<script language="javascript">
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ACTCODE 조회
// Parameter 	: 
%>			
			function fnSelect() {
				ds3.ClearAll();
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy240I?dsType=3&proType=S&sAtCode=" + searchKeyAtCode.value;
				ds3.Reset();
			}
		
		
			function fnAdd() {
				On_Change();
			 	fnClose();
			}
			
			function fnClose() {
				window.close();
			}
			
			
		</script>
		
		<SCRIPT LANGUAGE="javascript">
   			 function On_Change(){
     		 var Row = ds3.RowPosition;
      		 window.returnValue = ds3.NameString(Row, "atcode") + ";" + ds3.NameString(Row, "atkornam") ;
     		 window.close();
   				 }
    		function On_Cancel(){
      		window.close();
    		}
  		</Script>
  		
  		<SCRIPT LANGUAGE=javascript FOR=gr1 EVENT=OnDblClick>
   			 On_Change();
  		</script>
  		
  		<script language=JavaScript> 
			function Start() 
			{ 
			    tbgd.AutoResizing=true; 
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
		<script language=JavaScript  for=ds3 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>			
		<script language=JavaScript  for=ds3 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>

		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>		
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>			
		<comment id="__NSID__"><object id="ds3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>			
		<comment id="__NSID__"><object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
			<param name="KeyName" value="toinb_dataid4">
		</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
	</head>	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="javascript:fnSelect();">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">계정코드</font>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">코드/명</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input type="text" name="searchKeyAtCode" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="코드/명을 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			</tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;border:1 solid #777777;">
						<param name="DataID"		value="ds3">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit가능  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="Format" 		value="
							<c> Name='코        드'		ID='atcode'			HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center </c>
							<c> Name='코   드   명' 		ID='atkornam'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=379  LeftMargin=50 </c>
							
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
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
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>