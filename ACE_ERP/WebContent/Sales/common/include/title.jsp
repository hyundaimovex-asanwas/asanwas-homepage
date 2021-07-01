
<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="sales.common.*" %>
<%@ page import="sales.org.util.*" %>
<%@ page import="sales.common.MenuManager" %>
<%@ page import="sales.common.ProgManager" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ??¹?????

	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");


%>
<%
    ArrayList data = new ArrayList();
     ArrayList data2 = new ArrayList();
     SmartRequest sr = new SmartRequest(request);
     SmartRequest sr2 = new SmartRequest(request);
     String where_sql     = "";
     String ltype     = sr.getString("scode").trim();
     String m_id     = sr.getString("id").trim();
     String menu_id     = sr.getString("menu").trim();
     String title     = sr.getString("title").trim();
     String upcode     = "";
     String image_nm = "";
     String progid = "";
     String menu_code = "";
     String menu_nm = "";
     String menu_dir = "";
     	String top01 = "top_01.gif";
	String top02 = "top_02.gif";
	String top03 = "top_03.gif";
	String top04 = "top_04.gif";
	String top05 = "top_05.gif";
	String top06 = "top_06.gif";
	String top07 = "top_07.gif";
	String top08 = "top_08.gif";
    String ltype_nm = "";
    
	
	 if (ltype==null || ltype.equals("")){
        ltype="SAL";
     }
     
	if (ltype.equals("SAL")){
	   top01 = "top_01_on.gif";
	   ltype_nm = "고객관리";
	}
	else if (ltype.equals("SL2")){
	   top02 = "top_02_on.gif";
	   ltype_nm = "객실관리";
	}
	else if (ltype.equals("SL3")){
	   top03 = "top_03_on.gif";
	   ltype_nm = "예약관리";
	}
	else if (ltype.equals("SL4")){
	   top04 = "top_04_on.gif";
	   ltype_nm = "출입관리";
	}
	else if (ltype.equals("SL5")){
	   top05 = "top_05_on.gif";
	   ltype_nm = "정산관리";
	}
	else if (ltype.equals("SL6")){
	   top06 = "top_06_on.gif";
	   ltype_nm = "경영정보";
	}
	else if (ltype.equals("SL7")){
	   top07 = "top_07_on.gif";
	   ltype_nm = "마이페이지";
	}
	else if (ltype.equals("SL8")){
	   top08 = "top_08_on.gif";
	   ltype_nm = "시스템관리";
	}
    

     
     int len = 0;
     BaseDataClass bean;
    
    
     if (menu_id==null || menu_id.equals("")){
        menu_id="1";
     }
          
     where_sql=" and upcode = '" + ltype + "'";
     sr.setObject("where_sql",(Object)where_sql);  
   
     MenuManager manager = new MenuManager();
     data = manager.list(sr);
     manager.close();
     
     where_sql ="  and sysid = '" + ltype + "'";
     sr2.setObject("where_sql",(Object)where_sql);  
   
     ProgManager manager2 = new ProgManager();
     data2 = manager2.list(sr2);
     manager2.close();
     int prog_cnt = data2.size();
     int menu_cnt = data.size();
     int prog_id = 1;
     int image_id = 100;
     
     String dirPath = request.getContextPath();
%>     
<script>
function set_title(middle){
   middleMenu = document.getElementById(middle);
   document.all['title_div'].innerHTML = "<font size='-1' face='돋움'>홈>관광영업><%=ltype_nm%>>" + middleMenu.innerText +"</font>";
   document.all['title'].innerHTML = "<strong>" + middleMenu.innerText + "</strong>";
   document.title= middleMenu.innerText;
}
</script>
	                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                               <td width="22" height="22" align="left" valign="middle"><img src="<%=dirPath %>/Sales/images/icon.gif" width="14" height="14"></td>
                               <td width="400" class="tt"><div id="title"></div></td>
                               <td class="loca"><div id="title_div" align="right"></div></td>
                             </tr>
                           </table>
<script>
set_title('<%=m_id%>');
</script>                           