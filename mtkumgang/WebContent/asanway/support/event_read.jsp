<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM
* �ۼ����� : 2005�� 10�� 25��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%
	String category = request.getParameter("category");
	if(category == null) category = "entry";
	// �̺�Ʈ ��� : entry
	// ��÷�� ��ǥ : announce
	
	String t = "";
	if( category.equals("entry") ) t = "�̺�Ʈ";
	if( category.equals("announce") ) t = "��÷�� ��ǥ";
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.EventBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="com.hmm.asan.comment.CommentBean" %>
<%
	EventBean sb = new EventBean();
	sb.Read(request, response);
	CommentBean comment = new CommentBean();
	comment.CommentList(request, response, "event");
%>
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="commentlist" class="java.util.ArrayList" scope="request" />

<%@ page import="java.text.SimpleDateFormat" %>
<%
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");
	String ymd = myformat.format(yymmdd);	// 20051101
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "30";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>


<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("�����Ͻðڽ��ϱ�?")) {
			// Ȯ�� ��ư�� ������ �� �����ؾ� �� ���α׷�
			location.href="event_delete.jsp?category=<%= category %>&idx="+idx;
		} else {
			// ��� ��ư�� ������ �� �����ؾ� �� ���α׷�
		}
	}
//-->

</script>


</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr> 
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                 <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td valign="top" style="padding: 15 0 0 20;"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= t %></b></td>
                    </tr>
                    <tr> 
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2"> 
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">����</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= Utility.ko( (String)read.get("TITLE") ) %></td>
                                </tr>
                                <tr> 
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                                <% if(category.equals("entry") ) {  %>
                                <tr bgcolor="F2F1E2"> 
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">�������</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;">
                            <%
                            	if( Utility.dateCompareB( (String)read.get("STARTDATE"), ymd) && Utility.dateCompareB( ymd, (String)read.get("ENDDATE")) ){
                            	    out.write("	������");
                            	} else if( Utility.dateCompareB(ymd, (String)read.get("STARTDATE") ) ){
									out.write("	�����");
                            	} else {
                            		out.write("����");
								}
                           %>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>                                
                                <% } %>
                                <tr bgcolor="F2F1E2"> 
                                	<td width="100" height="30" align="center" bgcolor="DEDDCF">�Ⱓ</td>
                                	<td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("STARTDATE").toString().substring(0,4) %>�� <%= read.get("STARTDATE").toString().substring(4,6) %>��<%= read.get("STARTDATE").toString().substring(6,8) %>�� ~ 
											<%= read.get("ENDDATE").toString().substring(0,4) %>�� <%= read.get("ENDDATE").toString().substring(4,6) %>��<%= read.get("ENDDATE").toString().substring(6,8) %>��                                 	
                                	</td>
                                </tr>
                                <tr> 
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>                                
                                <tr bgcolor="F2F1E2"> 
                                	<td width="100" height="30" align="center" bgcolor="DEDDCF">�����</td>
                                	<td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0,10) %>         	
                                	</td>
                                </tr>                                
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="5"></td>
                    </tr>
                    <tr> 
                      <td valign="top" style="padding:10 10 10 10;"><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    <tr> 
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr> 
                      <td height="7"></td>
                    </tr>                                                              
                    <tr>
                    	<td>
                    	
                    	<table>
                    	<tr>
                    		<td width="100" valign="top" align="center">
		                    	������
		                    	<td>
									<!--  �ڸ�Ʈ ����Ʈ -->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">												
		                    		<% if(commentlist.size() == 0 ) {  %>
		            	        		<tr>
		        	    	        		<td height="30">������ ������ �����ϴ�. 
			                    		</tr>
			                    		<% }  else { 
			                    				for(int i = 0; i < commentlist.size(); i++) {
			                    				    HashMap hm = (HashMap)commentlist.get(i);
			                    		%>
			                    		<tr>
											<form name="comment<%= i %>" method="post" action="comment_action.jsp" onSumbit="return doUpdate()">									                    		
											<input type="hidden" name="cmd" value="modi">
			                    			<input type="hidden" name="idx" value="<%= hm.get("IDX") %>">
			                    			<td width="100" height="30" align="center"><%= Utility.ko( (String)hm.get("REGNAME")) %></td>
			                    			<td width="300"><input type="text" name="comment" value="<%= Utility.ko( (String)hm.get("COMMENT") ) %>" size="50"></td>
			                    			<td width="50" align="center"><input type="image" src="/asanway/img/bt_08.gif" border="0" align="absmiddle"></td>
			                    			<td width="50" align="center"><img src="/asanway/img/bt_09.gif" border="0"  align="absmiddle" onClick="javascript:doCommentDel('<%= hm.get("IDX") %>')"></td>
											</form>			                    					                    		
			                    		</tr>
			                    		<% if( commentlist.size()-1 == i ) {  %>
			                    		<tr>
				                    		<td colspan="4"><a href="event_excel.jsp?idx=<%= read.get("IDX") %>">������ ���� Excel �ٿ�ε�</a>
				                    	</td>
			                    		</tr>
			                    		<% } %>
			                    		<% } } %>
		                    		</table>               
		                    		<!--  // �ڸ�Ʈ ����Ʈ -->     	
		                    		
		                    		<script>
		                    		<!-- 
										function doCommentDel(idx)
										{
											if (confirm("�����Ͻðڽ��ϱ�?")) {
												// Ȯ�� ��ư�� ������ �� �����ؾ� �� ���α׷�
												cframe.location.href="comment_action.jsp?cmd=del&commentidx="+idx;
											} else {
												// ��� ��ư�� ������ �� �����ؾ� �� ���α׷�
											}
										}
										
												   								
								   		function doUpdate(){
								   			var form = document.comment;
								   			alert(form);
								   			if(form.comment.value == "" ) {
									   			alert("������ �����ϴ�.");
									   			return false;
								   			}
								   			
								   			return true;
								   		}
										
									//-->                 		
		                    		</script>	
	                    		</tr>
						</table>
						
	                    </td>
                    </tr>
                    <tr> 
                      <td height="7"></td>
                    </tr>                       
                    <tr> 
                      <td height="2" bgcolor="D3D2C3"></td>
                    </tr>                                       
                    <tr> 
                      <td align="right"   style="padding-top:5;">
                      <a href="event_modify.jsp?category=<%= category %>&idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="event_list.jsp?category=<%= category %>"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr> 
    <td  height="15"></td>
  </tr>
  <tr> 
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>

<iframe id='cframe' name='cframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>

</body>
</html>
