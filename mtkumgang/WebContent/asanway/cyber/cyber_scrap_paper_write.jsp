<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 16일
* 요약 설명 : 스크랩 마스터  (신문)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%
	String menutitle = "스크랩마스터 - 신문기사  스크랩";
	String downfolder = "scrappaper";
	String category = "scrappaper";
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
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		form.action = "cyber_scrap_paper_action.jsp?cmd=I" ;
		form.target = "_self";
		return true;

	}

	function _preView(img){
		var form = document.form;
		form.target = "pop";
		form.action = "cyber_scrap_paper_preview.jsp?preimg=" + img  ;
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

				<form name="form" method="post" action="cyber_scrap_paper_action.jsp?cmd=I" enctype="multipart/form-data" onSubmit="return goInsert()">
					<input type=hidden name=category value="<%=category%>">
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
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">발행일</td>
                            <td style="padding-left:5;"><input type="text" name="pubdate" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly></td>
                          </tr>

						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">발행판</td>
                            <td style="padding-left:5;">
								<select name="section2"  style="width:80px;height:20px" >
                              		      <option value="1" >가판</option>
	                                      <option value="2" >종합판 </option>
	                                      <option value="3" >석간</option>
	                              </select>
                            </td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">기사구분</td>
                            <td style="padding-left:5;">
                            	<select name="section1"  style="width:150px;height:20px" >
                                      <option value="1">사업관련기사</option>
                                      <option value="2" >한반도관련기사 </option>
                                      <option value="3" >기타</option>
                                </select>
                            </td>
                          </tr>
						  <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">파일위치 </td>
                            <td style="padding-left:5;"> <input type="text" name="fileloc" style="width:200px;height:20px"> ex) 20051115  (*서버 절대 경로 : /was/file_upload/scrappaper/)
                            </td>
                          </tr>
					       <tr>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                            <td height="1" bgcolor="D3D2C3"></td>
	                          </tr>
	                          <tr>
	                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>기사목록 </p></td>
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
                        <div align="right">
                        	 <a href="javascript:_preView();"><img  src="/img/scrap/bt_preview.gif" border="0"></a>
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
