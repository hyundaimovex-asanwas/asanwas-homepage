<%
/******************************************************************************
 * 시스템명 		: 공통코드 관리 (팝업)
 * 프로그램ID 	: SAMPLE_POP (코드는 대문자)
 * J  S  P		: sample_popup (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Sample
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-02
 * 기능정의		: 
 * 수정내용		: 
 * 수 정 자		: 이병욱
 * 수정일자 		: 2006-05-02 
 * TODO			: 
 *				: 
 *****************************************************************************/
%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="sales.common.*"%>
<%
/*=============================================================================
				JAVA CLASS IMPORT
=============================================================================*/
%>	
<%@ page import="sales.common.*"%> 


<%
	// ContextPath
	String dirPath = request.getContextPath();
	
	// Opener 에서 넘어오는 파라미터 
	String head = HDUtil.nullCheckStr((String)request.getParameter("head"));
	String headName = HDUtil.nullCheckStr((String)request.getParameter("headName"));
%>

<html>
	<head>
		<title>공통코드 팝업(화면명)</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%
/*=============================================================================
				Style Sheet, Common Java Script Link
=============================================================================*/
%>	
		<link rel="stylesheet" href="<%=dirPath%>/Sales/common/include/common.css">
		<Script language="javascript" src="<%=dirPath%>/Sales/common/include/PubFun.js"></script>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
		<script language="javascript">
			get_cookdata();
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
			function fnOnLoad(){
			  
				var strParam = new Array();
				strParam=window.dialogArguments;
			
				if(strParam.length==0){
				}else if(strParam.length==1){
				}else if(strParam.length==2) {
				} 
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  조회1
// Parameter 	: 
%>
			function fnSelectDs1(){
				 ds1.DataID = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Sample?proType=S&dsType=1&s_Head=" + head.value + "&s_HeadName=" + headName.value;
				 ds1.Reset(); 		
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  팝업창 닫기
// Parameter 	: A - 선택
%>			
			function fnClose(p){
				if (p=="A") {
					var row = ds1.rowposition;
					window.returnValue = 	ds1.namevalue(row,"head")  + ";" 
				                   	 	+ 	ds1.namevalue(row,"head_name");
					window.close();
				} else {
					window.close();
				}
			}
		</script>
		
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
		<object id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
			<PARAM name="SyncLoad" value="false">
		</OBJECT>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language="javascript" for="ds1" event="OnLoadStarted()">
			ft_cnt1.innerText="데이타 조회중입니다.";
			document.all.LowerFrame.style.visibility="visible";
		</script>
		
		<script language="javascript" for="ds1" event="onloadCompleted(row,colid)">
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			if(ds1.countrow <=0)
					alert("조회된 데이타가 없습니다.");
		</script>
		
		<script language="javascript" for="gcgd_disp1" event="OnDblClick()">
			ln_Close('A');
		</script>
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	</HEAD>
	
<!--------------------------------- BODY START ------------------------------->
	<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="fnOnLoad()">
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:478px;border:1 solid #708090">
			<tr>
				<td class="text" width="65px" height="30">분류코드</td>
				<td width="110px">
					<input type="text" class="txt11" id="txt_detail" name="head" value="<%=head %>" style="position:relative;left:3px;width:100px;" onkeydown="if(event.keyCode==13) fnSelectDs1();"  maxlength="30">
				</td>
				<td class="text" width="60px;" height="30">분류명</td>
				<td width="60px">
					<input type="text" class="txt11" id="txt_detail_name" name="headName" value="<%=headName %>" style="position:relative;left:3px;width:50px;" onkeydown="if(event.keyCode==13) fnSelectDs1();"  maxlength="7">
				</td>
				<td><img src="<%=dirPath%>/Sales/images/p_search.gif" alt="분류코드를 검색합니다" style="position:relative;left:130px;top:0px;cursor:hand;" onclick="fnSelectDs1()"></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
			<tr>
				<td class="tab21" colspan="3">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp1 style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
						<param name="DataID"		value="ds1">
					  	<param name="BorderStyle"	value="0">
					 	<param name="Indwidth"		value="0">
						<param name="Fillarea"		value="true">
						<param name="sortview"    	value=left>
					  	<param name="Format"		value="  
							<C>ID=head,		 	Name=분류코드,   	  width=120,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
							<C>ID=head_name,	Name=분류명, width=335,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
						">
			    	</object>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:478;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
						&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
					</fieldset>
				</td>
			</tr>
			<tr><td height="4px"></td></tr>
			<tr>
				<td height="30px;" align="center">
					<img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand" onClick="fnClose('A')">
					<img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand" onClick="fnClose('C')">
				</td>
			</tr>
		</table>
	
<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:280px; top:220px;" 
			FrameBorder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe> 
<!--------------------------------- BODY E N D ------------------------------->		
	</body>
</html>