<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>


<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 21��
* ��� ���� : �ڷ�� ���� (����, ���ù���, ��Ÿ �ڷ�� ����)
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.PdsBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	String menutitle = "";
	String downfolder = "";
	String menuidx = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.\n\n�ٽ� �õ��� �ֽʽÿ�.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("pdsdoc")){
			menutitle = "�����ڷ�";
			downfolder = "pdsdoc";
			menuidx = "23";
		}

		else if(category.equals("pdslaw")){
			menutitle = "���ù���";
			downfolder = "pdslaw";
			menuidx = "24";
		}

		else if(category.equals("pdsetc")){
			menutitle = "��Ÿ";
			downfolder = "pdsetc";
			menuidx = "26";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.\n\n�ٽ� �õ��� �ֽʽÿ�.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}
%>

<%
	PdsBean bean = new PdsBean(category);
	bean.Read(request, response);
%>


<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="fileread" class="java.util.ArrayList" scope="request" />

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
<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>
<script language="javascript">
<!--
	function goUpdate()
	{

		var form = document.form;

		if( form.title.value=="" )
		{
			alert("������ �Է��ϼ���.");
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

			var file_obj0 = form.file0;
			var file_obj1 = form.file1;
			var file_obj2 = form.file2;


			// ���õ� ���� 1���϶��� �迭�� �ƴ�
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
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

				<form name="form" method="post" action="cyber_pds_action.jsp?category=<%=category%>&cmd=U" enctype="multipart/form-data" onSubmit="return goUpdate()">
					<input type="hidden" name="idx" value="<%= read.get("IDX") %>">

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>�ڷ�� - <%=menutitle%>
                        ����</b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="187">

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�����</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value=<%= read.get("REGTIME").toString().substring(0, 10) %>></td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">����</td>
                            <td style="padding-left:5;">
                            	<select name="section"  style="width:80px;height:20px" >
                                      <option value="1" <% if( read.get("SECTION").equals("1") ) { %>selected<% } %>>����ƻ�</option>
                                      <option value="2" <% if( read.get("SECTION").equals("2") ) { %>selected<% } %>>�������</option>
                                      <option value="3" <% if( read.get("SECTION").equals("3") ) { %>selected<% } %>>��������</option>
									  <option value="4" <% if( read.get("SECTION").equals("4") ) { %>selected<% } %>>�Ǽ����</option>
									  <option value="4" <% if( read.get("SECTION").equals("5") ) { %>selected<% } %>>��Ÿ�������</option>
                                </select>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">����</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value='<%= Utility.ko( (String)read.get("TITLE") ) %>'>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">������ �̹���</td>
                            <td height="30" style="padding-left:5;">
                            <% if( read.get("IMGS") != null && !read.get("IMGS").equals("") ) { %>
                            	<%= Utility.ko( (String)read.get("IMGS") ) %> &nbsp;<input type="checkbox" name="imgsdel">�̹��� ����
                            <% } else { %>
                            	��ϵ� �̹����� �����ϴ�.
                            <% } %>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:5;"> <input type="file" name="imgs" size="30" style="width:300px;height:20px" >(* ���� �̹��� ������ : 79 * 62)</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                      	  <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>��ϵ�
                                <br>
                                ÷������<br>
                              </p></td>
							<td height="30" style="padding-left:5;">

									<table>
    	                              <% if( fileread.size() == 0 ) { %>
	                                  	<tr><td>��ϵ� ������ �����ϴ�.
				        				<tr><td><input type="file" name="file0" size="50" style="width:400px;height:20px">
    	                              <% } else {
    	                                  	for(int i = 0; i < 3 ; i++) {

    	                                  	    if( fileread.size()  > i  ) {
        	                                  	    HashMap hm = (HashMap)fileread.get(i);
	                                  	        %>
    									<tr>
    										<td><%= Utility.ko( (String)hm.get("FILE") )%>&nbsp; <input type="checkbox" name="fileidxcheck" onClick="makeDelList(<%=i%>)">���� ����<br>
				        							<input type="file" name="file<%=i %>" size="50" style="width:400px;height:20px" disabled="true">
													<input type="hidden" name="fileidxlist" value="<%=hm.get("IDX")%>">
													<input type="hidden" name="fileidxdelfg" value="0">
										<% } else { 	%>
					        				<tr><td><input type="file" name="file<%= i %>" size="50" style="width:400px;height:20px">
    	                                  <% } } } %>
	                                  </table>

                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����</p></td>
                            <td  style="padding: 10 10 10 10 ;"> <!-- <textarea name="textarea" rows="5" wrap="VIRTUAL" style="width:400;"></textarea> -->
								<FCK:editor id="content" basePath="/FCKeditor/"
									width="100%"
									height="300"
									toolbarSet="asan"
									customConfigurationsPath="/asanway/js/fckconfig.js"
									imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
									linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
									<%= Utility.ko( (String)read.get("CONTENT")) %>
								</FCK:editor>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>

                        </table></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <div align="right"><input type="image" src="../img/bt_08.gif" hspace="4" border="0">
                      	<a href="#" onClick="javascript:history.back()"><img src="../img/bt_11.gif" border="0"></a>
                        </div></td>
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
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
</body>
</html>
