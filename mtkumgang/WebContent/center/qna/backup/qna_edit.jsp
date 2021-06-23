<%--
  - 작성자: 임형수
  - 일자: 2006.06.07
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>묻고답하기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%

//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
int position = Util.parseInt(request.getParameter("position"), 1);
// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;
//페이지 페라메터
String page_str = "&page="+requestedPage+"&position="+position;


//변수 선언
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		= "";
String type_code  = "";
String type_name = "";
String use_yn			= "";
String user_id		= "";
String user_name =""; 
String regdate = "";
String password = "";
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "06";
String open_yn = "1";
String tel01 = "";
String tel02 = "";
String tel03 = "";
String email =""; 
String tel ="";
String cmd ="";
boolean isMember = false;
boolean deleteYn = false;
boolean eidtYn = false;


//DAO
QnABoard dao = new QnABoard();


if(board_seq>0){
	
	
//DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content					= bean[0].getContent();
	//content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	user_name = bean[0].getUser_name();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	use_yn					= bean[0].getUse_yn();
	open_yn					= bean[0].getOpen_yn();
	password					= bean[0].getPassword();
    email	= bean[0].getEmail();
	tel	= bean[0].getTel();

	cmd = "edit";
}else{
	user_id = session_id;
    user_name = session_name;
	cmd = "insert";
}

//전화번호 분리하기
if(!tel.equals("")){
    String[] telArray = Util.getItemArray(tel,'-');

	if(telArray != null && telArray.length == 3){
	   tel01 = telArray[0];
	   tel02 = telArray[1];
	   tel03 = telArray[2];
	}  
}

//회원 체크
if(!session_id.equals("")){
	isMember = true;
}


//비회원이 등록한 글일때 삭제 버튼 보임
if(session_id.equals("")){
	deleteYn = true;
    eidtYn = true;
}


//자기가 쓴 글만 삭제 버튼 보임
if(user_id.equals(session_id)){
	deleteYn = true;
	eidtYn = true;
}




//out.println("pageCount: "+pageCount);
//out.println("dataNum: "+dataNum);

%>


<html>
<head>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	


	f = document.mainForm;
    
    if(f.qnaTitle.value==""){
		alert ("제목을 입력해주세요");
		f.qnaTitle.focus();
		return;
	}

	//alert("title=|"+f.title.value+"|");
	
	if(f.writer.value==""){
		alert ("작성자을 입력해주세요");
		f.writer.focus();
		return;
	}

    var tel = f.tel01.value +f.tel02.value+f.tel03.value;

    if(tel !=""){
		if(valid_tel(f.tel01, f.tel02, f.tel03)){
		}else{
			return;
		}
	}


	if(f.email.value!=""){
        if(valid_email(f.email)){
		}else{
			return;
		}
	}


	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("패스워드를 입력하여 주십시요");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("패스워드확인을 입력하여 주십시요");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("패스워드가 일치하지 않습니다. 정확하게 입력하여 주십시요");
		  f.password.value="";
		  f.passwordRe.value="";
		  f.password.focus();
		  return;
	   }
	}
  
    if(f.content.value==""){
		alert ("내용을 입력해주세요");
		f.content.focus();
		return;
	}




   f.submit();


}


function del(){

	f = document.mainForm;

	f = document.mainForm;
	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("패스워드를 입력하여 주십시요");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("패스워드확인을 입력하여 주십시요");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("패스워드가 일치하지 않습니다. 정확하게 입력하여 주십시요");
		  f.password.value="";
		  f.passwordRe.value="";
		  f.password.focus();
		  return;
	   }
	}

	if(confirm("게시물을 삭제하시겠습니까?")){
		f.cmd.value = "del";
	    f.submit();
	}else{
		return;
	}
}


function valid_email(ele) { 
  /**********************************************************************************
 *이메일 체크하는 자바 스크립트
 1.이메일을 입력했는지 체크한다.
 2.이메일에 '@' 와 '.'이 있는지 체크한다.
 3.이메일에 한글과 특수문자가 있는지 체크한다.
 ***********************************************************************************/
 
 /*
 if(ele.value=="")
 {
  alert("이메일을 입력하세요");
  ele.focus();
  return false;
 }
*/

 if(((ele.value.indexOf('@')) <= 0) && (ele.value.indexOf('.') <= 0) )
 {//@와 . 이 존재 하지 않는다면 alert창 띄우기
  alert("정상적인 이메일이 아닙니다.");
  ele.value="";
  ele.focus();
  return false;
 }

 var special = ' ~!#$%^&*()-_=+|\\{}[];:"\'<>,?\/';//특수문자중에 '@' 와 ' . ' 은 생략했음.
 for(var i = 0 ; i < ele.value.length; i++)
 {//한글과 특수문자를 쓰지 못하게 하는 구문

     var email_check = ele.value.charAt(i);//이메일 입력폼에 값을 하나씩 가져온다.

      if(((email_check >= "ㅏ") && (email_check <= "히")) || ((email_check >="ㄱ") && (email_check <="ㅎ")))
      {//모든 한글을 확인하는 구문 
             alert("이메일에는 한글이 안됩니다.");
             ele.value="";
             ele.focus();
             return false;
      }
	  for(var j=0; j<special.length;j++)
	  {//특수문자를 확인하는 구문.미리 등록된 특수문자를 하나씩 가져온다.
		   if(email_check == special.charAt(j))
		   {//이메일 입력폼의 문자를 하나씩 가져와서 미리 등록된 특수문자를 비교하여 같다면 특수문자임. 
			alert("이메일에는 특수 문자가 안됩니다.");
			ele.value="";
			ele.focus();
			return false;
		   }
	  }
  
 }

  return true;
} 


function valid_tel(ele01,ele02,ele03) { 
/**********************************************************************************
 *전화번호 체크하는 자바 스크립트
 1.전화번호를 입력했는지 체크한다.
 2.전화번호의 자리수를 체크한다.
 3.전화번호가 숫자인지 체크한다.
 ***********************************************************************************/
 if(ele01.value=="")
 {
  alert("전화번호를 입력하세요");
  ele01.focus();
  return false;
 }

 if(ele01.value.length < 2 )
 {//첫번째 전화번호의 자리수가 2이하이면 alert창 띄우기
        alert("전화번호 자리수가 틀립니다.");
  ele01.value.length="";
  ele01.value="";
  ele01.focus();
  return false;
 }

  for(var i=0;i<ele01.value.length;i++)
 {//첫번째 전화번호에는 숫자만 집어넣어야 한다.그렇지 않으면 alert창 띄우기.
    var ch1 = ele01.value.substring(i,i+1);
    if (ch1<'0' || ch1>'9') 
	{
		alert("숫자를 입력하세요");
		ele01.value="";
		ele01.focus();
		return false;
	}
 }

 
 if(ele02.value=="")
 {
  alert("전화번호를 입력하세요");
  ele02.focus();
  return false;
 }


  if(ele02.value.length < 3 )
 {//두번째 전화번호의 자리수가 2이하이면 alert창 띄우기
        alert("전화번호 자리수가 틀립니다.");
  ele02.value.length="";
  ele02.value="";
  ele02.focus();
  return false;
 }

  for(var i=0;i<ele02.value.length;i++)
 {//두번째 전화번호에는 숫자만 집어넣어야 한다.그렇지 않으면 alert창 띄우기.
    var ch1 = ele02.value.substring(i,i+1);
    if (ch1<'0' || ch1>'9') 
	{
		alert("숫자를 입력하세요");
		ele02.value="";
		ele02.focus();
		return false;
	}
 }



 if(ele03.value=="")
 {
  alert("전화번호를 입력하세요");
  ele03.focus();
  return false;
 }

 if(ele03.value.length < 3 )
 {//세번째 전화번호의 자리수가 2이하이면 alert창 띄우기
        alert("전화번호 자리수가 틀립니다.");
  ele03.value.length="";
  ele03.value="";
  ele03.focus();
  return false;
 }

 for(var i=0;i<ele03.value.length;i++)
 {//세번째 전화번호에는 숫자만 집어넣어야 한다.그렇지 않으면 alert창 띄우기.
      var ch1 = ele03.value.substring(i,i+1);
      if (ch1<'0' || ch1>'9') 
	  {
	   alert("숫자를 입력하세요");
	   ele03.value="";
	   ele03.focus();
	   return false;
	  }
  }
  
  return true;

}


//-->
</SCRIPT>
</head>
<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                			 <td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>묻고답하기</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
					<FORM METHOD=POST name="mainForm" ACTION="qna_ok.jsp" >
					<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="part" value="<%=part%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
					<INPUT TYPE="hidden" name="position" value="<%=position%>">
					<INPUT TYPE="hidden" name="user_id" value="<%=user_id%>">
					<INPUT TYPE="hidden" name="user_name" value="<%=user_name%>">
<%="session_id==|"+session_id+"|"%>
         			<table width=100% border=0 cellspacing=0 cellpadding=0>
         				<col width=100>
         				<tr><td colspan=6 height=2 class=linec1></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>제목</td>
         					<td class=lpad10 colspan=7>
         					<input type=text name=qnaTitle style=width:300; value="<%=title%>">
         					</td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>
         				<tr height=28>
         					<td class='tdcolor th' align=center>작성자</td>
         					<td class=lpad10>
							<%if(isMember){%>
							<input type=text name=writer style=width:100; value="<%=user_name%>(<%=user_id%>)" readonly></td>
         					<%}else{%>
							   <!--비회원-->
							   <%if(board_seq>0){%>
							        <input type=text name=writer style=width:100; value="<%=user_name%>" readonly ></td>
							   <%}else{%>
							        <input type=text name=writer style=width:100; value=""></td>
                               <%}%>
							<%}%>
							<td class='tdcolor th' align=center>연락처</td>
         					<td class=lpad10>
         					<input type=text name=tel01 style=width:30; value="<%=tel01%>" >-
         					<input type=text name=tel02 style=width:30; value="<%=tel02%>" >-
         					<input type=text name=tel03 style=width:30; value="<%=tel03%>" >
         					</td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>    
         				<tr height=28>
         					<td class='tdcolor th' align=center>이메일</td>
         					<td class=lpad10><input type=text name=email style=width:100; value="<%=email%>"></td>
         					<td class='tdcolor th' align=center>공개/비공개</td>
         					<td class=lpad10><input type=radio name=open_yn value="1" <%if(open_yn.equals("1")){%>checked<%}%>>공개 &nbsp;<input type=radio name=open_yn value="0" <%if(open_yn.equals("0")){%>checked<%}%>>비공개</td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>
         				<!-- 수정시 -->
						<%if(board_seq>0){%>
							<!--비밀번호가 걸려 있을때 보임 -->
							<%if(!password.equals("")){%>
							<tr height=28>
								<td class='tdcolor th' align=center>비밀번호</td>
								<td class=lpad10 ><input type=password name=password style=width:100; value=""></td>
								<td class='tdcolor th' align=center>비밀번호 확인</td>
								<td class=lpad10 ><input type=password name=passwordRe style=width:100; value=""></td>
							</tr>
							<%}%>
						<!-- 최초 등록시 -->
						<%}else{%>
							<!--비회원 글쓸때 -->
							<%if( session_id == null || session_id.trim().equals("") ){%>
							<tr height=28>
								<td class='tdcolor th' align=center>비밀번호</td>
								<td class=lpad10 ><input type=password name=password style=width:100; value=""></td>
								<td class='tdcolor th' align=center>비밀번호 확인</td>
								<td class=lpad10 ><input type=password name=passwordRe style=width:100; value=""></td>
							</tr>
							<%}%>

						<%}%>
         				<tr><td colspan=6 height=1 class=linec0></td></tr>         				
         				<tr height=28>
                          <td class='tdcolor th' align=center valign=top style=padding-top:7;>문의내용</td>
                          <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                             <textarea name=content cols=60 rows=10><%=content%></textarea>
                          </td>
         				</tr>
         				<tr><td colspan=6 height=1 class=linec1></td></tr>
         				</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								 <%if(board_seq>0){%>
								 <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=수정하기 class=btn onclick="javascript:chk()"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
								 <%}else{%>
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=질문하기 class=btn onclick="javascript:chk()"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
                                 <%}%>
                                 
								   <% if(deleteYn){%>
										 <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=삭제하기  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								   <%}%>
								  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=목록보기 class=btn onclick="location.href='qna_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
                                 </td>
                				</tr>
                			</table>
                
                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                		</td>
                	</tr>
					</FORM>
                	</table>
                </TD>
                <!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>

