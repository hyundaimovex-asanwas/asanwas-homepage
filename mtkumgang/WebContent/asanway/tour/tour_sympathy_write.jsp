<%--
  - 작성자: 박상배
  - 일자: 2006.04.17
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 여행 공감대 주제등록
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.util.*"%>


<%
int board_seq 			= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage		= Util.parseInt(request.getParameter("requestedPage"), 1);
String con        		= ParamUtil.getReqParameter(request.getParameter("con"));
String keyword    		= ParamUtil.getReqParameter(request.getParameter("keyword"));

String cmd				= "";

String board_type		= "02";
int ref_no				= 0;
int level_no			= 0;
int sort_no				= 0;
String title			= "";
String content			= "";
String user_id			= "";
String user_name		= "";
String user_nick		= "";
String user_level		= "";
String user_icon		= "";
String regdate			= "";
int read_num			= 0;
int recomm_num			= 0;
int comment_num			= 0;
String notice_from		= "";
String notice_to		= "";
int board_top_no		= 0;
String edit_yn			= "";
String use_yn			= "";
int point				= 0;
String password			= "";
String fullFilename		= "";
String action_url		= "";
StringBuffer fileNameList = new StringBuffer();


Tbrd_attach_file_de_bean[] fileRecord = null;

if (board_seq > 0){
	//############### Connection생성 ##########################
	TourSympathy dao = new TourSympathy();
	//#########################################################

	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	
	ref_no					= bean[0].getRef_no();
	level_no				= bean[0].getLevel_no();
	sort_no					= bean[0].getSort_no();
	title					= bean[0].getTitle();
	content					= bean[0].getContent();
	
	user_id					= bean[0].getUser_id();
	user_name				= bean[0].getUser_name();
	user_nick				= bean[0].getUser_nick();
	user_level				= bean[0].getUser_level();
	user_icon				= bean[0].getUser_icon();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	recomm_num				= bean[0].getRecomm_num();
	comment_num				= bean[0].getComment_num();
	board_top_no			= bean[0].getBoard_top_no();
	edit_yn					= bean[0].getEdit_yn();
	use_yn					= bean[0].getUse_yn();
	point					= bean[0].getPoint();
	password				= bean[0].getPassword();

	fileRecord = dao.getFileView(board_seq);
	
	/*
	Tbrd_attach_file_de_bean tBean = null;
	for(int i=0; i<fileRecord.length; i++){
		tBean =  (Tbrd_attach_file_de_bean)fileRecord[i];
		fileNameList.append(tBean.getVirtual_name());
		if(fileRecord.length-1>i){
			fileNameList.append(",");
		}
	}
	*/
	
	cmd = "edit";

	action_url = "tour_sympathy_ok.jsp";
}else{
	cmd = "insert";
	action_url = "tour_sympathy_preview.jsp";
}
%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
//이미지 싸이즈 고정
function resizeImg(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
	}
}

function chk(obj){
	if(obj.title.value == ""){
		alert("주제를 등록하세요.");
		obj.title.focus();
		return false;
	}

	if(obj.content.value == ""){
		alert("내용을 등록하세요.");
		obj.content.focus();
		return false;
	}

	if(obj.file1.value == ""){
		alert("이미지를 선택하세요.");
		//obj.file1.focus();
		return false;
	}

	if(obj.status.value == ""){
		alert("게시상태를 선택하세요.");
		obj.status.focus();
		return false;
	}

	return true;
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
	       		        <img src="../img/tour_img//bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
	       		        <A HREF=# class=loc>커뮤니티</A> > 
	       		        <span class=locon>여행 공감대 주제등록</A> </span>
	       		        </TD> 
	       	          </TR>
	       	       <!-- //loc -->
	       	       </TABLE>
	               </TD>
               </TR>
	       	<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<FORM METHOD=post name="frm" ACTION="<%=action_url%>" encType="multipart/form-data" onSubmit="return chk(this);">
					<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="con" value="<%=con%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img//bu_blue_title.gif align=texttop class=rmar10>여행 공감대 주제등록</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7; rowspan=2>주제</td>
                                 <td class=lpad10 style='padding-top:7;padding-bottom:7;'>
                                 <input type=text name=title style=width:400; value="<%=title%>">
                                 </td>
                                 </tr>
                                 <tr>
                                 <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <textarea name=content cols=80 rows=8><%=content%></textarea>
                                 </td>
                                 </tr>
                				</tr>
								<tr><td colspan=2 height=1 class=linec1></td></tr>
                				<tr height=28 >
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>주제이미지</td>
                                 <td class=lpad10>
                                    <input type="file" name="file1" id="file1" size="60">
                                 </td>
                				</tr>  
								<% 
								if(fileRecord != null){ 
								%>
								<tr><td colspan=2 height=1 class=linec1></td></tr>
                				<tr height=28 >
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>주제이미지</td>
                                 <td class=lpad10>
                                    <%
									//StringBuffer sb = new StringBuffer();
									//for(int j=0; j<fileRecord.length; j++){
									Tbrd_attach_file_de_bean fbean = fileRecord[0];
									
									String virtual_name		= Util.getString(fbean.getVirtual_name(),"");
									String real_name		= Util.getString(fbean.getReal_name(),"");
																					
									String img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;	
											
											
											//sb.append("<option value='"+virtual_name+"'>"+real_name+"</option>");
											
									%>
									<img src="<%=img_name%>" onload=resizeImg(this)><br>
									<%
									//}
									//fullFilename = sb.toString();
									%>
                                 </td>
                				</tr>  
								<%
								} 
								%>	

                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                				<tr height=28 >
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>게시상태</td>
                                 <td class=lpad10>
                                    <select name="status" style='width:100;'>
                                    <option value=''>선택</option>
                                    <option value='1'>진행중</option>
                                    <option value='0'>마감</option>
									<option value='2'>숨김</option>
                                    </select>
                                 </td>
                				</tr>         				
                				<tr><td colspan=8 height=1 class=linec1></td></tr>         				
                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                			</table>
                			
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                					<td align=right>
                						<img src=../img/tour_img//btn_l.gif align=absmiddle><input type=submit value=등록 class=btn ><img src=../img/tour_img//btn_r.gif align=absmiddle><img src=../img/tour_img//btn_r.gif align=absmiddle style=margin-right:1;>
                						<img src=../img/tour_img//btn_l.gif align=absmiddle><input type=button value=취소 class=btn onclick="location.href='tour_sympathy.jsp'"><img src=../img/tour_img//btn_r.gif align=absmiddle>         					
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
