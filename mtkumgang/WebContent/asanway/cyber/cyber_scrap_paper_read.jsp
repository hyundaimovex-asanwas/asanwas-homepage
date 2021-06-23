<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 16일
* 요약 설명 : 스크랩 마스터  (신문)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%
	String menutitle = "스크랩마스터 - 신문기사  스크랩";
	String downfolder = "scrappaper";
	String category = "scrappaper";
%>

<%
	ScrapBean bean = new ScrapBean(category);
	bean.Read(request, response);
%>
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<%
	//구분 값
	HashMap section1hm = new HashMap();
		section1hm.put("1","사업관련기사");
		section1hm.put("2","한반도관련기사");
		section1hm.put("3","기타기사");

	//구분 값
	HashMap section2hm = new HashMap();
		section2hm.put("1","가판");
		section2hm.put("2","종합판");
		section2hm.put("3","석간");

	String dir = "scrappaper/" + read.get("FILELOC").toString().trim();
	File filelist[] = null;

	File file = new File("/was/file_upload/"+dir);
	filelist =  file.listFiles();

	if(filelist != null)
		Arrays.sort(filelist);
%>

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

<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			location.href="/asanway/cyber/cyber_scrap_paper_action.jsp?cmd=D&idx="+idx;
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
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%=menutitle%></b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
							     <tr>
                                  <td height="30" align="center" bgcolor="DEDDCF">발행일 </td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("PUBDATE").toString().substring(0, 10) %></td>
                                  <td width="100" align="center" bgcolor="DEDDCF">조회수 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT") %></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3" colspan="4"></td>
                                 </tr>
                                <tr bgcolor="F2F1E2" height=30>
                                  <td width="100" align="center" bgcolor="DEDDCF">기사구분 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= (read.get("SECTION1") == null)?"":section1hm.get(read.get("SECTION1"))%></td>
                               	  <td width="100" align="center" bgcolor="DEDDCF">발행판 </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%=(read.get("SECTION2") == null)?"":section2hm.get(read.get("SECTION2"))%></td>
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
                      <td valign="top" style="padding:10 10 10 10;" align=center>
                      <div id=scroll style="width: 650; height: 500; overflow: auto">
						<%if(filelist.length == 0){%>
						 	업로드된 기사가 없습니다.
						<%}else{%>
		            	<% for(int i= 0 ; i < filelist.length; i++){%>
			              <img src="/asanway/common/download.jsp?dir=<%=dir%>&sysfilename=<%=filelist[i].getName()%>" border="0" ><br>
			             <%}}%>
                      </div>
                      </td>
                    </tr>

                    <!--
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;"><%= (read.get("CONTENT") == null)?"":Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    -->
                    <tr>
	                    <td colspan="2" height="1" bgcolor="DBDACB"></td>
	                </tr>
	                <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_scrap_paper_modify.jsp?idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="cyber_scrap_paper_list.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
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
<iframe id='cframe' name='cframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>


