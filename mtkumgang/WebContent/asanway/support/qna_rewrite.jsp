<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : czar
* 작성날자 : 2005년 11.14
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%@ page import="com.hmm.asan.asanway.support.QnaBean" %>
<%
	String category = "qna";

	QnaBean sb = new QnaBean();
	sb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "29";
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

		if( form.title.value=="" )
		{
			alert("제목을 입력하세요.");
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
					<jsp:include page="left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td valign="top" style="padding: 15 0 0 20;">                
                
                
				<form name="form" method="post" action="qna_reinsert.jsp" onSubmit="return goInsert()">
				<input type="hidden" name="category" value="<%=category %>">
				<input type="hidden" name="group" value="<%= read.get("IDX") %>">
				<input type="hidden" name="reguser" value="<%= read.get("REGUSER")%>">
				<input type="hidden" name="section" value="<%= read.get("SECTION")%>">				
								                
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>QNA 답변
					</b></td>
                    </tr>
                    <tr> 
                      <td>                                           
                       <table width="100%" border="0" cellspacing="0" cellpadding="0" height="125">

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
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value=''> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>내용</p></td>
                            <td  style="padding: 10 10 10 10 ;">
                            <textarea name="content" rows="5" wrap="VIRTUAL" style="width:100%;height:400px;"></textarea>
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
                        <input type="image" src="../img/bt_07.gif" width="40" height="20" hspace="4" border="0">
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
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
</body>
</html>
