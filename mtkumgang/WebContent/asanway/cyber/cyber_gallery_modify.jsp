<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : ������
* �ۼ����� : 2005�� 10�� 10��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.GalleryBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = request.getParameter("category");
	String menuidx = "";
	if(category.equals("gallery")){
		menuidx = "17";
	}else{
		menuidx = "22";
	}

	GalleryBean bean = new GalleryBean();
	bean.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.ArrayList" scope="request" />
<% HashMap hm1 = (HashMap)read.get(0); %>


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

			//product �� 1���϶��� �迭�� �ƴ�
			if(data_obj == null) {
				data_obj = form.fileidxlist;
				datadel_obj = form.fileidxdelfg;
				img_obj = form.fileidxcheck;
			}

			if(img_obj.checked) {
				datadel_obj.value = "1";
			} else {
				datadel_obj.value = "0";
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
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

				<SCRIPT Language="JavaScript">
				<!--

				//�� �з��� ���� �迭
				List = new Array(5);
				List[0]=new Array(1);	// ����ƻ�
				List[1]=new Array(3);	// �������
				List[2]=new Array(4);	// ��������
				List[3]=new Array(1);	// �Ǽ����
				List[4]=new Array(1);	// ��Ÿ�������

				// 0 ����ƻ�
				List[0][0]="";

				// 1 �������
				List[1][0]="�ݰ���";
				List[1][1]="����";
				List[1][2]="��λ�";

				// 2 ��������
				List[2][0]="��ϻ���";
				List[2][1]="�ֱٸ��";
				List[2][2]="������������ ��Ȳ";
				List[2][3]="���������� ��Ȳ";

				// 3 �Ǽ����
				List[3][0]="";

				// 4 ��Ÿ�������
				List[4][0]="";



				//Ư�� ä���� �����ϸ� �ش� ī�װ��� ����
				function BuildList(num)
				{

				      //ù ��° ī�װ� ����
				      document.form.section2.selectedIndex=0;

				      //�ش� ä���� ���� ī�װ� �迭 ���̸�ŭ �ݺ�
				      for(ctr=0;ctr<List[num].length;ctr++)
				      {
					       //ī�װ��� �ش��ϴ� �޺��ڽ��� ���� ä��
					       document.form.section2.options[ctr] = new Option(List[num][ctr], ctr);
				      }

				      //select ����Ʈ ���� ����
				      document.form.section2.length = List[num].length;
				}

				function subList(num)
				{
				      document.form.section2.selectedIndex = num;
				}
				//-->
				</Script>

				<form name="form" method="post" action="cyber_gallery_update.jsp" enctype="multipart/form-data" onSubmit="return goUpdate()">
				<input type="hidden" name="category" value="<%= category %>">
				<input type="hidden" name="idx" value="<%= hm1.get("IDX") %>">

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= category.equals("gallery")  ? "������ ����" : "�ڷ�� - �̹��� ����" %></b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" height="71">
                      <% if( category.equals("image") ) { %>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">����</td>
                            <td style="padding-left:5;">

		                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                          <tr>
		                            <td style="padding-left:5;" width="200">
		                            	<select name="section1"  OnChange="BuildList(this.selectedIndex);">
			                            	<option value="0" <%= hm1.get("SECTION1").equals("0") ? "selected" : "" %>>����ƻ�</option>
			                            	<option value="1" <%= hm1.get("SECTION1").equals("1") ? "selected" : "" %>>�������</option>
			                            	<option value="2" <%= hm1.get("SECTION1").equals("2") ? "selected" : "" %>>��������</option>
			                            	<option value="3" <%= hm1.get("SECTION1").equals("3") ? "selected" : "" %>>�Ǽ����</option>
			                            	<option value="4" <%= hm1.get("SECTION1").equals("4") ? "selected" : "" %>>��Ÿ�������</option>
		                            	</select>
		                          	</td>
		                            <td height="30" width="75" bgcolor="F2F1E2" valign="top" style="padding: 10 0 0 25 ;">�󼼱���</td>
		                            <td style="padding-left:5;">
		                            	<select name="section2">
			                            	<option value="">---</option>
		                            	</select>
		                            </td>
		                          </tr>
                            	</table>

                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <script>
	                          BuildList(<%= hm1.get("SECTION1") %>);
	                          subList(<%= hm1.get("SECTION2") %>);
                          </script>
                          <% } %>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">����</td>
                            <td style="padding-left:5;"><input type="text" name="title" maxlength="30" size="20" value='<%= Utility.ko( (String)hm1.get("TITLE") ) %>'></td>
                          </tr>
<% if( read.size() == 0 ) {
			for( int i = 1; i < 6; i++) {
%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���</td>
                            <td style="padding-left:5;">
                            <input type="file" name="img<%= i %>" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
<% } } else { %>
<% for(int i = 0; i < read.size(); i++) {
			HashMap hm = (HashMap)read.get(i);
%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���</td>
                            <td style="padding-left:5;">
								<input type="hidden" name="fileidxlist" value="<%=hm.get("FILEIDX")%>">
								<input type="hidden" name="fileidxdelfg" value="0">
                            <%= Utility.ko( (String)hm.get("FILE") ) %><input type="checkbox" name="fileidxcheck" onClick="makeDelList(<%=i%>)"> �̹��� ����<br>
                            <input type="file" name="img<%= i+1 %>" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
<% } } %>
<% for(int i = 0; i <  5 - read.size() ; i++)  {%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���</td>
                            <td style="padding-left:5;">
                            <input type="file" name="img<%= 5 - i %>" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
<% } %>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table> </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
	                      <input type="image" src="../img/bt_08.gif" width="40" height="20" hspace="4" border="0">
                      <a href="#" onClick="self.location.href=document.referrer"><img src="../img/bt_11.gif" width="40" height="20" border="0"></a>
                      </td>
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
