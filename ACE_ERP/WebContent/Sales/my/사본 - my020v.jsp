<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ����������
 * ���α׷�ID 	: CU010i
 * J  S  P		: cu010i
 * �� �� ��		: Cu010i
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������		: ����������(��)
 * ��������		: 
 * �� �� ��		: 
 * ������������ 	:  
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My020Manager" %>
<%@ page import="sales.menu.my.My020DTO" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�

try {
   // ContextPath
   String dirPath = request.getContextPath(); //HDASan
   
   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";
   String brd_no = request.getParameter("brd_no");
   String work_flag =request.getParameter("work_flag");
   String brd_subject = request.getParameter("brd_subject");
   

   int len3 = 0;
   BaseDataClass bean3;
   String key = request.getParameter("search_key");
   String values = request.getParameter("search_value");
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_no", (Object)brd_no);
   My020Manager manager3 = new My020Manager();
   My020DTO dto = manager3.select(sr3);
   manager3.close();

	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD ���� -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
	<script language="javascript">
	<!--

	function list(){
		var f = document.form1;
		f.action = "my020s.jsp";
		f.submit();
	}
	function fnDelete() {
		var f = document.form1;
		f.work_flag.value = "DELETE";
		f.action = "my020p.jsp";
		f.submit();
	}	

	
	//-->
	</script>
	</head>
<!--------------------------------- BODY Start ------------------------------->
   <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   onLoad="namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','<%=dirPath %>/Sales/images/com_top_m02.gif','<%=dirPath %>/Sales/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
      <table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
         <tr>
            <td width="123" valign="top"><!--// ���̵�޴�--><jsp:include page="/Sales/common/include/left_mn1.jsp"/></td>  <!--// ���̵�޴� ��-->
            <td valign="top"><!--// ž�޴����� --> <jsp:include page="/Sales/common/include/top_mn.jsp"/></td> <!--// ž�޴� ��-->
         </tr>
         <tr>
             <td height="10"></td>
         </tr>
<!-- ���α׷� ���� BODY START -->
         <tr>
            <td align="center" valign="top">
               <table width="845" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td><!-- Ÿ��Ʋ INCLUDE --><jsp:include page="/Sales/common/include/title.jsp"/></td><!-- Ÿ��Ʋ INCLUSDE �� -->
                  </tr>
					<!-- ���� �ڵ� �κ� ����  -->
							<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1">
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>							
                                     <tr> 
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">��  &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                                       <td colspan="3" style="padding-top:3px">&nbsp;&nbsp;<%=dto.getBrd_subject()%></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr> 
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�޴»��&nbsp;</font></b></td>
                                       <td width="340" style="padding-top:3px">&nbsp;&nbsp;<%=dto.getOut_login_id()%></td>
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� �� ��&nbsp;</font></b></td>
                                       <td width="345" align="left" style="padding-top:3px">&nbsp;&nbsp;<%=dto.getSend_date()%></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                              	   <tr>
                              	     <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">÷������&nbsp;</font></b></td>
                              	     <td colspan="3">&nbsp;&nbsp;<%=dto.getSys_file()%></td>
                              	   </tr>
                              	   <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr> 
                                       <td colspan="4" align="center"> 
                              	         <table width="100%" border="0" cellspacing="0" cellpadding="10" ID="Table2">
                                           <tr> 
                                             <td height='80' valign='top'><%=dto.getBrd_contents()%></td>
                                           </tr>
                                         </table></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr align="center"> 
                                       <td align="right" colspan="4" style="padding-top:5px"> 
                                         <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                           <tr> 
                                             <td align="right">
	                                             <a href="javascript:fnDelete();"><img src="../images/b_del.gif" border="0"></a>
	                                             <a href="javascript:list();"><img src="../images/b_list.gif" border="0"></a></td>
                                           </tr>
                                         </table></td>
                                     </tr>
                                   </table></td>
						</tr>
					<!-- ���� �ڵ� �κ� ��  -->
					</table>
				</td>
			</tr>
<!-- ���α׷� ���� BODY END -->		
  					<form name="form1" method="post">
                      <input type="hidden" name="brd_no" value="<%=brd_no%>">
                      <input type="hidden" name="search_key" value="<%=key%>">
                      <input type="hidden" name="search_values" value="<%=values%>">
                      <input type="hidden" name="work_flag">
                      <input type="hidden" name="brd_subject">
                      
                     </form> 	
		</table>
      </table>
<!---------------------------------- BODY End -------------------------------->
   </body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	