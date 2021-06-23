<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 12일
* 요약 설명 : ceo 메시지 - 등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
	String category = "ceomessage";
%>
<html>
<head>
<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "11";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("company_main.jsp?flag=1");
	}
%>

<script language="javascript">
<!--
	function goInsert()
	{

		var form = document.form;

		if( form.title.value=="" )
		{
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}

		return true;

	}
	//-->
</script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
    </td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
			<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/common/company_leftmenu.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

                <!--contents start -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
					<form name="form" method="post" action="company_message_action.jsp" onSubmit="return goInsert()">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="cmd" value="Insert">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>CEO
                        메시지</b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">등록일</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">제목</td>
                            <td style="padding-left:5;"><input type="text" name="title" style="width:400px;height:20px" ></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                           <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">본문<br>요약</td>
                            <td style="padding-left:5;"><textarea name="summary" rows=3 cols=80 wrap="VIRTUAL"></textarea></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" valign="top"  bgcolor="F2F1E2" style="padding: 10 0 0 23 ;">내용</td>
                            <td style="padding: 10 0 10 5 ;" valign="top" >
                            	<FCK:editor id="content" basePath="/FCKeditor/"
									width="100%"
									height="300"
									toolbarSet="asan"
									customConfigurationsPath="/asanway/js/fckconfig.js"
									imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
									linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
								</FCK:editor>
                            	<!--<textarea name="textarea" rows="5" wrap="VIRTUAL" style="width:400px;"></textarea>-->
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;"><input type=image src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    </form>
                  </table>
                   <!--contents end -->

                 </td>
              </tr>
            </table>
           </td>
        </tr>
      </table>
     </td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2">
      	<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
     </td>
  </tr>
</table>
</body>
</html>
