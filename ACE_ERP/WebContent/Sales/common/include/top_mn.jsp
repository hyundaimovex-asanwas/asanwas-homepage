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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="top">
<div id="layer1" style="background-color:#0492d4; border-width:1px; border-style:none; width:848px; height:40px; position:absolute; left:137px; top:4px; z-index:1; layer-background-color:#0099CC; border: 1px none #000000;"> 
<table style="border-collapse:collapse;" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td width="86" height="40"> <p><a href="/common/html/menu1.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image18','','<%=dirPath %>/Sales/images/com_top_m01_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m01.gif" name="Image18" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu2.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','<%=dirPath %>/Sales/images/com_top_m02_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m02.gif" name="Image11" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu3.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','<%=dirPath %>/Sales/images/com_top_m03_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m03.gif" name="Image12" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu4.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','<%=dirPath %>/Sales/images/com_top_m04_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m04.gif" name="Image13" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu5.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','<%=dirPath %>/Sales/images/com_top_m05_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m05.gif" name="Image14" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu6.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','<%=dirPath %>/Sales/images/com_top_m06_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m06.gif" name="Image15" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu7.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','<%=dirPath %>/Sales/images/com_top_m07_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m07.gif" name="Image16" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="/common/html/menu8.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image17','','<%=dirPath %>/Sales/images/com_top_m08_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m08.gif" name="Image17" width="86" height="40" border="0"></a></p></td>
		<td width="86" height="40"> <p><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','<%=dirPath %>/Sales/images/com_top_m09_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_top_m09.gif" name="Image9" width="86" height="40" border="0"></a></p></td>		
		<td width="72" height="40"><img src="<%=dirPath %>/Sales/images/com_top_m10.gif" name="Image10" width="72" height="40" border="0"></td>
	</tr>
</table>
</div>
</td> 
</tr> 
<td height="43"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
<td><table width="848" border="0" cellspacing="0" cellpadding="0" align="center">
   <tr> 
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SAL" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image69','','<%=dirPath %>/Sales/images/top_01_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top01%>" name="Image69" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image70','','<%=dirPath %>/Sales/images/top_02_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top02%>" name="Image70" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL3" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image71','','<%=dirPath %>/Sales/images/top_03_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top03%>" name="Image71" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL4" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image72','','<%=dirPath %>/Sales/images/top_04_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top04%>" name="Image72" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL5" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image73','','<%=dirPath %>/Sales/images/top_05_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top05%>" name="Image73" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image74','','<%=dirPath %>/Sales/images/top_06_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top06%>" name="Image74" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL7" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image75','','<%=dirPath %>/Sales/images/top_07_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top07%>" name="Image75" width="106" height="31" border="0"></a></td>
	  <td><a href="<%=dirPath %>/blank.jsp?scode=SL8" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image76','','<%=dirPath %>/Sales/images/top_08_on.gif',1)"><img src="<%=dirPath %>/Sales/images/<%=top08%>" name="Image76" width="106" height="31" border="0"></a></td>
  </tr>
</table>