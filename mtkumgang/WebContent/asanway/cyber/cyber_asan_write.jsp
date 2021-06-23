<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 25일
* 요약 설명 : 아산인-수다 /자료실
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%
	String menutitle = "";
	String downfolder = "";
	String tdcolspan = "";
	String menuidx = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.  다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("asantalk")){
			menutitle = "미래를 열어가는 현대아산人 - 아산인들의 수다 ";
			downfolder = "asantalk";
			tdcolspan = "9";
			menuidx = "18";
		}else if(category.equals("asanpds")){
			menutitle = "미래를 열어가는 현대아산人 - 아산인 자료실";
			downfolder = "asanpds";
			tdcolspan = "11";
			menuidx = "18";

		}else if(category.equals("asannotice")){
			menutitle = "미래를 열어가는 현대아산人 - 공지/회람";
			downfolder = "asannotice";
			tdcolspan = "11";
			menuidx = "18";

		}else if(category.equals("weeklytrend")){
			menutitle = "사이버 홍보실 - 주간동향";
			downfolder = "weeklytrend";
			tdcolspan = "11";
			menuidx = "20";

		}else if(category.equals("echo")){
			menutitle = "사이버 홍보실 - 금강산 메아리";
			downfolder = "echo";
			tdcolspan = "11";
			menuidx = "20";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다. 다시 시도해 주십시오.');");
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
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">

				<form name="form" method="post" action="cyber_asan_action.jsp?category=<%=category%>&cmd=I" enctype="multipart/form-data" onSubmit="return goInsert()">

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
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">등록일</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>

                      	   <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">구분</td>
                            <td style="padding-left:5;">
                            	<select name="section"  style="width:80px;height:20px" >
                                      <option value="1">공지</option>
                                      <option value="2">일반 </option>
                                </select>
                            </td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" >
                            </td>
                          </tr>

                          <%if(!category.equals("asantalk")) { %>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
						        <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"> 첨부파일</td>
	                            <td  style="padding-left:5;">
									<script>
										//파일 사이즈 가져오기
										function getFileSize(val){
											//tmp.dynsrc = val;
											return val.fileSize;
										}
									</script>
									<input type=file name='file1' size="50" style='width:400px;height:20px'>
									</td>
	                          </tr>
	                       <% } %>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>내용</p></td>
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
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                       </td>
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
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
</body>
</html>
