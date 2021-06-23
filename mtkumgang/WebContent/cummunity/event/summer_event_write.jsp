<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.*"%>
<%@ page import="com.hmm.ejb.common.UtilDB"%>

<%
if(session_id.equals("")){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("로그인 해주세요.");
opener.location.href= "http://www.mtkumgang.com/member/login.jsp";
window.self.close();
//-->
</SCRIPT>
<%
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::금강산 여름휴가 프로젝트::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.txt{font-family:돋움; font-size:11; border: 1 solid;}
.font{font-family:돋움; font-size:11;}
#Layer1 {	position:absolute;
	left:282px;
	top:408px;
	width:208px;
	height:158px;
	z-index:1;
}
#Layer2 {	position:absolute;
	left:166px;
	top:337px;
	width:43px;
	height:36px;
	z-index:2;
}

-->
</style>
<script language="javascript">
function event_go(){
	var f = document.frm;
	if(f.content.value == ""){
		alert("여름휴가 계획을 기입해 주세요.");
		return;
	}

	if(f.content.value.length > 400)
	{
		alert("여름휴가 계획은 400자 이내로만 입력이 가능합니다.");
		f.content.value = f.content.value.substring(0, 400);
		return;
	}

	f.action = "summer_eventProc.jsp";
	f.submit();
}
</script>
</head>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="<%=imageServer%>/summer_img/01.jpg" width="800" height="238"></td>
  </tr>
  <tr>
    <td><table width="800" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="554" rowspan="2"><table width="554" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="421" valign="top" background="<%=imageServer%>/summer_img/02.jpg"><table width="554" height="388" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="44">&nbsp;</td>
                <td width="510" height="388" align="center" background="<%=imageServer%>/summer_img/03.jpg" style="padding:15 15 15 15;">
				<%    
					   int i_total_no=0;

					   Connection conn = null;
					   PreparedStatement pstmt = null; 
					   ResultSet rs = null;   
					   
					   String query = ""; 
					   try { 
						  conn = UtilDB.getConnection("jdbc/tourds"); 
						  query = "select count(*) from asan.EVENT_SUMMER"; 
						  pstmt = conn.prepareStatement(query); 
						  rs = pstmt.executeQuery(); 

						  if(rs.next()) {
							i_total_no=rs.getInt(1);  //총 글수
						  }

						  query = "select IDX, ID, NAME, CONTENT, I_DATE from asan.EVENT_SUMMER "; 				  

						  pstmt = conn.prepareStatement(query);
						  rs = pstmt.executeQuery(); 
							
						  String idx = ""; 
						  String id = "";
						  String name = "";
						  String content = "";
						  String i_date = "";
						  int i = 0;

						  while (rs.next()) {             
							idx = rs.getString("IDX"); 
							id = rs.getString("ID");
							name = rs.getString("NAME"); 
							content = rs.getString("CONTENT"); 
							i_date = rs.getString("I_DATE").substring(0,10); 	  
					%> 
				<div id="Layer<%=i%>" style="position:absolute; left:284px; top:331px; width:200px; height:130px; z-index:1; overflow: visible; visibility: hidden;">
                  <table width="200" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="1" rowspan="3" bgcolor="#3B52B7"></td>
                      <td height="1" bgcolor="#3B52B7"></td>
                      <td width="1" rowspan="3" bgcolor="#3B52B7"></td>
                    </tr>
                    <tr>
                      <td height="150" align="center" bgcolor="ffffff">
					  <table width="180" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
							<table width="180" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="130" height="20" class="font"><%=name%>(<%=id%>)</td>
                                  <td width="50" align="right"><a href="#"><img src="<%=imageServer%>/summer_img/btn_close.gif" width="9" height="9" border="0" /></a></td>
                                </tr>
                            </table>
							</td>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="#3B52B7"></td>
                          </tr>
                          <tr>
                            <td height="110" valign="top" style="padding-top:10;"><%=content%></td>
                          </tr>
                      </table>
					  </td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="#3B52B7"></td>
                    </tr>
                  </table>
                </div>
				<% 
						 i++;	
					   }  
					%> 
				   <% 
					}catch (Exception e) {
						e.printStackTrace();
						System.out.println("Exception during connection :"+e.getMessage());
					} finally {
						UtilDB.closeConnection(conn, pstmt, rs);
					}
				%>
				<% 
				String colNum = "";
				for(int n=0;n<i_total_no;n++) { 

				if (n%3 == 0){
					colNum = "01";
				}else if (n%3 == 1){
					colNum = "02";
				}else{
					colNum = "03";
				}
				%>
				 <img src="<%=imageServer%>/summer_img/ico_<%=colNum%>.gif" name="Image<%=n%>" onMouseOut="cnj_hide(document.all.Layer<%=n%>.style)" onMouseOver="cnj_show(document.all.Layer<%=n%>.style)" width="35" height="30" border="0"> 
				 <% } %>				 </td>
              </tr>
            </table></td>
          </tr>
        </table>
		</td>
		<FORM name="frm" method="post">
        <td height="232" valign="top" background="<%=imageServer%>/summer_img/04.jpg">
		<table width="246" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="75">&nbsp;</td>
          </tr>
          <tr>
            <td style="padding-left:7;"><input name="name" type="text" id="name" value="<%=session_name%>(<%=session_id%>)" size="20" class="txt">
              <br>
              <br>
              <textarea name="content" cols="26" rows="8" class="txt" wrap="VIRTUAL" id="text"></textarea></td>
          </tr>
        </table>
		</td>
		</FORM>
      </tr>
      <tr>
        <td><img src="<%=imageServer%>/summer_img/05.jpg" width="246" height="189" border="0" usemap="#done"></td>
      </tr>
    </table></td>
  </tr>
</table>

<map name="done">
<area shape="rect" coords="10,4,200,59" href="javascript:event_go()" onFocus="this.blur()">
<area shape="rect" coords="11,81,200,152" href="summer_event_view.jsp" onFocus="this.blur()">
</map></body>
<script language='JavaScript'>
<!--  
 document.write('<st'+'yle>');
 document.write('td {font-size:12px; font-family:굴림; text-decoration:none; }');
 document.write('A:link,A:active,A:visited{text-decoration:none;font-size:12PX;color:#333333;}');
 document.write('A:hover {text-decoration:none; color:ff9900}');
 document.write('font { font-size: 9pt; }');
 document.write('.cnj_input {background-color:rgb(240,240,240);border-width:1pt; height:16pt;cursor:hand;}');
 document.write('.cnj_input2 {border-width:1; border-color:rgb(204,204,204); border-style:solid;cursor:hand;}');
 document.write('.cnj_input3 { border-width:1; border-style:solid; border-color:#000000; color:#0084D4; background-color:white;cursor:hand;}');
 document.write('.cnj_input4 { scrollbar-face-color: #FFCC33;scrollbar-shadow-color:  #ffffff;scrollbar-highlight-color: #F3f3f3;scrollbar-3dlight-color: #ffffff;scrollbar-darkshadow-color: #F3f3f3;scrollbar-track-color: #ffffff;scrollbar-arrow-color: #f9f9f9;cursor:hand; }');
 document.write('</st'+'yle>');

 var cnj_obj = document.all.Layer0.style;
 var wx=0, wy=0;
 function cnj_move() {
	// wx 와 wy 뒤에 - 이면 마우스포인터의 툴팁내용이 상단에 위치
	// wx 와 wy 뒤에 + 이면 마우스포인터의 툴팁내용이 하단에 위치
	cnj_obj.pixelLeft = wx-30; // 마우스포인터와 레이어와의 가로 간격
	cnj_obj.pixelTop  = wy-170; // 마우스포인터와 레이어와의 세로 간격
	cnj_obj.pixelLeft += document.body.scrollLeft;
	cnj_obj.pixelTop  += document.body.scrollTop;
 }
 function cnj_show(lyName) {
    cnj_obj = lyName;
	if(cnj_obj.visibility != "hidden")
	return;
	cnj_move();
	cnj_obj.visibility = 'visible';
 }
 function cnj_hide(lyName) {
	cnj_obj = lyName;
	cnj_obj.visibility = 'hidden';
 }
 function dragIt(evt) {
	wx = event.x;
	wy = event.y;
	if(cnj_obj.visibility == "visible")
	cnj_move();
 }
 document.onmousemove = dragIt;
</script> 
</html>
