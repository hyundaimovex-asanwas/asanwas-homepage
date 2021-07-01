<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 고객관리
 * 프로그램ID 		: CU010i
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-16
 * 기능정의		: 대리점 관리 (조회 등록 삭제 수정)
 * 수정내용		: 
 * 수 정 자		: 이병욱
 * 최종수정일자 	: 2006-05-16 
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My210DTO" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드


   // ContextPath
   String dirPath = request.getContextPath(); //HDASan
   
   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";

   String ltype = request.getParameter("ltype");
   String m_id = request.getParameter("m_id");
   String menu_id = request.getParameter("menu_id");
   String brd_gu = request.getParameter("brd_gu");
   String ref = request.getParameter("ref");
   String ref_step =request.getParameter("req_step");
   String ref_level = request.getParameter("ref_level");
   String work_flag = request.getParameter("work_flag");
   String brd_no = request.getParameter("brd_no");
   int len3 = 0;
   BaseDataClass bean3;
   String key = request.getParameter("search_key");
   String values = request.getParameter("search_value");
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_gu",(Object)brd_gu);
   My210Manager manager3 = new My210Manager();
   My210DTO dto = manager3.select(sr3);
   manager3.close();
   
   	 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
		<title>[CU032] 대리점정보 관리 </title>
		
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/
%>		

		<link href="../common/include/common.css" rel="stylesheet" type="text/css">

		<script language="javascript" src="../common/include/PubFun.js"></script>
        <script language="javascript" src="../common/include/menu.js"></script>
<script language=javascript>
<!--
function contents(){	
	myEditor.editBox.document.body.innerHTML = "<%=dto.getBrd_contents()%>";
}
function send_ok(){
	var f = document.form1
    if(f.title.value==""){alert("제목을 입력해 주세요!");  f.title.focus(); return;}
	
	f.brd_contents.value = myEditor.editBox.document.body.innerHTML
	alert(f.brd_contents.value);
	if(f.brd_contents.value==""){
		alert("내용을 입력해 주세요!");  
		return;
    }
	f.work_flag.value = "MODIFY";
	f.action='my110p.jsp';
	f.target='blank';
	f.method='POST';
	f.submit();
}
function cancel(){
	var f = document.form1;
	f.action='my110i.jsp';
	f.target='';
	f.submit();
}
//-->
</script>		
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="contents(); namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','images/com_top_m02<%=dirPath %>/Sales/images/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
		<table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="123" valign="top"><!--// 사이드메뉴--><jsp:include page="/Sales/common/include/left_mn1.jsp"/></td>  <!--// 사이드메뉴 끝-->
				<td valign="top"><!--// 탑메뉴시작 --> <jsp:include page="/Sales/common/include/top_mn.jsp"/></td> <!--// 탑메뉴 끝-->
			</tr>
			<tr>
			    <td height="10"></td>
			</tr>
<!-- 프로그램 들어가는 BODY START -->			
			<tr>
				<td align="center" valign="top">
					<table width="845" border="0" cellspacing="0" cellpadding="0">
                       <tr> 
                         <td><!-- 타이틀 INCLUDE --><jsp:include page="/Sales/common/include/title.jsp"/></td><!-- 타이틀 INCLUSDE 끝 -->
                       </tr>
					<!-- 실제 코딩 부분 시작  -->
            			<tr>
            			    <td height="10"></td>
            			</tr>
						<tr> 
							<td><table width="670" border="0" cellspacing="0" cellpadding="0" ID="Table1">
							    <form name="form1" method="post" enctype="MULTIPART/FORM-DATA">
                        	     <tr> 
                        	       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">제 &nbsp;&nbsp;&nbsp;목&nbsp;</font></b></td>
                        	       <td colspan="3" style="padding-top:3px">&nbsp;&nbsp; 
                        	         <input type="text" name="brd_subject" size="70" value="<%=dto.getBrd_subject()%>"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td width="80" height="30" align='right' valign="middle" bgcolor="#F3F0F9"><b><font color="#555555">작 성 자&nbsp;</font></b></td>
                        	       <td style="padding-top:3px" colspan="3">&nbsp;&nbsp; 
                        	         <input type="text" name="name" size="20" value="<%=dto.getBrd_creator()%>" readOnly="true"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td width="80" height="30" align="right" valign="middle" bgcolor="#F3F0F9"><b><font color="#555555">첨부파일&nbsp;</font></b></td>
                        	       <td style="padding-top:3px" colspan="3">&nbsp;&nbsp; 
                        	         <input type="file" name="file" size="60" ID="File1"  value="<%=dto.getReal_file()%>"> <% if (dto.getReal_file() != null && dto.getReal_file().equals("")) { %><img src="../images/file.gif" border="0" align="absmiddle"><% } %></td>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td width="80" height="30" align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">내 &nbsp;&nbsp;&nbsp;용&nbsp;</font></b></td>
                        	       <td style="padding-top:3px" colspan="3">&nbsp;&nbsp; 
                        	      	<!--==========================================//-->
                        	        <iframe src="<%=dirPath%>/Sales/common/htmlEditor/myEditor.htm" frameborder="0" marginWidth=0 marginHeight=0 width="750" height="400" scrolling="no" name="myEditor"  ></iframe>
                        	     <!--==========================================//-->
                        	       </td>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	     <tr bgcolor="92C306"> 
                        	       <td colspan="4" height="1"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td colspan="4" align="center" style="padding-top:5px"><a href="javascript:send_ok();"><img src="../images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;<a href="javascript:cancel();"><img src="../images/b_cancel.gif" alt="" border="0"></a></td>
                        	     </tr>
                               <input type="hidden" name="scode" value="<%=ltype%>">
                               <input type="hidden" name="id" value="<%=m_id%>">
                               <input type="hidden" name="menu" value="<%=menu_id%>">
                               <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
                               <input type="hidden" name="ref" value="<%=ref%>">
                               <input type="hidden" name="ref_step" value="<%=ref_step%>">
                               <input type="hidden" name="ref_level" value="<%=ref_level%>">
                               <input type="hidden" name="work_flag">
                               <input type="hidden" name="brd_contents">
                               <input type="hidden" name="brd_no" value="<%=brd_no%>">
                               </form>                        	     
                        	   </table></td>
						</tr>
					<!-- 실제 코딩 부분 끝  -->
					</table>
				</td>
			</tr>
<!-- 프로그램 들어가는 BODY END -->			
		</table>
<!---------------------------------- BODY End -------------------------------->	
	</body>
</html>