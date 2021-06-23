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

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.GalleryBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = request.getParameter("category");
	String menuidx = "";
	if(category.equals("gallery")){
		menuidx = "17";
	}else{
		menuidx = "22";
	}

	GalleryBean bean = new GalleryBean();
	bean.Read(request, response);
%>
<jsp:useBean id="read" class="java.util.ArrayList" scope="request" />
<% HashMap hm1 = (HashMap)read.get(0); %>
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
	function doDel(idx, category)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			// 확인 버튼을 눌렀을 때 실행해야 할 프로그램
			location.href="/asanway/cyber/cyber_gallery_delete.jsp?idx="+idx+"&category="+category;
		} else {
			// 취소 버튼을 눌렀을 때 실행해야 할 프로그램
		}
	}

	function goUpdate(idx, category)
	{
		window.close(this);
		window.opener.location.href="/asanway/cyber/cyber_gallery_modify.jsp?idx="+idx+"&category="+category;
	}

//-->
</script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<script>
	function ImgAct() {
	var ImgLayName ;

	for (i=1; i<=<%= read.size()%>; i++){
		ImgLayName = document.all["ImgLay"+i] ;
		ImgLayName.style.display = "none" ;
	}

	document.all["ImgLay"+arguments[0]].style.display = "" ;
}
</script>

   <table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td valign="top" align="center">

       <table width="640" border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td><img src="../img/gallery_popup_title.gif" ></td>
           </tr>
           <tr>
             <td valign="top" bgcolor=#F1F1DB style="padding:0 20 0 20;">
<% for(int i = 0; i < read.size(); i++) {
			HashMap hm = (HashMap)read.get(i);
%>
<div style="display:none;" id="ImgLay<%= i+1 %>">
             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                   <td height="25"><img src="../img/bt_16.gif" width="6" height="11" hspace="4"> <%= Utility.ko( (String)hm.get("TITLE") ) %></td>
                 </tr>
                 <tr>
                   <td align="center"><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)hm.get("FILE"))%>&dir=gallery&sysfilename=<%= Utility.ko((String)hm.get("SYSFILE"))%>" border="0" style="width:600px;height:400px;">
                   </td>
                 </tr>
               </table>
</div>

<% } %>
               </td>
           </tr>
           <tr>
             <td><img src="../img/gallery_popup_01.gif" ></td>
           </tr>
           <tr>
             <td>&nbsp;</td>
           </tr>
         </table>

			<script>
                ImgAct('1');
			</script>

         </td>
     </tr>
     <tr>
       <td>
	   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	       	<tr>
			   	<td style="padding-left:20px;"><% for ( int i = 0; i < read.size(); i++) { %>&nbsp;[ &nbsp;<a href="#" onClick="ImgAct('<%= i+1 %>')"><%= i+1 %></a>&nbsp; ]&nbsp;<% } %></td>
				<td align="right"   style="padding-top:5;padding-right:20;">
		       	<a href="#" onClick="javascript:goUpdate('<%= hm1.get("IDX") %>', '<%= hm1.get("CATEGORY") %>')"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
		       	<a href="#" onClick="javascript:doDel('<%= hm1.get("IDX") %>','<%= category %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="4" border="0"></a>
		       	<a href="#" onClick="javascript:window.close()"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
		       	</td>
	       	</tr>
       	</table>
       	</td>
     </tr>
     <tr>
       <td>&nbsp;</td>
     </tr>
   </table>

</body>
</html>
