<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.hmm.asan.common.util.AsanFileRenamePolicy" %>
<%@ page import="com.hmm.asan.common.util.WEBConstants" %>

<%
	String preimg =  request.getParameter("preimg");

	MultipartRequest multi = new MultipartRequest(request,WEBConstants.SCRAPUPLOADDIR , WEBConstants.SCRAPUPLOADMAX, "EUC-KR", new AsanFileRenamePolicy());
	String pubdate = multi.getParameter("pubdate");
	String title = multi.getParameter("title");
	String section1 = multi.getParameter("section1");
	String section2 = multi.getParameter("section2");
	String img =  multi.getFilesystemName("imgfile");

	if(img == null ){
		img = preimg;
	}
	//구분 값
	HashMap section1hm = new HashMap();
		section1hm.put("1","사업관련기사");
		section1hm.put("2","한반도관련기사");
		section1hm.put("3","기타기사");
%>
<BODY topmargin="0" leftmargin="0" bgcolor="#FCFCF6">
<!----- Title----->
<!--table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#234790">
<tr>
	<td><img src="/img/cyberpr/pop_tit_01.gif"></td>
	<td align="right"><img src="/img/common/pop_logo.gif"></td>
</tr>
</table-->
<!----- Title----->
<!----- Box----->
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" bgcolor="#F1F1DB">
        <tr>
          <td height="8"><img src="/img/common/pop_box640_top.gif"></td>
        </tr>
        <tr>
          <td height="5"></td>
        </tr>
        <tr>
          <td valign="top" >
            <!----- Contents----->
            <table border="0" cellpadding="0" cellspacing="0" width="950">
              <tr>
                <td style="padding-left:10"><img src="/img/common/bu_03.gif" align="absmiddle">
                  <b><%= (title==null)?"":Utility.ko(title)%> </b> &nbsp;&nbsp;&nbsp;구분 : 잡지스크랩 > <%= (section1==null)?"":section1hm.get(section1)%> > <%= (section2==null)?"":Utility.ko(title)%> </td>
                <td style="padding-right:30" align="right"> 날짜 : <%=(pubdate==null)?"":pubdate%>  조회수 : 0 </td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
              <tr>
                <td align="center"><img src="/asanway/common/download.jsp?dir=scrap&sysfilename=<%=img%>" border="0" ></td>
              </tr>
            </table>
            <!----- //Contents----->
          </td>
        </tr>
        <tr>
          <td height="100">
            <!----- CopyRight----->
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td colspan="2" height="4"></td>
              </tr>
              <tr>
                <td background="/img/common/pop_copyright_bg.gif"><img src="/img/common/pop_copyright.gif"></td>
                <td background="/img/common/pop_copyright_bg.gif">&nbsp;</td>
                <td align="right" background="/img/common/pop_copyright_bg.gif"><img src="/img/common/pop_copyright_right.gif"></td>
              </tr>
              <tr>
                <td colspan="2" height="7"></td>
              </tr>
            </table>
            <!----- //CopyRight----->
            <!----- Btn_close----->
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td align="right" style="padding-right:22"><a href="javascript:window.close()"><img src="/img/common/pop_close.gif" border"0"></a></td>
              </tr>
            </table>
			</td>
        </tr>
      </table>
<!----- //Box----->
</BODY>
</HTML>
