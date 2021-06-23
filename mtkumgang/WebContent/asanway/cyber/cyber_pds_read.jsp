<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 21일
* 요약 설명 : 자료실 view (문서, 관련법률, 기타 자료실 공통)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.PdsBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	String menutitle = "";
	String downfolder = "";
	String menuidx = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("pdsdoc")){
			menutitle = "문서자료";
			downfolder = "pdsdoc";
			menuidx = "23";
		}

		else if(category.equals("pdslaw")){
			menutitle = "관련법규";
			downfolder = "pdslaw";
			menuidx = "24";
		}

		else if(category.equals("pdsetc")){
			menutitle = "기타";
			downfolder = "pdsetc";
			menuidx = "26";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다.다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

%>

<%
	PdsBean bean = new PdsBean(category);
	bean.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="fileread" class="java.util.ArrayList" scope="request" />

<jsp:useBean id="preview" class="java.util.HashMap" scope="request" />
<jsp:useBean id="nextview" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			// 확인 버튼을 눌렀을 때 실행해야 할 프로그램
			location.href="/asanway/cyber/cyber_pds_action.jsp?category=<%=category%>&cmd=D&idx="+idx;
		} else {
			// 취소 버튼을 눌렀을 때 실행해야 할 프로그램
		}
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
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6">
          	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>자료실 - <%=menutitle%></b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">제목</td>
                                  <td colspan="5" bgcolor="F2F1E2" style="padding-left:5;"><%= Utility.ko( (String)read.get("TITLE") )%></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3" colspan=6></td>
                                </tr>
                                <tr>
                                  <td height="30" align="center" bgcolor="DEDDCF">등록일
                                  </td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0, 10) %></td>
                                  <td width="80" align="center" bgcolor="DEDDCF">첨부파일</td>
                                  <td bgcolor="F2F1E2" td width="100" style="padding-left:5;">
                                  	<table>
	                                  <tr><td>
    	                              <% if( fileread.size() == 0 ) { %>
    	                              		없음.
    	                              <% } else {
    	                                  	for(int i = 0; i < fileread.size() ; i++) {
    	                                  	    HashMap hm = (HashMap)fileread.get(i);
    								  %>
    										<a href="/asanway/common/download.jsp?dir=<%=downfolder%>&filename=<%= Utility.ko((String)hm.get("FILE")) %>&sysfilename=<%= hm.get("SYSFILE") %>"><img src="../img/icon_file.gif" border="0"></a>
    	                              <% } }  %>
										</td></tr>
	                                  </table>
                                  </td>
                                  <td width="80" align="center" bgcolor="DEDDCF">조회 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT") %></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;"><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    <tr>
                      <td >
                      <!-- 이전글 다음글-->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<% if( preview.size() != 0 ) { %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
                          <tr>
                            <td width="100" height="30" align="center" bgcolor="F2F1E2">이전글</td>
                            <td style="padding-left:5;"><a href="cyber_pds_read.jsp?category=<%=category%>&idx=<%= preview.get("IDX") %>"><%= Utility.ko( (String)preview.get("TITLE") )%></a></td>
                          </tr>
						<% } %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% if( nextview.size() != 0 )  {%>
                          <tr>
                            <td width="100"  height="30" align="center" bgcolor="F2F1E2">다음글</td>
                            <td style="padding-left:5;"><a href="cyber_pds_read.jsp?category=<%=category%>&idx=<%= nextview.get("IDX") %>"><%= Utility.ko( (String)nextview.get("TITLE") ) %></a></td>
                          </tr>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% } %>
                        </table>
                        <!--  이전글 다음글-->
                      </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_pds_modify.jsp?category=<%=category%>&idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="cyber_pds_list.jsp?category=<%=category%>"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
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
