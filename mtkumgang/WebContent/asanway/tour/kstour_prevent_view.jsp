<%--
  - 작성자: 이소연
  - 일자: 2006.07.26
  - 저작권 표시: IMJ Korea
  - 설명: 지난이벤트보기 > 상세보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.KsTourPrevent"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;
//변수 선언
int attach_seq = 0;
String cmd	= "";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String user_name = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_code = "";
String type_code_name = "";
String type_name = "";
String virtual_name	= "";
String real_name		= "";
int recomm_num = 0;
String realFileName	= "";
String saveDirName = "adminGalleryUpload";
Tbrd_attach_file_de_bean[] fileRecord = null;


	//DAO
	KsTourPrevent dao = new KsTourPrevent();
          //DTO
          if(board_seq>0){
                 	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
                 	title						= bean[0].getTitle();
                 	content					= bean[0].getContent();
                 	content					= content.replaceAll("\"", "'");
                 	user_id					= bean[0].getUser_id();
                 	regdate					= bean[0].getReg_date_String();
                 	read_num				          = bean[0].getRead_num();
                 	user_name					= bean[0].getUser_name();
                 	type_code =bean[0].getType_code();
                 	virtual_name = bean[0].getVirtual_name();
                 	real_name   = bean[0].getReal_name();
                     recomm_num = bean[0].getRecomm_num();

                 	fileRecord = dao.getFileView(board_seq);
                 
                 	if(fileRecord != null && fileRecord.length>0){
                 		attach_seq = fileRecord[0].getAttach_file_seq(); 
                 	}
          }

%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

function _private_trim()
{
    var strTemp = this;
     alert(strTemp);
    if ( strTemp.length > 0 )
    {
    	while ( strTemp.substring(0, 1) == " " )
    			strTemp = strTemp.substring(1);
    	while ( strTemp.substring(strTemp.length - 1, strTemp.length) == " " )
    			strTemp = strTemp.substring(0, strTemp.length - 1);
    }
    return strTemp;
}
	

String.prototype.trim = _private_trim;

function goEdit(){	
	f = document.mainForm;
    f.action = "kstour_prevent_edit.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>";
	f.submit();
	
}

function del(){
	f = document.mainForm;

	if(confirm("게시물을 삭제하시겠습니까?")){
		f.cmd.value = "del";
	          f.submit();
	}else{
		return;
	}
}


//이미지 싸이즈 고정
function resizeImg(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
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
          		        <span class=locon>지난이벤트보기</A> </span></TD>
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
                				<td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>겔러리</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>

<form method=post name="mainForm" action="kstour_prevent_ok.jsp"  encType="multipart/form-data">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="board_seq" value="<%=board_seq%>">
<input type="hidden" name="attach_seq" value="<%=attach_seq%>">
<input type="hidden" name="part" value="<%=part%>">
<input type="hidden" name="keyword" value="<%=keyword%>">
<input type="hidden" name="requestedPage" value="<%=requestedPage%>">

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=4 height=2 class=linec1></td></tr>
                				<tr><td colspan=4 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10 colspan=7>
                					<%=title%>
                					</td>
                				</tr>
					<tr><td colspan=4 height=1 class=linec0></td></tr>
					<tr height=28>
					          <td class='tdcolor th' align=center>등록일</td>
                					<td class=lpad10>
                					  <%=regdate%>
                					</td>
						<td class='tdcolor th' align=center>조회</td>
                					<td class=lpad10>
                					  <%=read_num%>
                					</td>
                				</tr>
                				<tr><td colspan=4 height=1 class=linec0></td></tr>
                				<tr height=28>
                                                        <td class='tdcolor th' align=center valign=top style=padding-top:7;>이미지</td>
                                                        <td class=lpad10 style='padding-top:7;padding-bottom:7;' colspan=7 height=100 valign=top>
                                                                 <% 
                                                                if(fileRecord != null){ 
                                                                     StringBuffer sb = new StringBuffer();
                                                                     for(int j=0; j<fileRecord.length; j++){
                                                                          Tbrd_attach_file_de_bean fbean = fileRecord[j];
                                                                          virtual_name= Util.getString(fbean.getVirtual_name(),"");
                                                                          real_name= Util.getString(fbean.getReal_name(),"");								
                                                                         String img_name =  virtual_name;
                                                                         %>
					                                      <%=virtual_name%> &nbsp;</br>
					                                      <img src="<%=img_name%>" onload=resizeImg(this)> 
                                                               <%
                                                                    }
                                                                } 
                                                                %>	

				          
                                                        </td>
                				</tr>
                				<tr height=28>
                                 <td  colspan=8 class=lpad10 style='padding-top:7;padding-bottom:7;' height=300 valign=top>
                                 <%=content%>
                                 </td>
                				</tr>
                				<tr><td colspan=4 height=1 class=linec1></td></tr>
                                                     <tr><td colspan=4 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                                         <td align=right>
                                                                <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=수정  class=btn onclick="javascript:goEdit()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                                                <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=삭제  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                                                <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='kstour_prevent.jsp'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>         					
                                                         </td>
                				</tr>
                			</table>
</form>
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
