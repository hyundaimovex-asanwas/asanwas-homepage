<%-- 
  - 작성자: 임형수
  - 일자: 2006.06.07
  - 수정자 : 이소연 
  - 일자 : 2006.07
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>묻고답하기
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>


<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%

//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
String keyword    	= clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag );
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

String pageNum = "2";
String McNum = "6";
String sub = "2";

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
	content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	user_name = bean[0].getUser_name();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	use_yn					= bean[0].getUse_yn();
	open_yn					= bean[0].getOpen_yn();
	password				= bean[0].getPassword();
    email	                = bean[0].getEmail();
	tel	                    = bean[0].getTel();

	cmd = "edit";
	
}else{
	
	user_id = session_id;
    user_name = session_name;
	cmd = "insert";
	
}

//회원 체크
if(!session_id.equals("")){
	isMember = true;
}


//비회원이 등록한 글일때 삭제 버튼 보임
// 수정 - 신규등록일 경우 해당 안됨

if(board_seq > 0 && session_id.equals("")){
	deleteYn = true;
    eidtYn = true;
}

//자기가 쓴 글만 삭제 버튼 보임
// 수정 - 신규등록일 경우 해당 안됨, 로그인 여부 체크 추가
if(board_seq > 0 && session_id != "" && user_id.equals(session_id)){
	deleteYn = true;
	eidtYn = true;
}

//추가 - 로그인한 회원 이메일 및 연락처 가져오기
if(!session_email.equals("")){
   email = session_email;
}
if(!session_tel.equals("")){
   tel = session_tel;
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

%>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	f = document.mainForm;

	if (!f.privacy_chk[0].checked == true){
	    alert("개인정보취급방침에 동의해 주십시오.");
	    return;
	}
    
    if(f.qnaTitle.value==""){
		alert ("제목을 입력 하세요");
		f.qnaTitle.focus();
		return;
	}
	
	if(f.writer.value==""){
		alert ("작성자을 입력 하세요");
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
    
    
    //추가
	if(f.email != null){
		if(f.email.value == "" ){
	      alert ("이메일을 입력 하세요");
		  f.email.focus();
		  return;
	   }
	}
    

	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("비밀번호를 입력 하세요");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("비밀번호확인을 입력 하세요");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("비밀번호가 일치하지 않습니다. 정확하게 입력 하세요");
		  f.password.value="";
		  f.passwordRe.value="";
		  f.password.focus();
		  return;
	   }
	}
  
    if(f.content.value==""){
		alert ("내용을 입력 하세요");
		f.content.focus();
		return;
	}




   f.submit();


}


function del(){

	f = document.mainForm;
	if(f.password != null){
		if(f.password.value == "" ){
	      alert ("비밀번호를 입력 하세요");
		  f.password.focus();
		  return;
	   }

	   if(f.passwordRe.value == "" ){
	      alert ("비밀번호확인을 입력 하세요");
		  f.passwordRe.focus();
		  return;
	   }


	   if(f.password.value !=f.passwordRe.value ){
	      alert ("비밀번호가 일치하지 않습니다. 정확하게 입력 하세요");
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

 var special = ' ~!#$%^&*()=+|\\{}[];:"\'<>,?\/';//특수문자중에 '@' 와 ' . ' 은 생략했음.
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

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174" style="border:0 solid black">
			<!--  left menu flash -->
                        <%@ include file="../../include/center/tour_center_left.jsp" %>
                        </td>
			<td>
<FORM METHOD=POST name="mainForm" ACTION="https://www.mtkumgang.com/center/qna/qna_ok.jsp" >
<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="part" value="<%=part%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<INPUT TYPE="hidden" name="position" value="<%=position%>">
<INPUT TYPE="hidden" name="user_id" value="<%=user_id%>">
<INPUT TYPE="hidden" name="user_name" value="<%=user_name%>">

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				  <tr><td height="11"></td></tr>
				  <tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus02.jpg"></td></tr>
				  <tr>
					<td valign="top">
						<!-- / write table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="72"><col width="1"><col width="284" class="lpad_10">
						<col width="96"><col width="217" class="lpad_10">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write01.gif"><!-- 제목 --></td>
							<td colspan="3"><input type="text"  name=qnaTitle  style="width:597px;" value="<%=title%>"></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_view02.gif"><!-- 작성자 --></td>
							<td>
							<%if(isMember){%>
							<input type="text" name=writer  style="width:273px;" value="<%=user_name%>(<%=user_id%>)" readonly>
         					<%}else{%>
							   <!--비회원-->
							   <%if(board_seq>0){%>
							        <input type=text name=writer style="width:273px;" value="<%=user_name%>" readonly ></td>
							   <%}else{%>
							        <input type=text name=writer style="width:273px;" value=""></td>
                               <%}%>
							<%}%>
							</td>
							<td><img src="<%=imageServer%>/tour_img/txt_write06.gif"><!-- 연락처 --></td>
							<td>					
							<input type="text" name=tel01 style="width:49px;" value="<%=tel01%>" > - 
							<input type="text" name=tel02 style="width:65px;" value="<%=tel02%>" > - 
							<input type="text" name=tel03 style="width:65px;" value="<%=tel03%>" >
							
							</td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write07.gif"><!-- 이메일 --></td>
							<td colspan="3">
							<input type="text" name=email  style="width:273px;" value="<%=email%>">
							<input type=hidden name=open_yn value="1" class="noborder">
							</td>
							<!--td><img src="<%=imageServer%>/tour_img/txt_write08.gif"></td>
							<td>							
                                                           <%if(open_yn.equals("1")){%>checked<%}%>><strong>공개</strong> &nbsp;<input type=radio name=open_yn class="noborder" value="0" <%if(open_yn.equals("0")){%>checked<%}%>><strong>비공개</strong>
                                                        </td-->
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						
						
						<%if(board_seq>0){%>
							<!--비밀번호가 걸려 있을때 보임 -->
							<%if(!password.equals("")){%>
							<tr height=28>
								<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write09.gif"><!-- 비밀번호 --></td>
								<td class=lpad10 ><input type=password name=password style="width:273px;" value=""></td>
								<td><img src="<%=imageServer%>/tour_img/txt_write10.gif"><!-- 비밀번호확인 --></td>
								<td class=lpad10 ><input type=password name=passwordRe style="width:207px;" value=""></td>
							</tr>
							<%}%>
						<!-- 최초 등록시 -->
						<%}else{%>
							<!--비회원 글쓸때 -->
							<%if( session_id == null || session_id.trim().equals("") ){%>
							<tr height=28>
								<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write09.gif"><!-- 비밀번호 --></td>
								<td class=lpad10 ><input type=password name=password style="width:273px;" value=""></td>
								<td><img src="<%=imageServer%>/tour_img/txt_write10.gif"><!-- 비밀번호확인 --></td>
								<td class=lpad10 ><input type=password name=passwordRe style="width:207px;" value=""></td>
							</tr>
							<%}%>

						<%}%>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr><td height="6" colspan="5"></td></tr>
						<tr>
							<td height="218" align="right"><img src="<%=imageServer%>/tour_img/txt_write11.gif" style="margin-right:14px;"><!-- 문의내용확인 --></td>
							<td class="bg_dgray"></td>
							<td colspan="3">
							<textarea name=content style="width:597px;height:218px;"><%=content%></textarea></td>
						</tr>
						<tr><td height="6" colspan="5"></td></tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						</table>
						<!-- write table / -->

						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="13"></td></tr>
						<tr>
							<td align="right">
							
								 <%if(board_seq>0){%>
								     <a href="javascript:chk()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_modify.gif" class="btn"></a><!-- 수정하기 -->
								 <%}else{%>
                                     <a href="javascript:chk()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_question.gif" class="btn"></a><!-- 질문하기 -->
                                 <%}%>
                                 
								   <%
								    if(deleteYn){%>
								    <a href="javascript:del()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_delete.gif" class="btn"></a><!-- 삭제하기 -->
								   <%}%>
								   <a href="qna_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_cus_listview.gif" class="btn"></a><!-- 목록보기 -->
								   
							</td>
						</tr>
						</table>
						<!-- button/ -->
					</td>
				  </tr>
				  <tr><td height="11"></td></tr>
				  <tr><%//개인정보 수집 및 이용 동의%>
					<td height="11">



						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top">　<font color="white">개인정보 수집 및 이용에 대한 안내</font></td>
							<td class="bg_dblue" align=right><a href="/include/privacy.jsp"><font color="yellow"><b>개인정보취급방침 바로가기</b></font></a>　</td>
						</tr>
						<tr>
							<td style="padding:7 2 7 7px;" colspan=2>
<textarea id='xmlarea' name='xmlarea' rows='5' style='width : 100%;font-size : 12px;'>
■ 개인정보의 수집 및 이용목적

회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다..

 ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산
구매 및 요금 결제
 ο 회원 관리
회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 불만처리 등 민원처리 , 고지사항 전달
 ο 마케팅 및 광고에 활용
이벤트 등 광고성 정보 전달 , 인구통계학적 특성에 따른 서비스 제공 및 광고 게재 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
 ο 기타
관계기관에 관광객정보제공



■ 수집하는 개인정보 항목

회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.

ο 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 주소 , 휴대전화번호 , 이메일 , 회사명 , 직책 , 주민등록번호 , 신용카드 정보 , 쿠키 , 접속 IP 정보 , 결제기록
ο 개인정보 수집방법 : 홈페이지(회원가입, 게시판, 관광예약) , 전화/팩스를 통한 회원가입 , 경품 행사 응모 


■ 개인정보의 보유 및 이용기간

회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.
</textarea>
							</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan=2></td></tr>
						<tr>
						 <td height="40" colspan=2 align=center>
							<input type="radio" name="privacy_chk" value="Y" class="noborder">동의
							&nbsp;&nbsp;&nbsp;
							<input type="radio" name="privacy_chk" value="N" class="noborder">동의하지 않습니다.
                         </td>
						</tr>
						</table>



					</td>
				  </tr>
				  <tr><td height="11"></td></tr>
				  <tr>
					<td><img src="<%=imageServer%>/tour_img/community/bottom_080307.gif"></td>
				  </tr>
				  <tr><td height="11"></td></tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
</FORM>
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->       
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>