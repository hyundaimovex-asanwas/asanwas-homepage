<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 10일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	NewsBean nb = new NewsBean();
	nb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />


<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "13";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>


<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>

<script language="javascript">
<!--
	function goUpdate()
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
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">


				<form name="form" method="post" action="cyber_news_update.jsp" enctype="multipart/form-data"  onSubmit="return goUpdate()">
				<input type="hidden" name="idx" value="<%= read.get("IDX") %>">

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>뉴스 등록
					</b></td>
                    </tr>
                    <tr>
                      <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="0" height="125">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">등록일</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this);  value=<%= read.get("REGTIME").toString().substring(0, 10) %>></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value='<%= Utility.ko((String)read.get("TITLE")) %>'>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">섬네일 이미지</td>
                            <td height="30" style="padding-left:5;">
                            <% if( read.get("IMGFILE") == null || read.get("IMGFILE").equals("") ) { %>
                            	등록된 파일이 없습니다.
                            <% } else { %>
								<%= read.get("IMGFILE") %>&nbsp;&nbsp;<input type="checkbox" name="imgfiledel">이미지 삭제
                            <% } %>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:5;"><input type="file" name="imgfile" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 79 * 62)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>본문<br>요약</p></td>
                            <td  style="padding: 10 10 10 10 ;">
                            <textarea name="summary" rows="3" wrap="VIRTUAL" style="width:400;"><%= Utility.ko( (String)read.get("SUMMARY")) %></textarea>
							</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>내용</p></td>
                            <td  style="padding: 10 10 10 10 ;"><!-- <textarea name="textarea" rows="5" wrap="VIRTUAL" style="width:400;"></textarea>-->
								<FCK:editor id="content" basePath="/FCKeditor/"
									width="100%"
									height="300"
									toolbarSet="asan"
									customConfigurationsPath="/asanway/js/fckconfig.js"
									imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
									linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
									<%= Utility.ko( (String)read.get("CONTENT") ) %>
								</FCK:editor>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                        <div align="right">
                        <input type="image" src="../img/bt_08.gif" width="40" height="20" hspace="4" border="0">
                        <a href="#" javascript="history.go(-1);"><img src="../img/bt_11.gif" width="40" height="20" border="0"></a>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>

                  </form>

                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
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
