<%--
  - 작성자: 이소연
  - 일자: 2006.06.13
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 금강산 알아보기>홍보자료실 신규등록 or 수정
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrRoomJpn"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>



<%
//request parameters
int board_seq 	    = Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

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
String type_name = "";
String virtual_name	= "";
String real_name		= "";
String thumbnail_virtual_name	= "";
String thumbnail_real_name		= "";
int recomm_num = 0;
String realFileName01	= "";
String realFileName02	= "";
String img_name = "";
String saveDirName = "adminPrroomLink";
Tbrd_attach_file_de_bean[] fileRecord = null;

if (board_seq > 0){
	//DAO
	TourPrRoomJpn dao = new TourPrRoomJpn();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle().trim();
	content					= bean[0].getContent();
	content					= content.replaceAll("\"", "'");
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	type_code = bean[0].getType_code().trim();   // 구분 (이미지 : 1, 동영상 : 2)
	
	virtual_name = bean[0].getVirtual_name();
	real_name   = bean[0].getReal_name();
	virtual_name = bean[0].getVirtual_name();
	
	thumbnail_real_name   = bean[0].getThumbnail_real_name();	
	thumbnail_virtual_name = bean[0].getThumbnail_virtual_name();
	
    recomm_num = bean[0].getRecomm_num();

	fileRecord = dao.getFileView(board_seq);

	if(fileRecord.length>0){
		attach_seq = fileRecord[0].getAttach_file_seq(); 
	}

//out.println(attach_seq);
	cmd = "edit";
}else{
	cmd = "insert";
	user_id ="admin";
	user_name="관리자";
	regdate = Util.getDate();
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
		 //alert(strTemp);
		if ( strTemp.length > 0 )
		{
			while ( strTemp.substring(0, 1) == " " )
					strTemp = strTemp.substring(1);
			while ( strTemp.substring(strTemp.length - 1, strTemp.length) == " " )
					strTemp = strTemp.substring(0, strTemp.length - 1);
		}
		//alert(strTemp.length);
		return strTemp;
}
	

String.prototype.trim = _private_trim;

function chk(){	
	

	f = document.mainForm;

	if(f.title.value==""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return false;
	}


    var realFileName01 = f.attachFile01.value; //------썸네일
	f.realFileName01.value = realFileName01;
	
	if(document.getElementById("imageAreaValue01").innerHTML ==""){
	    //alert(realFileName01);
		if(realFileName01==""){
			alert("썸네일을 등록하세요.");
			f.attachFile01.focus();
			return false;
		}
	}else{
	    var idx = realFileName01.lastIndexOf("\\");
	    realFileName01 = realFileName01.substring(idx+1);    
    }
	
    if (f.type_code[0].checked == false &&  f.type_code[1].checked == false){
       alert("구분을 선택하세요.");
       f.type_code.focus();
       return false;
    }
	
	//alert(f.type_code[1].checked);
	//alert(f.content.value);
    if(f.type_code[1].checked == true &&  f.content.value==""){   //[------동영상 선택시
		
		alert("동영상 링크를 입력하세요.");
		f.content.focus();
		return false;
		
	}else if(f.type_code[0].checked == true) {     //[------이미지 선택시   
    
         var realFileName02 = f.attachFile02.value; //------이미지
	     f.realFileName02.value = realFileName02;
	     if(document.getElementById("imageAreaValue02").innerHTML ==""){
	     	if(realFileName02==""){
	     		alert("이미지를 등록하세요.");
	     		return false;
	     	}
	      }else{
	           var idx = realFileName02.lastIndexOf("\\");
	           realFileName02 = realFileName02.substring(idx+1);    	      
	      }
    }
	
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

function attachDel(attachSeq){
	f = document.mainForm;

	if(confirm("이미지를 삭제하시겠습니까?")){
		f.target="uframe";
		f.cmd.value = "attachDel";
		f.attach_seq.value=attachSeq;
	    f.submit();
	}else{
		return;
	}


}

function delAttachRow(){
    document.getElementById("imageAreaValue").innerHTML = "";
	f.cmd.value ="edit";
	
}

function changmod(val) {
   var form = document.mainForm;
   
   if (val == "1"){
        document.all.type1.style.display = "";
        document.all.type2.style.display = "none";
   }else{
        document.all.type1.style.display = "none";
        document.all.type2.style.display = "";
   }
   
}

var intPre = new Array;
function imgSize(obj,idx) {
    var width = eval("document."+obj).width;
    var height = eval("document."+obj).height;
    var temp = 0; 
    var max_width= 420;
    if(width > 0 && height > 0)
    {
    	clearInterval(intPre[idx]);

	    if ( width > max_width ) { 
	       height = height/(width / max_width);
	       eval("document."+obj).width = max_width;     
	       eval("document."+obj).height = height;
	    }
	 }
	 else
	 {
	 	intPre[idx] = setInterval("imgSize('"+obj+"',"+idx+")",100);
	 }  
 }
//-->
</SCRIPT>

                      
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0"  <%if (board_seq > 0){%> onload="javascript:changmod('<%=type_code%>');" <%}%> >
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
          		        <img src="<%=imageServer%>/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>홍보자료실(일문)</A> > 
          		        <span class=locon></A> </span></TD>
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
                				<td class='title'><img src=<%=imageServer%>/tour_img/bu_blue_title.gif align=texttop class=rmar10>홍보자료실(일문)</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>

							<FORM METHOD=POST name="mainForm" ACTION="tour_prroom_jpn_ok.jsp"  encType="multipart/form-data">
							<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
							<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
							<INPUT TYPE="hidden" name="attach_seq" value="<%=attach_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
							<INPUT TYPE="hidden" name="saveDirName" value="<%=saveDirName%>">
							<INPUT TYPE="hidden" name="realFileName01" >
							<INPUT TYPE="hidden" name="realFileName02" >

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=8 height=2 class=linec1></td></tr>
                				<tr><td colspan=8 height=1 class=linec0></td></tr>
                				<tr height=28>
                                  <td class='tdcolor th' align=center>제목</td>
                                  <td class=lpad10 colspan=7>
                                  <input type=text name=title style=width:450; value="<%=title%>">
                                  </td>
                				</tr>

<!--//썸네일 -->
								<%if(board_seq>0 ){%>
								<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>썸네일</td>
                                 <td id=imageArea class=lpad10 style='padding-top:7;padding-bottom:7;' colspan=7 height=100 valign=top>
                                 <div id="imageAreaValue01">
								 <%
									if(fileRecord != null){
										Tbrd_attach_file_de_bean fbean = fileRecord[0];
										thumbnail_virtual_name		= Util.getString(fbean.getThumbnail_virtual_name(),"");
                                      out.println("thumbnail_virtual_name:"+thumbnail_virtual_name);
										if(!thumbnail_virtual_name.equals("")){
											thumbnail_real_name		= Util.getString(fbean.getThumbnail_real_name(),"");											
											img_name = thumbnail_virtual_name;	
											String thumbnail_viewReal_name = "";		
											if(thumbnail_real_name.lastIndexOf("/")>0){
												thumbnail_viewReal_name = thumbnail_real_name.substring(thumbnail_real_name.lastIndexOf("/")+1);
											}
										%>
										<%=thumbnail_viewReal_name%> &nbsp;</br>
										<img src="<%=img_name%>" width="195" height="146" > 
										</br>
										<%
										}
									}
										img_name="";
										%>
									</div>
                                 </td>
                				</tr>
								<%}%>
								<tr height=28 >
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>썸네일</td>
                                 <td class=lpad10 colspan=7>
                                    <input type="file" name="attachFile01"  size="25"><font color="red">**이미지최적화사이즈:195*146 pixel</font>
									<div id="imageAreaValue01"></div>
                                 </td>
                				</tr>
<!--//썸네일 -->

								<tr height=28>
                                  <td class='tdcolor th' align=center>구분</td>
                                  <td class=lpad10 colspan=7>
                                  <input type="radio" name = "type_code" value="1" Onclick="changmod('1')" <%if(type_code !="" && type_code.equals("1")){%>checked<%}%>>이미지
                                  <input type="radio" name = "type_code" value="2" Onclick="changmod('2')" <%if(type_code !="" && type_code.equals("2")){%>checked<%}%>>동영상
                                  </td>
                				</tr>
								<tr><td colspan=8 height=1 class=linec0></td></tr>

<!--//이미지 -->

                                <tr id='type1' style='display:none' height=28>
                                  <td colspan=8>
                                    <table border=0>
								      <%if(board_seq>0 ){%>
								         <tr height=28>
                                          <td class='tdcolor th' align=center valign=top style=padding-top:7;>이미지</td>
                                          <td id=imageArea class=lpad10 style='padding-top:7;padding-bottom:7;' colspan=7 height=100 valign=top>
                                          <div id="imageAreaValue02">
								          <%
								         		if(fileRecord != null){
								         			Tbrd_attach_file_de_bean fbean = fileRecord[0];
								         			virtual_name		= Util.getString(fbean.getVirtual_name(),"");
								         			if(!virtual_name.equals("")){
								         				real_name		= Util.getString(fbean.getReal_name(),"");											
								         				img_name = virtual_name;	
								         				String viewReal_name = "";		
								         				if(real_name.lastIndexOf("/")>0){
								         					viewReal_name = real_name.substring(real_name.lastIndexOf("/")+1);
								         				}
								         			%>
								         			<%=viewReal_name%> &nbsp; </br>
								         			<img src="<%=img_name%>" name="image1" onload="imgSize(this.name,1)"> 
								         			</br>
								         			<%
								         			}
								         		}
								         		%>
								         	</div>
                                          </td>
                				         </tr> 
								     <%}%>
								     
								         <tr height=28 >
                                          <td class='tdcolor th' align=center valign=top style=padding-top:7; width=95>이미지</td>
                                          <td class=lpad10 colspan=7>
                                             <input type="file" name="attachFile02"  size="25"><font color="red">**이미지최적화사이즈:700*500 pixel</font>
								         	<div id="imageAreaValue02"></div>
                                          </td>
                				         </tr>  
                				     </table>
                                  </td>
                               </tr>

<!--//이미지 -->

<!--//동영상 -->
                				<tr id='type2' style='display:none' height=28>
                                  <td class='tdcolor th' align=center>동영상 링크</td>
                                  <td class=lpad10 colspan=7>
                                  <input type=text name=content style=width:450; value="<%=content%>">
                                  </td>
                				</tr>
                				      				                            
<!--//동영상 -->
								<tr><td colspan=8 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  <% if(board_seq <= 0){ %>
                                  <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=등록  class=btn onclick="javascript:chk()" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                  <%  }else{%>
								   <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=수정  class=btn onclick="javascript:chk()" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								    <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <%}%>
								  <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_prroom_jpn.jsp'"><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle>         					
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