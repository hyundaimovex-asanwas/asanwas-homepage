<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 10일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%
	String category = request.getParameter("category");
	if(category == null) category = "entry";
	// 이벤트 등록 : entry
	// 당첨자 발표 : announce

	String t = "";
	if( category.equals("entry") ) t = "이벤트";
	if( category.equals("announce") ) t = "당첨자 발표";
%>

<%@ page import="com.hmm.asan.asanway.support.EventBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	EventBean sb = new EventBean();
	sb.Read(request, response);
%>

<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	//오늘 날짜의 년, 월, 일을 생성, default select 위함
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
	int thisYear = Integer.parseInt(sdf.format(d));
	sdf = new SimpleDateFormat("MM");
	int thisMonth = Integer.parseInt(sdf.format(d));
	sdf = new SimpleDateFormat("dd");
	int thisDay = Integer.parseInt(sdf.format(d));

	//시작일
	int startyear = thisYear;
	int startmonth = thisMonth;
	int startday = thisDay;

	//종료일
	int endyear = thisYear;
	int endmonth = thisMonth;
	int endday = thisDay;
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />

<%
	String startdate = (String)read.get("STARTDATE");
	String enddate = (String)read.get("ENDDATE");

	int sy = Integer.parseInt(startdate.substring(0, 4));
	int sm = Integer.parseInt(startdate.substring(4, 6));
	int sd = Integer.parseInt(startdate.substring(6, 8));

	int ey = Integer.parseInt(enddate.substring(0, 4));
	int em = Integer.parseInt(enddate.substring(4, 6));
	int ed = Integer.parseInt(enddate.substring(6, 8));
%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %><%@ page import="com.hmm.asan.asanway.admin.AuthBean" %><%	String menuidx = "30";	AuthBean auth = new AuthBean();	if (!auth.AuthCheck(request, response, menuidx)){		response.sendRedirect("support_main.jsp?flag=1");	}%>
<script type="text/javascript" src="/asanway/js/makedate.js"></script>
<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>

<script language="javascript">
<!--
	function goUpdate()
	{

		var form = document.form;

		if( form.title.value=="" )
		{
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}

		if(form.startyear.selectedindex != 0 && form.startmonth.selectedindex != 0 && form.startday.selectedindex != 0 ){
			form.startdate.value = form.startyear.value + "" + form.startmonth.value + "" + form.startday.value;
		} else {
			alert("기간을 선택하세요");
			return false;
		}

		if(form.endyear.selectedindex != 0 && form.endmonth.selectedindex != 0 && form.endday.selectedindex != 0){
			form.enddate.value = form.endyear.value + "" + form.endmonth.value + "" + form.endday.value;
		} else {
			alert("기간을 선택하세요");
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


				<form name="form" method="post" action="event_update.jsp" onSubmit="return goUpdate()" enctype="multipart/form-data">
				<input type="hidden" name="category" value="<%=category %>">
				<input type="hidden" name="idx" value="<%= read.get("IDX") %>">
				<input type="hidden" name="startdate" value="">
				<input type="hidden" name="enddate" value="">


                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= t %> 수정
					</b></td>
                    </tr>
                    <tr>
                      <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="0" height="125">                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">등록일</td>
                            <td style="padding-left:5;"><input type="text" name="regday" style="width:100px;height:20px"  maxlength=10 onClick=Calendar(this); readonly value=<%= read.get("REGTIME").toString().substring(0, 10) %>></td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">제목</td>
                            <td style="padding-left:5;"> <input type="text" name="title" style="width:400px;height:20px" value='<%= Utility.ko((String)read.get("TITLE")) %>'>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;">기간</td>
                            <td style="padding-left:5;">
										<select name="startyear" onchange="ChangeOptionDays('form', 'start')" style="width:65px; height:19px;">
											<option value="">선택</option>
											<% for(int i = 2000; i <= 2020; i++) { %>
											<option value="<%=i%>" <% if(sy == i){ %>selected <%} %>><%=i%></option>
											<% } %>
										</select>
										<select name="startmonth" onchange="ChangeOptionDays('form', 'start')" style="width:55px; height:19px;">
											 <option value="">선택</option>
											 <% for(int i = 1; i <= 12; i++) { %>
											 	<% String tmp = i + ""; %>
											 	<% if(i < 10) tmp = "0" + tmp ;%>
												<option value="<%=tmp%>" <% if(sm == i){ %>selected <%} %>><%=tmp%></option>
											 <% } %>
										</select>
										<select name="startday" style="width:55px; height:19px;">
											 <option value="">선택</option>
											 <% int DaysInMonth = 31;
							  					if(startmonth == 4 || startmonth == 6 || startmonth == 9 || startmonth == 11)
							  						DaysInMonth = 30;

							  					if(startmonth == 2 &&  startyear % 4 == 0)
							  						DaysInMonth = 29;

							  					if(startmonth == 2 &&  startyear % 4 != 0)
							  						DaysInMonth = 28;
							  					%>
											 <% for(int i = 1; i <= DaysInMonth; i++) { %>
											 	<% String tmp = i + ""; %>
											 	<% if(i < 10) tmp = "0" + tmp ;%>
												<option value="<%=tmp%>" <% if(sd == i){ %>selected <%} %>><%=tmp%></option>
											 <% } %>
										</select>
										-
										<select name="endyear" onchange="ChangeOptionDays('form', 'end')" style="width:65px; height:19px;" <% if(enddate == null || enddate.trim().equals("")){ %>disabled<%}%>>
											<option value="">선택</option>
											<% for(int i = 2000; i <= 2020; i++) { %>
											<option value="<%=i%>" <% if(enddate != null && i == ey) {%>selected<%}%>><%=i%></option>
											<% } %>
										</select>
										<select name="endmonth" onchange="ChangeOptionDays('form', 'end')" style="width:55px; height:19px;"  <% if(enddate == null || enddate.trim().equals("")){ %>disabled<%}%>>
											 <option value="">선택</option>
											 <% for(int i = 1; i <= 12; i++) { %>
											 	<% String tmp = i + ""; %>
											 	<% if(i < 10) tmp = "0" + tmp ;%>
												<option value="<%=tmp%>" <% if(enddate != null && i == em) {%>selected<%}%>><%=tmp%></option>
											 <% } %>
										</select>
										<select name="endday" style="width:55px; height:19px;" <% if(enddate == null || enddate.trim().equals("")){ %>disabled<%}%>>
											 <option value="">선택</option>
											 <% DaysInMonth = 31;
							  					if(endmonth == 4 || endmonth == 6 || endmonth == 9 || endmonth == 11)
							  						DaysInMonth = 30;

							  					if(endmonth == 2 &&  endyear % 4 == 0)
							  						DaysInMonth = 29;

							  					if(endmonth == 2 &&  endyear % 4 != 0)
							  						DaysInMonth = 28;
							  					%>

											 <% for(int i = 1; i <= DaysInMonth; i++) { %>
											 	<% String tmp = i + ""; %>
											 	<% if(i < 10) tmp = "0" + tmp ;%>
												<option value="<%=tmp%>" <% if(enddate != null && i == ed) {%>selected<%}%>><%=tmp%></option>
											 <% } %>
										</select>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <% if( category.equals("entry") ) { %>
                          <tr>
                            <td height="30" bgcolor="F2F1E2" valign="top"  style="padding: 10 0 0 15 ;"><p>이미지</p></td>
                            <td style="padding: 10 10 10 10 ;"><% if( read.get("IMG") != null && !read.get("IMG").equals("") ) {  %><%= read.get("IMG") %> <input type="checkbox" name="imgdel" value="imgdel"><br><% } %>
                            <input type="file" name="img">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <% }  %>
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
									<%= Utility.ko( (String)read.get("CONTENT") ) %>
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
                        <div align="right">
                        <input type="image" src="../img/bt_08.gif" width="40" height="20" hspace="4" border="0">
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
