<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
/****************************************
*
* �� �� �� : Mr.K JM(czar.pe.kr@gmail.com)
* �ۼ����� : 2005�� 10�� 13��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.PressBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	PressBean bean = new PressBean();
	bean.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "15";
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
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

				<form name="form" method="post" action="cyber_press_update.jsp" enctype="multipart/form-data"  onSubmit="return goUpdate()">
				<input type="hidden" name="idx" value="<%= read.get("IDX") %>">

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>��б�� ����</b></td>
                    </tr>
                    <tr>
                      <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="218">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">�����</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this);  value=<%= (read.get("REGTIME") == null)?"":read.get("REGTIME").toString().substring(0, 10) %>></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">����<br></td>
                            <td style="padding-left:5;">

                            	<select name="section">
                                	<option <% if( read.get("SECTION").equals("1") ) { %>selected<% } %> value="1">�ϰ���</option>
                                	<option <% if( read.get("SECTION").equals("2") ) { %>selected<% } %> value="2">�ְ���</option>
                                	<option <% if( read.get("SECTION").equals("3") ) { %>selected<% } %> value="3">���ͳ�</option>
                                	<option <% if( read.get("SECTION").equals("4") ) { %>selected<% } %> value="4">�ְ���</option>
								</select>

							</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">��л�</td>
                            <td style="padding-left:5;"> <input type="text" name="journal" style="width:400px;height:20px" value="<%= Utility.ko( (String)read.get("JOURNAL") ) %>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">����</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value="<%= Utility.ko( (String)read.get("TITLE") ) %>">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td rowspan="3" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">������ �̹���</td>
                            <td height="30" style="padding-left:5;">
                            <% if( read.get("IMGS") == null || read.get("IMGS").equals("") ) { %>
                            	��ϵ� ������ �����ϴ�.
                            <% } else { %>
								<%= read.get("IMGS") %>&nbsp;&nbsp;<input type="checkbox" name="imgfiledel">�̹��� ����
                            <% } %>&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" style="padding-left:5;">
                              <input type="file" name="imgs" style="width:300px;height:20px">(* ���� �̹��� ������ : 79 * 62) </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����<br>���</p></td>
                            <td  style="padding: 10 10 10 10 ;">
                            <textarea name="summary" rows="3" wrap="VIRTUAL" style="width:400;"><%=(read.get("SUMMARY") == null)?"":Utility.ko( (String)read.get("SUMMARY")) %></textarea>
							</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����</p></td>
                            <td  style="padding: 10 10 10 10 ;"><!-- <textarea name="summary" rows="5" wrap="VIRTUAL" style="width:400;"><%= Utility.ko( (String)read.get("SUMMARY") ) %></textarea> -->
								<FCK:editor id="content" basePath="/FCKeditor/"
									width="100%"
									height="300"
									toolbarSet="asan"
									customConfigurationsPath="/asanway/js/fckconfig.js"
									imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
									linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
									<%= Utility.ko( (String)read.get("CONTENT") ) %>
								</FCK:editor>
                              <br>
                              * ��ü ��� ������ ��� ���� ���� �ֽñ� �ٶ��ϴ�.</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>��ũ�ּ�<br>
                              </p></td>
                            <td  style="padding: 10 10 10 10 ;"><input type="text" name="link" style="width:400px;height:20px" value="<%= Utility.ko( (String)read.get("LINK") ) %>"></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
                      <td align="right" style="padding-top:5;">
                      <div align="right">
                      		<input type="image" src="../img/bt_08.gif" width="40" height="20" hspace="4" border="0">
	                      	<a href="javascript:history.back()"><img src="../img/bt_11.gif" width="40" height="20" border="0"></a>
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
            </table>
            </td>
        </tr>
      </table>
      </td>
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
