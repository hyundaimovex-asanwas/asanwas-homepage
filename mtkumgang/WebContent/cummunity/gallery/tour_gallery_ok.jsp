<%--
  - 작성자: 임형수
  - 일자: 2006.05.26
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>자주 묻는 질문 처리
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>


<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
//request parameters
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int comment_seq = Util.parseInt(request.getParameter("comment_seq"), 0);

String title		= clearXSS(ParamUtil.getReqParameter(request.getParameter("title")),avatag );
String content		= clearXSS(ParamUtil.getReqParameter(request.getParameter("content")),avatag );
content				= content.replaceAll("'", "\"");
String cmd			= clearXSS(ParamUtil.getReqParameter(request.getParameter("cmd")),avatag );
String part			= clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
String keyword		= clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag );
String type_code	= clearXSS(ParamUtil.getReqParameter(request.getParameter("type_code")),avatag );

String realFileList			= ParamUtil.getReqParameter(request.getParameter("realFileList"));
String virtualFileList	= ParamUtil.getReqParameter(request.getParameter("virtualFileList"));
String returnUri = Util.getString(request.getParameter("returnUri"),"tour_gallery.jsp");
returnUri = java.net.URLDecoder.decode(returnUri);
returnUri = returnUri+"&cmd="+cmd;

String user_id		= session_id;
String user_name		= session_name;

System.out.println("returnUri=="+returnUri);
//변수 선언
String board_type	= "04";
CommonBoard commonDao = null;

//파일저장위치
String saveDir= Config.getInstance().getProperty("imjkmd","memGalleryLink");
String fileRootDir = saveDir+Util.getToMonth()+"/";


//DAO
TourGalleryBoard dao = new TourGalleryBoard();
//DTO
Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setBoard_type(board_type);
bean.setTitle(title);
bean.setContent(content);
bean.setUser_id(user_id);
bean.setUser_name(user_name);
bean.setType_code(type_code);


//DTO
Tbrd_comment_de_bean  commentBean = new Tbrd_comment_de_bean();
commentBean.setBoard_seq(board_seq);
commentBean.setContent(content);
commentBean.setUser_id(user_id);
commentBean.setUser_name(user_name);

int result = 0;
StringTokenizer token = null;
String [] arrReal = null;
String [] arrVirt = null;
Map map = null;



if(cmd.equals("insert")){
	// 파일 정보 SET
	token = new StringTokenizer(realFileList, "|");
	arrReal = new String[token.countTokens()];
	int i = 0;
	while(token.hasMoreTokens()){
	   arrReal[i] =  token.nextToken();
	   i++;
	}
	
	token = new StringTokenizer(virtualFileList, "|");
	arrVirt = new String[token.countTokens()];
	i = 0;
	while(token.hasMoreTokens()){
	   arrVirt[i] =  token.nextToken();
	   i++;
	}
	
	if(arrVirt.length > 0 && arrVirt.length == arrReal.length){
		map = new HashMap();
		for(int j=0; j<arrVirt.length; j++){
			map.put("real_name"+j, fileRootDir+arrReal[j]);
	        map.put("virtual_name"+j, fileRootDir+arrVirt[j]);
		}
	}
    
	//INSERT
	result = dao.insert(bean,map);
}else if(cmd.equals("edit")){
	// 파일 정보 SET
	token = new StringTokenizer(realFileList, "|");
	arrReal = new String[token.countTokens()];
	int i = 0;
	while(token.hasMoreTokens()){
	   arrReal[i] =  token.nextToken();
	   i++;
	}
	
	token = new StringTokenizer(virtualFileList, "|");
	arrVirt = new String[token.countTokens()];
	i = 0;
	while(token.hasMoreTokens()){
	   arrVirt[i] =  token.nextToken();
	   i++;
	}
	
	if(arrVirt.length > 0 && arrVirt.length == arrReal.length){
		map = new HashMap();
	
		for(int j=0; j<arrVirt.length; j++){
			map.put("real_name"+j, fileRootDir+arrReal[j]);
			map.put("virtual_name"+j, fileRootDir+arrVirt[j]);
		}
	}

	//UPDATE
	result = dao.update(bean,map);
}else if(cmd.equals("del")){
	result = dao.deleteComplete(board_seq);

}else if(cmd.equals("recomm")){
	commonDao = new CommonBoard();
	//out.println("------"+commonDao.doneRecomm(session_id,board_seq));
	//이미 추천을 했을 경우
	if(commonDao.doneRecomm(session_id,board_seq)){
	 %>
		 <SCRIPT LANGUAGE="JavaScript">
		<!--
		  alert('<%=user_id%>님은 이미 추천하셨습니다. 추천은 1회만 가능합니다.');
		  history.back();
		//-->
		</SCRIPT>
	 <%
		//response.sendRedirect(returnUri);
	}else{
	    result = commonDao.updateRecomm(session_id,board_seq);
	 %>
		 <SCRIPT LANGUAGE="JavaScript">
		<!--
		  alert('정상적으로 추천되었습니다. 추천은 1회만 가능합니다.');
		  location.href="../../"+"<%=returnUri%>";
		//-->
		</SCRIPT>
	 <%
		

	}




}else if(cmd.equals("insertComment")){
  result = dao.insertComment(commentBean);

  out.println("result="+result);
}else if(cmd.equals("deleteComment")){
	 result = dao.deleteCommentComplete(comment_seq);
}


//out.println("result : " + result);
if(result>0){

	if(cmd.equals("deleteComment") || cmd.equals("insertComment")){
	%>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			alert('성공적으로 처리 되었습니다.');
			location.href="tour_gallery_comment.jsp";
			
			parent.resize_frame1();
			//-->
			</SCRIPT>
	<%}else{%>
			<SCRIPT LANGUAGE="JavaScript">
			<!--
			alert('성공적으로 처리 되었습니다.');
			location.href="tour_gallery.jsp";
			
			//-->
			</SCRIPT>
<%
	}
}else{
%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	  alert('처리에 실패하였습니다. 잠시후 다시 사용하여 주십시요.');
	history.back();
	//-->
	</SCRIPT>
<%
}		
%>