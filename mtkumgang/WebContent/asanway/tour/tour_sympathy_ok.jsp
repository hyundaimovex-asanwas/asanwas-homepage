<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.upload.UploadFileImpl"%>
<%@ page import="kr.co.imjk.upload.UploadFile"%>
<%@ page import="kr.co.imjk.util.*"%>

<% 
String saveDir 		=  Config.getInstance().getProperty("imjkmd","agreeGalleryUpload");


int maxSize = 5*1024*1024;

//첨부파일 용량 체크
if(request.getContentLength() > maxSize ){

	out.println("<script language=\"javascript\">");
	out.println("<!--");
	out.println("alert('최대용량은 5M를 넘을 수 없습니다.');");
	out.println("//-->");
	out.println("</script>");
	out.flush();
	out.close();

	return;
}	
//첨부파일 용량 체크

MultipartRequest multi			= new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());

String cmd					  	= Util.getString(multi.getParameter("cmd"),"");

int board_seq					= ParamUtil.getIntParameter(multi.getParameter("board_seq"));
int requestedPage				= ParamUtil.getIntParameter(multi.getParameter("requestedPage"));
int subrequestedPage				= ParamUtil.getIntParameter(multi.getParameter("subrequestedPage"));

int comment_seq					= ParamUtil.getIntParameter(multi.getParameter("comment_seq"));
int list_num					= ParamUtil.getIntParameter(multi.getParameter("list_num"));

String title					= ParamUtil.getReqParameter(multi.getParameter("title"));
String content					= ParamUtil.getReqParameter(multi.getParameter("content"));
String part						= ParamUtil.getReqParameter(multi.getParameter("part"));
String keyword					= ParamUtil.getReqParameter(multi.getParameter("keyword"));
String subpart					= ParamUtil.getReqParameter(multi.getParameter("subpart"));
String subkeyword				= ParamUtil.getReqParameter(multi.getParameter("subkeyword"));

String status					= ParamUtil.getReqParameter(multi.getParameter("status"));
String check_y_seq				= ParamUtil.getReqParameter(multi.getParameter("check_y_seq"));	
String realF					= ParamUtil.getReqParameter(multi.getParameter("realF"));	
String virtualF					= ParamUtil.getReqParameter(multi.getParameter("virtualF"));	
int delcount					= ParamUtil.getIntParameter(multi.getParameter("subrequestedPage"));

String board_type				= "02";
String url						= "";

int result = 0;

String filename		= "";
String filesize		= "";
String vfilename    = "";

//##################################### 파일네임 빼오기 ################################
if(cmd.equals("insert")){
	filename		= realF;
	vfilename		= virtualF;	
}else if(cmd.equals("edit")){
	UploadFile up	= (UploadFile)new UploadFileImpl(request, response, multi, saveDir);

	filename		= ParamUtil.getReqParameter(up.getFilename());
	filesize		= ParamUtil.getReqParameter(up.getFilesize());	
	vfilename		= ParamUtil.getReqParameter(up.getVFilename());	

}

//############### Connection생성 ##########################
TourSympathy dao = new TourSympathy();
TourSympathyComment stardao = new TourSympathyComment();

//#########################################################

//String sess_id	= ParamUtil.getReqParameter((String)session.getAttribute("f_id"));

Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setBoard_type(board_type);
bean.setRef_no(0);
bean.setLevel_no(0);
bean.setSort_no(0);
bean.setTitle(title);
bean.setContent(content);
bean.setStatus(status);
bean.setUser_id("");
bean.setUser_name("");
bean.setUser_nick("");
bean.setUser_level("");
bean.setUser_icon("");
bean.setPassword("");

if(cmd.equals("insert")){

	url = "tour_sympathy.jsp?page="+requestedPage+"&part="+part+"&keyword="+keyword+"&list_num="+list_num;

	Map map = null;
	map = new HashMap();
	map.put("real_name0", filename);
    map.put("virtual_name0", vfilename);

	result = dao.insert(bean,map);

}else if(cmd.equals("edit")){
	
	url = "tour_sympathy.jsp?page="+requestedPage+"&part="+part+"&keyword="+keyword+"&list_num="+list_num;


	int attach_file_seq		= 0;
	String virtual_name		= "";
	String real_name		= "";

	Tbrd_attach_file_de_bean[] fileRecord = dao.getFileView(board_seq);

	if(fileRecord.length > 0){ 
		Tbrd_attach_file_de_bean fbean = fileRecord[0];
		attach_file_seq		= fbean.getAttach_file_seq();
		virtual_name		= Util.getString(fbean.getVirtual_name(),"");
		real_name			= Util.getString(fbean.getReal_name(),"");
	}

	
	if(!filename.equals("")){
		if(!virtual_name.equals("")){
			String FilePath = saveDir+virtual_name;

			File del = new File(FilePath);			
						
			if (del.exists()) del.delete();
		}
	}else{
		filename	= real_name;
		vfilename	= virtual_name;
	}

	Map map = null;
	map = new HashMap();
	
	if(!filename.equals("")){
		map.put("real_name", filename);
		map.put("virtual_name", vfilename);
		map.put("attach_file_seq", attach_file_seq+"");
	}

	
	
	result = dao.update(bean,map);

}else if(cmd.equals("delList")){
	url = "tour_sympathy_view.jsp?board_seq="+board_seq+"&page="+subrequestedPage+"&requestedPage="+requestedPage+"&part="+part+"&subpart="+subpart+"&keyword="+keyword+"&subkeyword="+subkeyword+"&list_num="+list_num;

	result = stardao.deleteList(check_y_seq, board_seq, delcount);
}else if(cmd.equals("choicebest")){
	url = "tour_sympathy_view.jsp?board_seq="+board_seq+"&page="+subrequestedPage+"&requestedPage="+requestedPage+"&part="+part+"&subpart="+subpart+"&keyword="+keyword+"&subkeyword="+subkeyword+"&list_num="+list_num;

	result = stardao.updateBest(comment_seq,"1");
}else if(cmd.equals("cancelbest")){
	url = "tour_sympathy_view.jsp?board_seq="+board_seq+"&page="+subrequestedPage+"&requestedPage="+requestedPage+"&part="+part+"&subpart="+subpart+"&keyword="+keyword+"&subkeyword="+subkeyword+"&list_num="+list_num;

	result = stardao.updateBest(comment_seq,"0");
}else if(cmd.equals("del")){
	result = dao.deleteUpdate(board_seq);
	url = "tour_sympathy.jsp?page="+requestedPage+"&part="+part+"&keyword="+keyword;
}


if(result > 0){
	if(cmd.equals("edit")){
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert("성공적으로 처리되었습니다.");
		opener.location.href="tour_sympathy_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%>&part=<%=part%>&keyword=<%=keyword%>";
		window.close();
		//-->
		</SCRIPT>
<%
	}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert("성공적으로 처리되었습니다.");
		location.href="<%=url%>";
		//-->
		</SCRIPT>
<%
	}
}else{
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("처리가 실패하였습니다..");
location.href="<%=url%>";
//-->
</SCRIPT>
<% 
}
%>