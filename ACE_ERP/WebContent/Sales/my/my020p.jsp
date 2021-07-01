<%
/*******************************************************************************
 *                      << ??¡¤?¡¾¡¿¡¤? DESCRIPTION >>
 *******************************************************************************
 * ??¡¤?¡¾¡¿¡¤? ¢¬?   : 
 * ??¨ù¨¬????      : 2006.05.29
 * ??¨ù¨¬??        : ¡¾?¡¾?¡¤¢®
 * ??¡¤?¡¾¡¿¡¤? ¡Æ©ø¢¯? : 
 ******************************************************************************/
%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%  response.setContentType("text/html; charset=euc-kr"); %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="sales.org.common.log.LogUtil"%>
<%@ page import="sales.org.common.property.CommonProperty"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.common.request.FileStorage"%>
<%@ page import="sales.org.util.StringUtil"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.menu.my.*"%>

<%

try {
   SmartRequest sr = new SmartRequest(request);
   
   String work_flag    = sr.getString("work_flag");
   String page_num     = sr.getString("page_num");
   String search_key  = sr.getString("search_key");
   String search_value  = sr.getString("search_value");
   String file_path    = "d:/Temp";
   String ltype    = sr.getString("scode");
   String m_id     = sr.getString("id");
   String menu_id  = sr.getString("menu");
   String brd_gu  = sr.getString("brd_gu");   
   String brd_contents = sr.getString("brd_contents");
   String brd_subject = sr.getString("brd_subject");
   String send_login_id = sr.getString("send_login_id");
   String out_login_id = sr.getString("out_login_id");
   String brd_no = sr.getString("brd_no");
   String out_yn = sr.getString("out_yn");
   
    
   ArrayList fsl = sr.getFileStorageList("filename");
   
   for(int i=0; fsl != null && i < fsl.size(); i++){
      FileStorage fs = (FileStorage)fsl.get(i);;
      fs.saveFile(file_path);
      sr.setObject("real_file",fsl.get(i));
      sr.setObject("sys_file",fs.getRealFileName());

   }
   String message = "";
   My020Manager manager = new My020Manager();
  // if(work_flag.equalsIgnoreCase("INSERT")){
   manager.insert(sr);
   //}
   //out.println(brd_subject+"<br>");
   //out.println(brd_contents+"<br>");
   //out.println(send_login_id+"<br>");
   //out.println(out_login_id+"<br>");
   manager.close();
   //out.close();
 //  }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<form name="boardForm" method="post">
<input type="hidden" name="search_key" value="<%=search_key%>">
<input type="hidden" name="search_value" value="<%=search_value%>">
<input type="hidden" name="scode" value="<%=ltype%>">
<input type="hidden" name="id" value="<%=m_id%>">
<input type="hidden" name="menu" value="<%=menu_id%>">
<input type="hidden" name="brd_gu" value="<%=brd_gu%>">
<input type="hidden" name="brd_contents" value="<%=brd_contents%>">
<input type="hidden" name="brd_subject" value="<%=brd_subject%>">
<input type="hidden" name="send_login_id" value="<%=send_login_id%>">
<input type="hidden" name="out_login_id" value="<%=out_login_id%>">
<input type="hidden" name="out_yn" value="<%=out_yn%>">
<input type="hidden" name="brd_no" value="<%=brd_no%>">
</form>
<script language="javascript">
   form = document.boardForm;
   form.target = "";
   form.action = "my020s.jsp";
<%
if(StringUtil.isNotNull(message)){
%>
   alert("<%=message%>");
<%
}
%>

<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
   form.submit();
</script>