<%--
  - 작성자: 이소연
  - 일자: 2006.07.26
  - 저작권 표시: IMJ Korea
  - 설명: 공지사항 > 상세보기 
  - 에디터 추가 (2007.07.28)
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.KsTourPrevent"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&part="+part+"&keyword="+keyword;

//변수 선언
String cmd			= "";
String board_type	= "";
String title		= "";
String content		= "";
String user_id		= "";
String user_name	= "";
String regdate		= "";
int read_num		= 0;
String use_yn		= "";
String type_code	= "";
String type_name	= "";
String virtual_name	= "";
String real_name	= "";
int recomm_num		= 0;

if (board_seq > 0){
	//DAO
	KsTourPrevent dao = new KsTourPrevent();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content						= bean[0].getContent();
	content						= content.replaceAll("\"", "'");
	user_id						= bean[0].getUser_id();
	regdate						= bean[0].getReg_date_String();
	read_num					= bean[0].getRead_num();
	user_name					= bean[0].getUser_name();
	virtual_name				= bean[0].getVirtual_name();
	real_name					= bean[0].getReal_name();
    recomm_num					= bean[0].getRecomm_num();

	

	cmd = "edit";
}else{
	cmd = "insert";
	regdate = Util.getDate();
}


String saveDirName 		=  Config.getInstance().getProperty("imjkmd","eventUpload");

%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function chk(){
	var obj = document.mainForm;

	if(obj.title.value == ""){
		alert("제목을 입력하세요.");
		obj.title.focus();
		return false;
	}

	var body1 = document.getElementById("editBox1").html;
	
	var len1=0, j1;
          for (i=0, j1=body1.length;i<j1;i++, len1++){
	    if((body1.charCodeAt(i)<0)||(body1.charCodeAt(i)>127)){ 
		len1 = len1+1;
	    }
          }
  
  if(len1 <= 0){
		alert ("내용을 입력해주세요");
		document.all.editBox1.focus();
		return false;
	}else{
		document.getElementById("content").value = body1;
	}

	return true;
}

function openDel(){
	var obj = document.mainForm;
	if(confirm("정말 삭제하시겠습니까?")){
		obj.cmd.value = "del";
		obj.action = "kstour_prevent_ok.jsp";
		obj.submit();
	}else{
		return;
	}
}

var blnBodyLoaded = false;
var blnEditorLoaded = false;
    
function init(){
	//초기 에디터의 적용해줌
	bodyHtml1 = document.getElementById("content").value;
	
	
	if (bodyHtml1 != "") {
		document.getElementById("editBox1").html = bodyHtml1;
	}
}

//-->
</SCRIPT>
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
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/tour/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6" align="right">
          <!--// IMJK START -->
          <TABLE cellspacing=0 cellpadding=0 width=650>
                <TR>
                  <TD>
          	      <TABLE cellspacing=0 cellpadding=0 width=650>
          	       <!-- loc -->
          	         <TR valign=top>
          		        <TD height=50 align=right style='padding-top: 10'>
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>고객센터</A> > 
          		        <span class=locon>지난이벤트보기(개성)</A> </span></TD>
          	          </TR>
          	       <!-- //loc -->
          	       </TABLE>
                  </TD>
               </TR>
          	<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>지난이벤트보기(개성)</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                			<FORM METHOD=POST name="mainForm" ACTION="kstour_prevent_ok.jsp" onsubmit="return chk();">
							<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
							<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10>
                					<input type=text name=title style=width:450; value="<%=title%>">
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                                                              <td class='tdcolor th' align=center valign=top style=padding-top:7;>내용</td>
                                                              <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=150 valign=top>
                                                               <OBJECT id="editBox1" style="LEFT: 0px; TOP: 0px" 
						 type=text/x-scriptlet height=340 width=580
						 data="<%=rootServer%>asanway/edit_tool2/editer.jsp?saveDirName=<%=saveDirName%>" VIEWASTEXT>
						</OBJECT>
                                                                <SCRIPT event="onscriptletevent(name, eventData)" for="editBox1">
                            	                                 if (name == "onafterload") {
                            		                         blnEditorLoaded = true;
                            		                         blnBodyLoaded = true;
                            		                         window.setTimeout(init, 500);
                            	                                 }
                                                                </SCRIPT>
						    <input type=hidden value="<%=content%>" name="content" id="content">
                                 </td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  <% if (board_seq > 0){ %>
								  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=submit value=수정 class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 onclick="location.href='javascript:openDel()'" class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <% }else{ %>
                                  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=submit value=등록 class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								 
								  <% } %>
                                  
                                  
                                  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='kstour_prevent.jsp?page=<%=requestedPage%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>         					
                                 </td>
                				</tr>
                			</table>
                			</FORM>
                
                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                		</td>
                	</tr>
                	</table>
                </TD>
                <!-- //main -->
              </TR>
           </TABLE>  
          <!--// IMJK END -->
          </td>
        </tr>
      </table>
    </td>
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
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
