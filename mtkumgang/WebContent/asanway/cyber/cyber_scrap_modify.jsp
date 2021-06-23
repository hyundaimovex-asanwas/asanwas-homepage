<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>


<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 15일
* 요약 설명 : 스크랩 마스터 공통 (신문, 잡지, 방송, 인터넷)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	String menutitle = "";
	String downfolder = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.  다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("magazine")){
			menutitle = "스크랩마스터 - 잡지기사 스크랩";
			downfolder = "scrap";

		}else if(category.equals("broadcast")){
			menutitle = "스크랩마스터 - 방송기사 스크랩";
			downfolder = "scrap";

		}else if(category.equals("internet")){
			menutitle = "스크랩마스터 - 인터넷 기사 스크랩";
			downfolder = "scrap";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다. 다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}
%>

<%
	ScrapBean bean = new ScrapBean(category);
	bean.Read(request, response);

%>


<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "20";
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
		form.action = "cyber_scrap_action.jsp?category=<%=category%>&cmd=I" ;
		form.target = "_self";
		return true;

	}

	function _preView(img){
		var form = document.form;
		form.target = "pop";
		form.action = "cyber_scrap_preview.jsp?preimg=" + img  ;
		window.open("","pop"," width=1024, height=768, top=100, left=200, scrollbars=yes");
		form.submit();
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
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

				<form name="form" method="post" action="cyber_scrap_action.jsp?category=<%=category%>&cmd=U" enctype="multipart/form-data" onSubmit="return goUpdate()">
					<input type="hidden" name="idx" value="<%= read.get("IDX") %>">

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b> <%=menutitle%>
                        수정</b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="187">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value='<%= Utility.ko( (String)read.get("TITLE") ) %>'>
                            </td>
                          </tr>

						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">발행일 </td>
                            <td style="padding-left:5;"><input type="text" name="pubdate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value=<%=  (read.get("PUBDATE") == null)?"":read.get("PUBDATE").toString().substring(0, 10) %>></td>
                          </tr>

						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">매체</td>
                            <td style="padding-left:5;"> <input type="text" name="section2" style="width:400px;height:20px" value='<%= (read.get("SECTION2") == null)?"":Utility.ko( (String)read.get("SECTION2") ) %>'>
                            </td>
                          </tr>

						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">기사구분</td>
                            <td style="padding-left:5;">
                            	<select name="section1"  style="width:150px;height:20px" >
                                      <option value="1" <% if( read.get("SECTION1").equals("1") ) { %>selected<% } %>>사업관련기사</option>
                                      <option value="2" <% if( read.get("SECTION1").equals("2") ) { %>selected<% } %>>한반도관련기사</option>
                                      <option value="3" <% if( read.get("SECTION1").equals("3") ) { %>selected<% } %>>기타 </option>
                                </select>
                            </td>
                          </tr>

						 <%if(category.equals("magazine")) { %>
	                         <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">기사  이미지</td>
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
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" style="padding-left:5;"><input type="file" name="imgfile" style="width:300px;height:20px" >
	                            </td>
	                          </tr>
						<% } %>

						<%if(category.equals("broadcast")) { %>
							  <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">동영상 주소 </td>
	                            <td style="padding-left:5;"> <input type="text" name="fileloc" style="width:400px;height:20px" value="<%= (read.get("FILELOC") == null)?"":read.get("FILELOC")%>">
	                            </td>
	                          </tr>
						  <%}%>

						<%if(!category.equals("magazine")) { %>
	 						 <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                      	  </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>내용</p></td>
	                            <td  style="padding: 10 10 10 10 ;"> <!-- <textarea name="textarea" rows="5" wrap="VIRTUAL" style="width:400;"></textarea> -->
									<FCK:editor id="content" basePath="/FCKeditor/"
										width="100%"
										height="300"
										toolbarSet="asan"
										customConfigurationsPath="/asanway/js/fckconfig.js"
										imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
										linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
										<%=(read.get("CONTENT") == null)?"":Utility.ko( (String)read.get("CONTENT")) %>
									</FCK:editor>
	                            </td>
	                          </tr>
	                       <%}%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                        </table></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <div align="right">
                      	 <%if(category.equals("magazine")) { %><a href="javascript:_preView('<%= read.get("SYSIMGFILE") %>');"><img  src="/img/scrap/bt_preview.gif" border="0"></a><%}%>
                      	<input type="image" src="../img/bt_08.gif" hspace="4" border="0">
                      	<a href="#" onClick="javascript:history.back()"><img src="../img/bt_11.gif" border="0"></a>
                        </div></td>
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
