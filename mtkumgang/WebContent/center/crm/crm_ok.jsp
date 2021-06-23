<%--
  - 작성자: 임형수
  - 일자: 2006.06.07
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>묻고답하기
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.board.dao.CrmBoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>

<%
//request parameters
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

String title		= clearXSS( ParamUtil.getReqParameter(request.getParameter("qnaTitle")),avatag );
String content		= clearXSS( ParamUtil.getReqParameter(request.getParameter("content")),avatag );
String reply_content= clearXSS( ParamUtil.getReqParameter(request.getParameter("reply_content")),avatag );
content				= content.replaceAll("'", "\"");
reply_content		= reply_content.replaceAll("'", "\"");
String open_yn		= clearXSS( ParamUtil.getReqParameter(request.getParameter("open_yn")),avatag );
String cmd			= clearXSS( ParamUtil.getReqParameter(request.getParameter("cmd")),avatag );
String part			= clearXSS( ParamUtil.getReqParameter(request.getParameter("part")),avatag );
String keyword		= clearXSS( ParamUtil.getReqParameter(request.getParameter("keyword")),avatag );
String type_code	= clearXSS( ParamUtil.getReqParameter(request.getParameter("type_code")),avatag );
String user_id		= clearXSS( ParamUtil.getReqParameter(request.getParameter("user_id")),avatag );
String user_name	= clearXSS( ParamUtil.getReqParameter(request.getParameter("user_name")),avatag );
String writer		= clearXSS( ParamUtil.getReqParameter(request.getParameter("writer")),avatag );
String email		= clearXSS( ParamUtil.getReqParameter(request.getParameter("email")),avatag );
String tel01		= clearXSS( ParamUtil.getReqParameter(request.getParameter("tel01")),avatag );
String tel02		= clearXSS( ParamUtil.getReqParameter(request.getParameter("tel02")),avatag );
String tel03		= clearXSS( ParamUtil.getReqParameter(request.getParameter("tel03")),avatag );
String password		= clearXSS( ParamUtil.getReqParameter(request.getParameter("password")),avatag );
String tel =  tel01+"-"+tel02+"-"+tel03;

//비회원일경우
if(session_id.equals("")){
   user_name = writer;
}

//변수 선언
String board_type	= "14";

//DAO
CrmBoard dao = new CrmBoard();
CommonBoard commonDao = new CommonBoard();
//DTO
Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setBoard_type(board_type);
bean.setTitle(title);
bean.setContent(content);
bean.setReply_content(reply_content);
bean.setUser_id(user_id);
bean.setUser_name(user_name);
bean.setOpen_yn(open_yn);
bean.setTel(tel);
bean.setEmail(email);
bean.setPassword("book$sori");	 //강제로 비번설정. 입력할 때 비번을 적는게 아니다. 작성자는 자기것만 볼 수 있음
bean.setType_code(type_code);



int result = 0;

if(cmd.equals("insert")){
	  result = dao.insert(bean);
	
}else if(cmd.equals("edit")){
	//회원 수정
	if(password.equals("")){
	    result = dao.update(bean);
	}else{
	    //비회원글 수정일 경우 패스워드 일치 하는지 채크
	    if(commonDao.getPasswordYn(board_seq, password)){
			result = dao.update(bean);
		}else{
			//비밀번호 불일치
           %>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			alert('비밀번호가 일치 하지 않습니다.');
		    history.back();
			//-->
			</SCRIPT>
           <%
        }
	}
}else if(cmd.equals("del")){

	  //비회원글 수정일 경우 패스워드 일치 하는지 채크
	    if(commonDao.getPasswordYn(board_seq, password)){
				result = dao.deleteComplete(board_seq);
		}else{
			//비밀번호 불일치
           %>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			alert('비밀번호가 일치 하지 않습니다.');
		    history.back();
			//-->
			</SCRIPT>
           <%
        }
}


//out.println("result : " + result);
if(result>0){
%>

	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert('성공적으로 처리 되었습니다.');
	location.href="crm_list.jsp";
	
	//-->
	</SCRIPT>
<%
}else{
%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert('성공적으로 처리 되었습니다.');
	location.href="crm_list.jsp";
	
	//-->
	</SCRIPT>
<%
}		
%>