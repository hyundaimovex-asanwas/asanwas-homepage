<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 15��
* ��� ���� : ��ũ�� ������ ���� (�Ź�, ����, ���, ���ͳ�)
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%
	String menutitle = "";
	String downfolder = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.  �ٽ� �õ��� �ֽʽÿ�.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("magazine")){
			menutitle = "��ũ�������� - ������� ��ũ��";
			downfolder = "scrap";

		}else if(category.equals("broadcast")){
			menutitle = "��ũ�������� - ��۱�� ��ũ��";
			downfolder = "scrap";

		}else if(category.equals("internet")){
			menutitle = "��ũ�������� - ���ͳ� ��� ��ũ��";
			downfolder = "scrap";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�. �ٽ� �õ��� �ֽʽÿ�.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}
%>
<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "20";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>
<script language="javascript">
<!--
	function goInsert()
	{

		var form = document.form;

		if( form.title.value=="" )
		{
			alert("������ �Է��ϼ���.");
			form.title.focus();
			return false;
		}
		form.action = "cyber_scrap_action.jsp?category=<%=category%>&cmd=I" ;
		form.target = "_self";
		return true;

	}

	function _preView(img){
		var form = document.form;
		form.target = "pop";
		form.action = "cyber_scrap_preview.jsp?preimg=" + img  ;
		window.open("","pop"," width=1024, height=768, top=100, left=200, scrollbars=yes");
		form.submit();
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

				<form name="form" method="post" action="cyber_scrap_action.jsp?category=<%=category%>&cmd=I" enctype="multipart/form-data" onSubmit="return goInsert()">

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b> <%=menutitle%></b></td>
                    </tr>
                    <tr>
                      <td>
                      	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="156">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">����</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" >
                            </td>
                          </tr>

                      	  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">������</td>
                            <td style="padding-left:5;"><input type="text" name="pubdate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>

						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">��ü</td>
                            <td style="padding-left:5;"> <input type="text" name="section2" style="width:400px;height:20px" >
                            </td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">��籸��</td>
                            <td style="padding-left:5;">
                            	<select name="section1"  style="width:150px;height:20px" >
                                      <option value="1">������ñ��</option>
                                      <option value="2" >�ѹݵ����ñ�� </option>
                                      <option value="3" >��Ÿ</option>
                                </select>
                            </td>
                          </tr>

                          <%if(category.equals("magazine")) { %>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
						        <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"> ����̹��� </td>
	                            <td  style="padding-left:5;">
									<input type=file name='imgfile' size="50" style='width:400px;height:20px'>
									</td>
	                          </tr>
	                      <% } %>

						  <%if(category.equals("broadcast")) { %>
							  <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">������ �ּ� </td>
	                            <td style="padding-left:5;"> <input type="text" name="fileloc" style="width:400px;height:20px" >
	                            </td>
	                          </tr>
						  <%}%>

						  <%if(!category.equals("magazine")) { %>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>����</p></td>
	                            <td  style="padding: 10 10 10 10 ;"><!-- <textarea name="textarea" rows="5" wrap="VIRTUAL" style="width:400;"></textarea>-->
									<FCK:editor id="content" basePath="/FCKeditor/"
										width="100%"
										height="300"
										toolbarSet="asan"
										customConfigurationsPath="/asanway/js/fckconfig.js"
										imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
										linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
									</FCK:editor>
	                            </td>
	                          </tr>
	                      <%}%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                       </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                        <div align="right">
                        	 <%if(category.equals("magazine")) { %><a href="javascript:_preView();"><img  src="/img/scrap/bt_preview.gif" border="0"></a><%}%>
                        	<input type="image" src="../img/bt_07.gif" width="40" height="20" border="0">
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
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
</body>
</html>
