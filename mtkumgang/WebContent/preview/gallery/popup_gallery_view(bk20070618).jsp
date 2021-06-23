<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourAdminGalleryFront"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%
    //변수 선언
    int board_seq = 0;
    int pre_seq = 0;
    int next_seq = 0;
    int attach_seq = 0;
    int read_num = 0; //변경대비
    String title= "";
    String content	= "";
    String regdate = "";
    String type_code = "";
    String virtual_name	= "";
    String real_name		= "";
    String realFileName	= "";
    
    //request parameters
    board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
    type_code   = ParamUtil.getReqParameter(request.getParameter("type_code"));
    
   Tbrd_attach_file_de_bean[] fileRecord = null;

    //DAO
   TourAdminGalleryFront dao = new TourAdminGalleryFront();
    //DTO
    
    //시작시, board_seq 를 구한다.
    if (board_seq < 1){
       board_seq = dao.getMaxSeq(type_code, board_seq);    
    }
    
    
if(board_seq > 0){
    
	Tbrd_board_ma_bean bean[] = dao.getBoardView(type_code,board_seq);
	board_seq   			= bean[0].getBoard_seq();
	title					= bean[0].getTitle();
	content					= bean[0].getContent();
	content					= content.replaceAll("\"", "'");
	regdate					= bean[0].getReg_date_String();
	//read_num				= bean[0].getRead_num();
	virtual_name = bean[0].getVirtual_name();
	real_name   = bean[0].getReal_name();
          pre_seq   			= bean[0].getPre_seq();
         next_seq   			= bean[0].getNext_seq();
    
	fileRecord = dao.getFileView(board_seq);

	if(fileRecord != null && fileRecord.length>0){
		attach_seq = fileRecord[0].getAttach_file_seq(); 
	}

          dao.updateReadnum(board_seq);

}

%>

<html>
<head>
<title> 금강산관광 </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="javascript">
<!--
   //이미지 싸이즈 고정
   function resizeImg(obj){
    //alert(obj.width);
    //alert(obj.height);
   	if(obj.width > 600){
   		obj.width = 600;
   	}
   	if(obj.height > 400){
   		obj.height = 400;
   	}
   }
-->
</script>
</head>

<body class="popmargin">

<!-- 팝업사이즈 : 630 X 585 -->
<table cellspacing="0" cellpadding="0" border="0" width="600">
<tr>
	<td width="100%">
		<!-- / 타이틀 -->
		<table cellspacing="0" cellpadding="0" border="0"><tr><td>
		
		<% if (type_code.equals("21")){ //금강산 %>
		       <img src="<%=imageServer%>/tour_img/preview/pop_tit_gallery01.gif" width="600" height="65">
		<% }else if (type_code.equals("22")){ //봉래산 %>
		       <img src="<%=imageServer%>/tour_img/preview/pop_tit_gallery02.gif" width="600" height="65">
		<% }else if (type_code.equals("23")){ //풍악산 %>
		       <img src="<%=imageServer%>/tour_img/preview/pop_tit_gallery03.gif" width="600" height="65">
		<% }else if (type_code.equals("24")){ //개골산 %>
		       <img src="<%=imageServer%>/tour_img/preview/pop_tit_gallery04.gif" width="600" height="65">
        <% }%>
				
		</td></tr></table>
		<!-- 타이틀 / -->
		
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
		<tr>
			<td height="45" width="33%">
			<%if (next_seq > 0){%>
			   <a href="popup_gallery_view.jsp?type_code=<%=type_code%>&board_seq=<%=next_seq%>"><img src="<%=imageServer%>/tour_img/preview/btn_gallery_prev.gif"></a><!-- 이전 -->
			<%}%>
			</td>
			<td align="center" width="34%">
			<%if (board_seq > 0){%>
			   [<%=title%>]
		    <%}else{%>
		       등록된 데이터가 없습니다.
            <%}%>
			</td>
			<td align="right" width="33%">
			<%if (pre_seq > 0){%>
			   <a href="popup_gallery_view.jsp?type_code=<%=type_code%>&board_seq=<%=pre_seq%>"><img src="<%=imageServer%>/tour_img/preview/btn_gallery_next.gif"></a><!-- 다음 -->
			<%}%>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
			<!--<img src="http://www.mtkumgang.com/1cyber/assets/images/kum/k_gwi1.JPG" width="600" height="400">-->
            <%
             if(fileRecord != null && fileRecord.length>0){
             	Tbrd_attach_file_de_bean fbean = fileRecord[0];
             	virtual_name		= Util.getString(fbean.getVirtual_name(),"");
             	if(!virtual_name.equals("")){
             	real_name		= Util.getString(fbean.getReal_name(),"");
             	String img_name = virtual_name;	
             	String viewReal_name = "";		
             	if(real_name.lastIndexOf("/")>0){
             		viewReal_name = real_name.substring(real_name.lastIndexOf("/")+1);
             	}		
             	%>
             	<img src="<%=img_name%>" onload=resizeImg(this)> 
             	<%
             	}
             }
            %>
			<!-- 이미지 --></td>
		</tr>
		<tr><td colspan="3" height="20"></td></tr>
		<tr>
			<td colspan="3" height="24" valign="top" align="center"><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_pre_close.gif"></a><!-- 확인 --></td>
		</tr>
		</table>
	</td>
</tr>
</table>

</body>
</html>