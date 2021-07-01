<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My020Manager" %>
<%@ page import="sales.common.HDCookieManager" %>
<%@ page import="sales.menu.my.My120I" %>
<%
	// 현대아산 직원, 대리점/협력업체 구분
	// Value = ERP, Value=Tour
	// ERP인 경우 = 
/*	String HDAdminType = HDUtil.nullCheckStr(request.getParameter("AdminType"));
	
	String fEmpno = HDUtil.nullCheckStr(request.getParameter("Empno"));

	HDCookieManager cookie = new HDCookieManager(request, response);
*/
	 
try {
   // ContextPath
   String dirPath = request.getContextPath(); //HDASan

   ArrayList data3 = new ArrayList(); //공지사항
   ArrayList data4 = new ArrayList(); //고객문의
   ArrayList data5 = new ArrayList(); //대리점문의
   ArrayList data6 = new ArrayList(); //받은편지함
   SmartRequest sr3 = new SmartRequest(request);
   int view_cnt = 6;                  //보여질 게시물 갯수
   
   String where_sql3     = "";
   String brd_gu = "";
   String out_login_id = "nkp0908";

   int len3 = 0;
   int len4 = 0;
   int len5 = 0;
   int len6 = 0;
   BaseDataClass bean3;
   BaseDataClass bean4;
   BaseDataClass bean5;
   BaseDataClass bean6;

   My020Manager manager4 = new My020Manager();
   My210Manager manager3 = new My210Manager();
   brd_gu = "01";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data3 = manager3.list(sr3);
   
   brd_gu = "02";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data4 = manager3.mainlist(sr3);

   brd_gu = "03";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data5 = manager3.mainlist(sr3);
   
   sr3.setObject("out_login_id",(Object)out_login_id);
   data6 = manager4.list(sr3);
   
   manager3.close();	
   manager4.close();
   
   
   
   
   // 새로만든거 메인용 
   
   String servletPath = "/servlet/sales.common.my.BaseServlet";
   
   
  	My120I m120 = new My120I();
 	
  	ArrayList data1 = m120.main_select(request, response);
  	
	BaseDataClass param = (BaseDataClass)request.getAttribute("PARAM");
   %>
<script>
//공지사항
 function view_send(brd_no){
 alert(brd_no);
   	 var f = document.form1;
      f.action="./Sales/my/my210v.jsp";
      f.brd_no.value = brd_no;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
//고객문의
 function view_send2(brd_no){
 alert(brd_no);
   	 var f = document.form1;
      f.action="./Sales/my/my110v.jsp";
      f.brd_no.value = brd_no;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
//대리점문의
 function view_send3(id){
   	 var f = document.form1;
  //    f.action="./Sales/my/my120v.jsp";
   //   f.brd_no.value = brd_no;
    //  f.method = "POST";
    //  f.target="";
      
    //  f.submit();
    
    		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my120s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_MODIFY%>'; // 작업 타입

		f.brd_no.value = id;

		f.method = "post";
		f.submit();
      
   }
//편지함
 function view_send4(brd_no){
 alert(brd_no);
   	 var f = document.form1;
      f.action="./Sales/my/my210v.jsp";
      f.brd_no.value = brd_no;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>현대아산 관광 예약시스템</title>
		
		<link href="test.css" rel="stylesheet" type="text/css">
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="<%=dirPath %>/Sales/common/include/menu_click.js"></script>
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/menu.js"></script>
	</head>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="namosw_init_slide_layers('layer1', 2); ">
		<table width="1000" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="123" rowspan="3" valign="top"><!--// 사이드메뉴-->
					<jsp:include page="/Sales/common/include/left_mn1.jsp" /></td>
				<td width="10"rowspan="3">&nbsp;</td>
				<td><!--// 탑메뉴-->
					<jsp:include page="/Sales/common/include/top_mn.jsp" /></td>
			</tr>
			<tr>
				<td height="22"></td>
			</tr>
			
			
			<tr>
				<td>
					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
					
						<tr>
							<td width="427" align="center">
								
								 <input type="hidden" name="brd_no" value="">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/notice.gif" width="61" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my210s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //공지사항
			                           if(data3 == null || data3.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                           }
			                           else {
			                              len3 = data3.size();
			                              if (len3>= view_cnt){
			                                 len3 = view_cnt;
			                              }
			                              bean3 = null;
			                              int tocnt = data3.size();
			                              for(int h=0; h<len3; h++) {
			                                 bean3 = (BaseDataClass)data3.get(h);
			                        %>			                        									
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send('<%=bean3.get("brd_no")%>');"><%=bean3.get("brd_subject")%></a></td>
										<td align="center"> <%=bean3.get("brd_cdate")%> </td>
									</tr>
								   <%
			                           }
			                       }
								   %>									
								</table>
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="420" align="center" valign="top">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
									<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/mail.gif" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my010s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //받은편지함
			                           if(data6 == null || data6.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                           }
			                           else {
			                              len6 = data6.size();
			                              if (len6>= view_cnt){
			                                 len6 = view_cnt;
			                              }
			                              bean6 = null;
			                              int tocnt = data6.size();
			                              for(int h=0; h<len6; h++) {
			                                 bean6 = (BaseDataClass)data6.get(h);
			                        %>			                        									
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send4"><%=bean6.get("brd_subject")%></a></td>
										<td align="center"> <%=bean6.get("send_date")%> </td>
									</tr>
								   <%
			                           }
			                       }
								   %>									
								</table>
							</td>
						</tr>
						<tr>
							<td height="30"></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td width="427" align="center">
								
							</td>
							<td>&nbsp;</td>					
							<td width="420" align="center">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/ask.gif" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my120i.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //대리점문의
			                          // if(data5 == null || data5.size() < 1 ) {
			                          	if(data1 == null || data1.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">해당 자료가 존재하지 않습니다.</td>
									</tr>			                        
			                        <%
			                          }
			                        else {
			                        //      len5 = data5.size();
			                        //      if (len5>= view_cnt){
			                        //         len5 = view_cnt;
			                         //     }
			                        //      bean5 = null;
			                         //     int tocnt = data5.size();
			                         //     for(int h=0; h<len5; h++) {
			                          //       bean5 = (BaseDataClass)data5.get(h);
			                          	 sales.common.my.BaseDataClass value = null;
									                           	 
									                           	 int count = data1.size();
									                           	 
									                           	 if (data1.size() > 6) {
									                           	 	count = 6;
									                           	 } else if (data1.size() > 0 && data1.size() <= 6) {
									                           	 	count =data1.size();
									                           	 }
																if (data1.size() > 0) {
																	for (int i = 0; i < count; i++) {
																		value = (sales.common.my.BaseDataClass)data1.get(i);
			                        %>			                        									
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send3('<%=value.get("brd_no")%>');"><%=value.get("brd_subject")%></a></td>
										<td align="center"> <%=value.get("brd_cdate").substring(0,10)%><td>
									</tr>
									
								   <%
								   			}
			                           }
			                       }
								   %>									
								</table>
							</td>
						</tr>
						<tr>
							<td height="1" colspan="3"></td>
						</tr>
						<tr>
							<td height="20" colspan="3">　　<img src="<%=dirPath%>/Sales/images/upnote.gif"></td>
						</tr>
						<tr>
							<td height="30" colspan="3" align=right><jsp:include page="/Sales/common/include/updatenote04.jsp" /></td>
						</tr>
					</table>
					
						<input type="hidden" name="actId" value="">
						<input type="hidden" name="process_flag" value="">
						
					</form>
				 </td>
			</tr>
		</table>
	</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>