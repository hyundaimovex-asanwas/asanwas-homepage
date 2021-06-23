<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 27일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "16";
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
                
				<form name="form" method="post" action="cyber_newsletter_insert.jsp" enctype="multipart/form-data" onSubmit="return goInsert()">
                
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>뉴스레터(웹진) 등록	</b></td>
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
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">구분<br></td>
                            <td style="padding-left:5;">
								<select name="category">
								<option value="user">일반회원</option>
								<option value="admin">관계자</option>
								</select>
                            </td>
                          </tr>                      
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목<br></td>
                            <td style="padding-left:5;"><input type="text" name="title" style="width:400px;height:20px" > 
                            </td>
                          </tr>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">상단이미지</td>
                            <td style="padding-left:5;padding-top:7px; padding-bottom:7px;">
                            
                            <script>
                            	// 이미지 선택 확인
                            	<!--
									function doChange()
									{
										var v = document.form.img.value;								
										
										if(v == 'newsletter_popup_title.gif') {
											vimage1.style.display = 'block';
											image.style.display = 'none';
										} else {
											vimage1.style.display = 'none';
											image.style.display = 'block';
										}
									}
									//-->
							</script>
                            
									<select name="img" onchange="doChange()" style="width:100px; height:19px;">
											<option value="newsletter_popup_title.gif">기본이미지</option>
											<option value="etc">직접입력</option>
									</select>
									<div id="vimage1" style="display:block; padding-top:5px;"><img src="/img/newsletter/newsletter_popup_title.gif" width="580"></div>
									<div id="image" style="display:none; padding-top:5px;"><INPUT TYPE="file" CLASS="input" SIZE="55" name="image">&nbsp;<b><font color="orange">( 580 * 47pixel )</font></div>
																		
                            </td>
                          </tr>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>내용</p></td>
                            <td  style="padding: 10 10 10 10 ;">
									<!-- <textarea name="textarea" rows="5" wrap="VIRTUAL" style="width:400;"></textarea>  -->
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
                        </table></td>
                    </tr>
                    <tr> 
                      <td align="right"   style="padding-top:5;"><input type="image" src="../img/bt_07.gif" width="40" height="20" border="0"></td>
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
