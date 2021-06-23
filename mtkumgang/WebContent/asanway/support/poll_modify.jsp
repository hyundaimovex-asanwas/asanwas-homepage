<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.PollBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	PollBean bean = new PollBean();
	bean.Read(request, response);
%>

<jsp:useBean id="readitem" class="java.util.ArrayList" scope="request" />

<%
	HashMap read = (HashMap)readitem.get(0);

	int count = 0;
	for(int i = 0; i < readitem.size(); i++) {
	    HashMap hm = (HashMap)readitem.get(i);
	    
	    count += Integer.parseInt((String)hm.get("HIT"));
	}
	
	String startdate = read.get("STARTDATE").toString().substring(0,4) + "-" + read.get("STARTDATE").toString().substring(4,6) + "-" + read.get("STARTDATE").toString().substring(6,8);
	String enddate = read.get("ENDDATE").toString().substring(0,4) + "-" + read.get("ENDDATE").toString().substring(4,6) + "-" + read.get("ENDDATE").toString().substring(6,8);	
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "31";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../css/style.css" type="text/css">

<script language="javascript">
<!--
	function goUpdate()
	{

		var form = document.form;

		if( form.title.value=="" )
		{
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		
		return true;
	}
	
		function makeDelList(idx) {
			var form = document.form;

			var data_obj = form.fileidxlist[idx];
			var datadel_obj = form.fileidxdelfg[idx];
			var img_obj = form.fileidxcheck[idx];
			
			var file_obj0 = form.file1;
			var file_obj1 = form.file2;
			var file_obj2 = form.file3;
			var file_obj3 = form.file4;			


			// 선택된 것이 1개일때는 배열이 아님
			if(data_obj == null) {
				data_obj = form.fileidxlist;
				datadel_obj = form.fileidxdelfg;
				img_obj = form.fileidxcheck;
			}

			if(img_obj.checked) {
				datadel_obj.value = "1";
				eval("file_obj"+idx+".disabled = false;");

			} else {
				datadel_obj.value = "0";
				eval("file_obj"+idx+".disabled = true;");
			}

		}	
	
	
	-->
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
                
			<form name="form" method="post" action="poll_update.jsp" onSubmit="return goUpdate()" enctype="multipart/form-data">                
			<input type="hidden" name="idx" value="<%= request.getParameter("idx") %>">                
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>설문 수정</b></td>
                    </tr>
                    <tr> 
                      <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" height="156">
                      	   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">등록일</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value="<%= read.get("REGTIME").toString().substring(0, 10) %>"></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">설문 기간</td>
                            <td style="padding-left:5;">시작일 : <input type="text" name="startdate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value="<%= startdate %>"> ~ 종료일 : <input type="text" name="enddate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value="<%= enddate %>"></td>
                          </tr>                          
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td width="65" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value="<%= Utility.ko( (String)read.get("TITLE")) %>"> 
                            </td>
                          </tr>		    					    					    

					<%	for(int i = 0; i < 4; i++) { 
                      	    if( readitem.size()  > i  ) {
								HashMap hm = (HashMap)readitem.get(i);
					%>                          
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="60" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">항목<%= i + 1 %></td>
                            <td style="padding-left:5;"> 

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td rowspan="2">
										<input type="text" name="item<%= i+1 %>" style="width:200px;height:20px" value="<%= Utility.ko( (String)hm.get("ITEM")) %>">
									</td>
									<td width="75" rowspan="2"><span class="pass">* 작은 이미지 </span></td>		
                                  <% if( hm.get("IMG") != null && !hm.get("IMG").equals("") ) { %>
									<td width="150"><%= hm.get("IMG") %> </td>								
									<td><input type="checkbox" name="fileidxcheck" onClick="makeDelList(<%=i%>)"> 파일 삭제</td>								
	                              <% } else { %>
									<td width="150">default.gif</td>								
									<td><input type="checkbox" name="fileidxcheck" onClick="makeDelList(<%=i%>)"> 파일 삭제</td>                            	    											
                                  <% }  %>															  
								</tr>
								<tr>
									<td colspan="2">
										<input type="file" name="file<%= i + 1 %>" style="width:200px;height:20px" size="30" disabled="true">
										<input type="hidden" name="fileidxlist" value="<%= hm.get("ITEMIDX")%>">
										<input type="hidden" name="fileidxdelfg" value="0">
									</td>										
								</tr>
								</table>

                            </td>
                          </tr>
					<% } else { %>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="60" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">항목<%= i + 1 %></td>
                            <td style="padding-left:5;">                                                      

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td rowspan="2">
										<input type="text" name="item<%= i + 1 %>" style="width:200px;height:20px" value="">
									</td>
									<td width="75" rowspan="2"><span class="pass">* 작은 이미지 </span></td>								  
									<td></td>								
									<td></td>								
								</tr>
								<tr>
									<td colspan="2">
										<input type="file" name="file<%= i + 1%>" style="width:200px;height:20px" size="30">
										<input type="hidden" name="fileidxlist" value="">
										<input type="hidden" name="fileidxdelfg" value="0">
									</td>										
								</tr>
								</table>
								  								
                            </td>
                          </tr>							
							<% }  %>
						<% } %>
						
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td align="right"   style="padding-top:5;"> 
                        <div align="right">
                        <input type="image" src="../img/bt_08.gif" width="40" height="20" hspace="3" border="0">
                        <a href="#" onClick="self.location.href=document.referrer"><img src="../img/bt_11.gif" width="40" height="20" border="0"></a>
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td height="50" align="center">&nbsp;</td>
                    </tr>
              
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                  
                  </form>
                  
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
    <td height="30"  bgcolor="D4D4B2"><table width="850" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../img/bottom_01.gif" align="absmiddle"></td>
          <td align="right"><a href="#"><img src="../img/bottom_02_01.gif" border="0"></a></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
