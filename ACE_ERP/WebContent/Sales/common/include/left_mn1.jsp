
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드

	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
%>
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
     ArrayList data = new ArrayList();
     ArrayList data2 = new ArrayList();
     SmartRequest sr = new SmartRequest(request);
     SmartRequest sr2 = new SmartRequest(request);
     String where_sql     = "";
     String ltype     = sr.getString("scode").trim();
     String m_id      = sr.getString("id").trim();
     String menu_id   = sr.getString("menu").trim();
     String title     = sr.getString("title").trim();
     String upcode    = "";
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
    
    //로그인 사용자 쿠키부르기 (실섭쿠키처리부분)
    HDCookieManager cookie = new HDCookieManager(request, response);
    String user_id = cookie.getCookieValue("vusrid",request);
     
     int len = 0;
     BaseDataClass bean;
    
    
     if (menu_id==null || menu_id.equals("")){
        menu_id="1";
     }

 	 // 1) 여기서 BEAN에 조건을 던질 때 로그인한 ID를 던지고
 	 // 2) Menu, Prog DAO 쪽을 수정해서 (쿼리를 간결하게) Disk, Network I/O를 줄여야 할 듯.	2006-12-13 심동현          
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
<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
<script language="javascript" src="<%=dirPath %>/Sales/common/include/menu_click.js"></script>
<script language="javascript" src="<%=dirPath %>/Sales/common/include/PubFun.js"></script>
<script language="JavaScript">
<!--
var main_cnt = <%=menu_cnt%>;

function show(num){
   for (i=1; i<=main_cnt; i++){
	menu=eval("document.all.block"+i+".style"); 
	imgch=eval("document.bar"+i); 
	if (num==i) {
		if (menu.display=="block") 
			menu.display="none"; 
		else
			menu.display="block" 
	}else {
		 menu.display="none"; 
	}
   }
}
//-->
</script>
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="<%=dirPath %>/Sales/images/bg.gif">
	<tr>
		<td><img src="<%=dirPath %>/Sales/images/logo.gif" width="123" height="42"></td> 
	</tr>
	<tr>
		<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
      	<td><table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
      		<tr height="50"> 
      		  <td colspan="4" align="center" valign="middle"><B><font size="-1" face="돋움" id=loginNM>홍길동</font></B>님<br>환영합니다.</font></td>
      		</tr>
      		<tr> 
      		  <td width="2" height="26"></td>
      		  <td width="58"><img src="<%=dirPath %>/Sales/images/home.gif" width="57" height="22"></td> 
      		  <td width="58"><img src="<%=dirPath %>/Sales/images/logout.gif" width="57" height="22"></td>

<!--  로가웃 = 메인페이지로 갑니다. 메인페이지에서는 쿠키 초기화를 합니다.
<a href="#" onclick="parent.parent.parent.location.href='/bank/bnk_TopIndex.htm'"class="log" style="position:absolute;left:903px;top:32px;cursor:hand">
	<img src="../img/btn/home.gif" style="border:0">
</a>
<a href="../../hdasan.html" class="log" target="_top" style="position:absolute;left:950px;top:32px;cursor:hand">
	<img src="../img/btn/logout.gif" style="border:0">
</a>
-->


      		  <td width="2"></td>
      		</tr>
      	  </table>
      </td>
        </tr>
        <tr> 
      	<td height="20" align="center" class="leftt"><strong><font color="#000066"><%=ltype_nm%></font></strong></td>
        </tr>
        <tr> 
      	<td> 
      	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
<% for (int i=0;i<menu_cnt;i++) { 
			bean = (BaseDataClass)data.get(i);
			upcode = bean.get("scode");
			image_nm = ltype.toLowerCase() + "_" + upcode.substring(1,3);
%>      	  
      		<tr> 
      		  <td><a href="#" onclick="show(<%=i+1%>);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image<%=i+100%>','','<%=dirPath %>/Sales/images/com_menu_<%=image_nm%>_on.gif',1)"><img src="<%=dirPath %>/Sales/images/com_menu_<%=image_nm%>.gif" name="Image<%=i+100%>" width="123" height="22" border="0"></a></td>
      		  </tr>
      		  <tr><td><SPAN id="block<%=i+1%>" style="DISPLAY:none;"><table width="100%" border="0" cellspacing="0" cellpadding="1">

         <% for (int h=0;h<prog_cnt;h++) { 
         		  bean = (BaseDataClass)data2.get(h);
			      progid = bean.get("rpgmid").toLowerCase().trim();
			      menu_dir = progid.substring(0,2).toLowerCase();
			      menu_nm = bean.get("pgmnm").trim();

				  //배열을 다 가져와서 여기서 IF로 메뉴를 쪼개네..움.. 2006-12-13 심동현
				  //결국 서버로부터 모든 메뉴를 다 불러오는 거네.. 느리겠군..;; 그것도 매 페이지마다(__);
			      if (upcode.equals(bean.get("upmenuid").trim())){	
         
         %>      		  	  
      			  <tr> 
      				<td height="20" width="10" align="center"><img src="<%=dirPath %>/Sales/images/icon_arrow.gif"></td>
      				<td width="118"><font size="-1" face="돋움"><a href="<%=dirPath%>/Sales/<%=menu_dir%>/<%=progid%>.jsp?scode=<%=ltype%>&id=m<%=prog_id%>&menu=<%=i+1%>" onclick="set_menu('m<%=prog_id%>');" onfocus="blur()" id="m<%=prog_id%>"><%=menu_nm%></a></font></td>
      			  </tr>
         <%
                      prog_id++;
                  }
                  
              } 
         %>      			  
     			</table></span></td>
      		</tr>
<% 
      } 
%>      		

              </table></td> 
          </tr>
          </table></td>		
	</tr>
</table>
<%
     if (m_id==null || m_id.equals("")){
         m_id = "";
     }
     else {
%>
<script>
show('<%=menu_id%>');
set_menu('<%=m_id%>');
</script>
<%
     }
%>     




<script language=javascript>
	get_cookdata();
	//alert(loginNM);
    loginNM.innerHTML=GetCookie("vusrnm");
</script>