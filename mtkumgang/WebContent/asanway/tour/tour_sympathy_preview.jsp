<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="kr.co.imjk.upload.UploadFileImpl"%>
<%@ page import="kr.co.imjk.upload.UploadFile"%>

<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.util.*"%>


<%

String saveDir 		=  Config.getInstance().getProperty("imjkmd","agreeGalleryUpload");
String img_name		= "";

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

String title					= ParamUtil.getReqParameter(multi.getParameter("title"));
String content					= ParamUtil.getReqParameter(multi.getParameter("content"));
String status					= ParamUtil.getReqParameter(multi.getParameter("status"));

int board_seq 			= Util.parseInt(multi.getParameter("board_seq"), 0);
int requestedPage		= Util.parseInt(multi.getParameter("requestedPage"), 1);
String part        		= ParamUtil.getReqParameter(multi.getParameter("part"));
String keyword    		= ParamUtil.getReqParameter(multi.getParameter("keyword"));

String cmd				= "";

String board_type		= "02";

//##################################### 파일네임 빼오기 ################################
UploadFile up	= (UploadFile)new UploadFileImpl(request, response, multi, saveDir);
String filename		= ParamUtil.getReqParameter(up.getFilename());
String filesize		= ParamUtil.getReqParameter(up.getFilesize());	
String vfilename    = ParamUtil.getReqParameter(up.getVFilename());	

img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+vfilename;
%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function chk(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
	}
}

function form_chk(obj){
	if(confirm("정말 이번 공감주제로 등록하시겠습니까?")){
		return true;
	}else{
		return false;
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
          		        <A HREF=# class=loc>커뮤니티</A> > 
          		        <span class=locon>여행 공감대</span>
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
                	<FORM METHOD=post name="frm" ACTION="tour_sympathy_ok.jsp" encType="multipart/form-data" onSubmit="return form_chk(this);">
					<INPUT TYPE="hidden" name="cmd" value="insert">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="part" value="<%=part%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
					<INPUT TYPE="hidden" name="title" value="<%=title%>">
					<INPUT TYPE="hidden" name="content" value="<%=content%>">
					<INPUT TYPE="hidden" name="realF" value="<%=filename%>">
					<INPUT TYPE="hidden" name="virtualF" value="<%=vfilename%>">
					<INPUT TYPE="hidden" name="status" value="<%=status%>">
					<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>여행 공감대</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
							<table width=100% border=0 cellspacing=0 cellpadding=0>
							  <tr>
								<td height=2 class=linec1 colspan="2"></td>
							  </tr>
							  <tr> 
								<td style='padding:7;' width="24%"><img src="<%=img_name%>" onload=chk(this)> </td>
								<td style='padding:7;' width="76%"><%=title%><br>
								  <%=content%> </td>
							  </tr>
							  <tr>
								<td height=1 class=linec1 colspan="2"></td>
							  </tr>
							</table>

							<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                					<td align=right>
                						<img src=../img/tour_img//btn_l.gif align=absmiddle><input type=submit value=확인 class=btn ><img src=../img/tour_img//btn_r.gif align=absmiddle><img src=../img/tour_img//btn_r.gif align=absmiddle style=margin-right:1;>                						
                					</td>
                				</tr>
                			</table>
						</td>
					</tr>
					</FORM>
					</table>
				</td>

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
