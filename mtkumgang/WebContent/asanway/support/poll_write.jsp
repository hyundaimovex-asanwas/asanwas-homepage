<%@ page language="java" contentType="text/html; charset=euc-kr"%>
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


<script language="javascript">
<!--
	function goInsert()
	{

		var form = document.form;

		if( form.title.value=="" ){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if( form.startdate.value == "" ){
			alert("시작일을 지정해주세요.");
			return false;
		}
		if( form.enddate.value == "" ){
			alert("종료일을 지정해주세요.");
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
					<jsp:include page="left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

			<form name="form" method="post" action="poll_insert.jsp" onSubmit="return goInsert()" enctype="multipart/form-data">

                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>설문 등록</b></td>
                    </tr>
                    <tr>
                      <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0" height="156">
                                            	   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">등록일</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">설문 기간</td>
                            <td style="padding-left:5;">시작일 : <input type="text" name="startdate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly> ~ 종료일 : <input type="text" name="enddate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td width="65" height="30" valign="top" bgcolor="F2F1E2"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" >
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">항목1</td>
                            <td style="padding-left:5;"> <input type="text" name="item1" style="width:200px;height:20px" >
                              &nbsp;<span class="pass"> * 작은 이미지</span>
                              <input type="file" name="file1" style="width:150px;height:20px" size="30">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">항목2</td>
                            <td style="padding-left:5;"> <input type="text" name="item2" style="width:200px;height:20px" >
                              &nbsp;&nbsp;<span class="pass">* 작은 이미지</span>
                              <input type="file" name="file2" style="width:150px;height:20px" size="30">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">항목3</td>
                            <td style="padding-left:5;"> <input type="text" name="item3" style="width:200px;height:20px" >
                              &nbsp; <span class="pass">* 작은 이미지</span>
                              <input type="file" name="file3" style="width:150px;height:20px" size="30">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">항목4</td>
                            <td style="padding-left:5;"> <input type="text" name="item4" style="width:200px;height:20px" >
                              &nbsp;&nbsp;<span class="pass">* 작은 이미지</span>
                              <input type="file" name="file4" style="width:150px;height:20px" size="30">
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
                        <div align="right"><input type="image" src="../img/bt_07.gif" width="40" height="20" border="0">
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
