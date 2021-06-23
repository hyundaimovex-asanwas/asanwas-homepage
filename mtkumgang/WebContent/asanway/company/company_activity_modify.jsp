<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%@ page import="com.hmm.asan.asanway.company.ActivityBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	ActivityBean ab = new ActivityBean();
	ab.Read(request, response);
%>
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />


<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 14일
* 요약 설명 : ceo 메시지 - 등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%
	String category = "ceotrend";
%>
<html>
<head>

<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "12";
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
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6"><jsp:include page="/asanway/common/company_leftmenu.jsp" flush="true" /></td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <!--content start -->
                    <form name="form" method="post" action="company_activity_update.jsp"  enctype="multipart/form-data" onSubmit="return goInsert()">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="idx" value="<%=read.get("IDX")%>">
						 <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>CEO
                        동정</b></td>
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
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value=<%= read.get("REGTIME").toString().substring(0, 10) %>></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"><input type="text" name="title" style="width:400px;height:20px" value="<%= Utility.ko((String)read.get("TITLE")) %>"></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">이미지
                              1</td>
                            <td height="25" style="padding-left:5;">
	                            <% if( read.get("IMG1") == null || read.get("IMG1").equals("") ) { %>
	                            	등록된 파일이 없습니다.
	                            <% } else { %>
									<%= Utility.ko((String)read.get("IMG1") )%>&nbsp;&nbsp;<input type="checkbox" name="imgdel1">이미지 삭제
	                            <% } %>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:5;"><input type="file" name="img1" size="31" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 204 * 163)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">이미지
                              2</td>
                            <td height="25" style="padding-left:5;">
                             	<% if( read.get("IMG2") == null || read.get("IMG2").equals("") ) { %>
	                            	등록된 파일이 없습니다.
	                            <% } else { %>
									<%= Utility.ko((String)read.get("IMG2") )%>&nbsp;&nbsp;<input type="checkbox" name="imgdel2">이미지 삭제
	                            <% } %>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:5;"><input type="file" name="img2" size="41" style="width:300px;height:20px">(* 권장 이미지 사이즈 : 204 * 163)</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">이미지
                              3</td>
                            <td height="25" style="padding-left:5;">
                            	<% if( read.get("IMG3") == null || read.get("IMG3").equals("") ) { %>
	                            	등록된 파일이 없습니다.
	                            <% } else { %>
									<%= Utility.ko((String)read.get("IMG3") )%>&nbsp;&nbsp;<input type="checkbox" name="imgdel3">이미지 삭제
	                            <% } %>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:5;"><input type="file" name="img3" size="31" style="width:300px;height:20px" >(* 권장 이미지 사이즈 : 204 * 163)</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" valign="top"  bgcolor="F2F1E2" style="padding: 10 0 0 15 ;">내용</td>
                            <td style="padding: 10 0 10 5 ;" valign="top" >
                            	<textarea name="content" rows="5" wrap="VIRTUAL" style="width:400px;"><%= Utility.ko( (String)read.get("CONTENT") ) %></textarea>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                       </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      	<input type=image src="../img/bt_08.gif" width="40" height="20" hspace="3" border="0"></a>
                      	<a href="javascript:history.back();"><img src="../img/bt_11.gif" width="40" height="20" border="0"></a>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    </form>
					<!--content end -->

                  </table>
                 </td>
              </tr>
            </table
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
    <td height="30"  bgcolor="D4D4B2"><jsp:include page="/asanway/common/copyright.jsp" flush="true" /></td>
  </tr>
</table>
</body>
</html>
