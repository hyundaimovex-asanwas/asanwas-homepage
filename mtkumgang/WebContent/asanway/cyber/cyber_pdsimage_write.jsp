<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : ������
* �ۼ����� : 2005�� 10�� 27��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	NewsBean nb = new NewsBean();
	nb.List(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

<%
	//����¡ �ϱ� ���� ���� �����Ѵ�.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getPagesize());
%>

<%
	// �˻�
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>


<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
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

				<form name="form" method="post" action="cyber_gallery_insert.jsp" enctype="multipart/form-data" onSubmit="return goInsert()">
				<input type="hidden" name="category" value="gallery">

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>������
                        ��� </b></td>
                    </tr>
                    <tr>
                      <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" height="71">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">����</td>
                            <td style="padding-left:5;"> <input type="text" name="title" size="20" maxlength="30" style="width:400px;height:20px" >
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���1</td>
                            <td style="padding-left:5;"> <input type="file" name="img1" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���2</td>
                            <td style="padding-left:5;"> <input type="file" name="img2" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���3</td>
                            <td style="padding-left:5;"> <input type="file" name="img3" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���4</td>
                            <td style="padding-left:5;"> <input type="file" name="img4" size="50" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 25 ;">�̹���5</td>
                            <td style="padding-left:5;"> <input type="file" name="img5" style="width:300px;height:20px" >(* ���� �̹��� ������ : 600 * 400)
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
                        <div align="right">
	                        <!--  <a href="cyber_gallery_pop.jsp">	<img src="../img/bt_14.gif" width="58" height="20" hspace="4" border="0"></a> -->
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
