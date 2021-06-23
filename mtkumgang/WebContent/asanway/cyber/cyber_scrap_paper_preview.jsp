<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.hmm.asan.common.util.AsanFileRenamePolicy" %>
<%@ page import="com.hmm.asan.common.util.WEBConstants" %>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 15일
* 요약 설명 : 스크랩 마스터  (신문)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>
<%
	MultipartRequest multi = new MultipartRequest(request,WEBConstants.SCRAPPAPERUPLOADDIR , WEBConstants.SCRAPPAPERUPLOADMAX, "EUC-KR", new AsanFileRenamePolicy());
	String pubdate = multi.getParameter("pubdate");
	String title = multi.getParameter("title");
	String section1 = multi.getParameter("section1");
	String section2 = multi.getParameter("section2");
	String fileloc = multi.getParameter("fileloc");

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

	String dir = "scrappaper/" + fileloc;
	File filelist[] = null;

	File file = new File("/was/file_upload/"+dir);
	filelist =  file.listFiles();

	if(filelist != null)
		Arrays.sort(filelist);

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
                  <b><%= (title==null)?"":Utility.ko(title)%> </b> &nbsp;&nbsp;&nbsp;구분 : 신문기사 스크랩 > <%= (section2==null)?"":section2hm.get(section2)%> > <%= (section1==null)?"":section1hm.get(section1)%> </td>
                <td style="padding-right:30" align="right"> 날짜 : <%=(pubdate==null)?"":pubdate%>  조회수 : 0 </td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
            	<%if(filelist.length == 0){%>
				 <tr>
	                <td align="center">업로드된 기사가 없습니다.</td>
	              </tr>
				<%}else{%>
            	<% for(int i= 0 ; i < filelist.length; i++){%>
	              <tr>
	                <td align="center"><img src="/asanway/common/download.jsp?dir=<%=dir%>&sysfilename=<%=filelist[i].getName()%>" border="0" ></td>
	              </tr>
	             <%}}%>
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
