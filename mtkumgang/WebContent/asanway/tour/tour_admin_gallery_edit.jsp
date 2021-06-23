<%--
  - �ۼ���: ������
  - ����: 2006.05.26
  - ������:2006.08
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ������>������ ��� ������ �űԵ�� or ����
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourAdminGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

//���� ����
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
int recomm_num = 0;
String realFileName	= "";
String saveDirName = "adminGalleryLink";
Tbrd_attach_file_de_bean[] fileRecord = null;

if (board_seq > 0){
	//DAO
	TourAdminGalleryBoard dao = new TourAdminGalleryBoard();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content					= bean[0].getContent();
	content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	user_name					= bean[0].getUser_name();
	type_code = bean[0].getType_code();
	virtual_name = bean[0].getVirtual_name();
	real_name   = bean[0].getReal_name();
    recomm_num = bean[0].getRecomm_num();

	fileRecord = dao.getFileView(board_seq);

	if(fileRecord.length>0){
		attach_seq = fileRecord[0].getAttach_file_seq(); 
	}

	cmd = "edit";
}else{
	cmd = "insert";
	user_id ="admin";
	user_name="������";
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
		 alert(strTemp);
		if ( strTemp.length > 0 )
		{
			while ( strTemp.substring(0, 1) == " " )
					strTemp = strTemp.substring(1);
			while ( strTemp.substring(strTemp.length - 1, strTemp.length) == " " )
					strTemp = strTemp.substring(0, strTemp.length - 1);
		}
		alert(strTemp.length);
		return strTemp;
}
	

String.prototype.trim = _private_trim;









function chk(){	
	

	f = document.mainForm;

	if(f.title.value==""){
		alert("������ �Է��ϼ���.");
		f.title.focus();
		return false;
	}

	if(f.type_code.value==""){
		alert("�з��� �����ϼ���.");
		f.type_code.focus();
		return false;
	}
	

  
  //(f.content.value==""){
	////	alert("������ �Է��ϼ���.");
	////	f.content.focus();
	////	return false;
	////}
	//alert( trim(f.content.value).length);

	
    var realFileName = f.attachFile01.value;

	f.realFileName.value = realFileName;
	
	//alert(document.getElementById("imageAreaValue").innerHTML);
	if(document.getElementById("imageAreaValue").innerHTML ==""){
		if(realFileName==""){
			alert("÷�������� ����ϼ���.");
			//f.content.focus();
			return false;
		}
	}

	
 
	var idx = realFileName.lastIndexOf("\\");


	realFileName = realFileName.substring(idx+1);
	
	//if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".") > 0){
	//  alert("���۱� ������ ������ �ִ� mp3, wma, asf ������ �������� ÷�δ� ���� �ʽ��ϴ�.");
	//  return;
	//}

     
	f.submit();
	

}


function del(){
	f = document.mainForm;

	if(confirm("�Խù��� �����Ͻðڽ��ϱ�?")){
		f.cmd.value = "del";
	    f.submit();
	}else{
		return;
	}
}

function attachDel(attachSeq){
	f = document.mainForm;

	if(confirm("�̹����� �����Ͻðڽ��ϱ�?")){
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


//�̹��� ������ ����
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
          		        <img src="<%=imageServer%>tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>Ȩ</A> > 
          		        <A HREF=# class=loc>������</A> > 
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
                				<td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>������</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>

							<FORM METHOD=POST name="mainForm" ACTION="tour_admin_gallery_ok.jsp"  encType="multipart/form-data">
							<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
							<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
							<INPUT TYPE="hidden" name="attach_seq" value="<%=attach_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
							<INPUT TYPE="hidden" name="saveDirName" value="<%=saveDirName%>">
							<INPUT TYPE="hidden" name="realFileName" >

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=8 height=2 class=linec1></td></tr>
                				<tr><td colspan=8 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>����</td>
                					<td class=lpad10 colspan=7>
                					<input type=text name=title style=width:450; value="<%=title%>">
                					</td>
                				</tr>
								<tr height=28>
                					<td class='tdcolor th' align=center>�з�����</td>
                					<td class=lpad10 colspan=7>
										<select name="type_code" style='width:80;'>
                                          <option <%if(type_code.equals("")){%>selected<%}%>  value=''>����</option>
                                          <option <%if(type_code.equals("21")){%>selected<%}%> value='21'>�ݰ���</option>
                                          <option <%if(type_code.equals("22")){%>selected<%}%> value='22'>������</option>
										  <option <%if(type_code.equals("23")){%>selected<%}%> value='23'>ǳ�ǻ�</option>
										  <option <%if(type_code.equals("24")){%>selected<%}%> value='24'>�����</option>
										  <option <%if(type_code.equals("25")){%>selected<%}%> value='25'>����-������</option>
                                          </select>
										 </td>
                				</tr>

								<tr><td colspan=8 height=1 class=linec0></td></tr>
								<tr height=28>
									<td class='tdcolor th' align=center>�����</td>
                					<td class=lpad10>
                					  <%=regdate%>
                					</td>
									<td class='tdcolor th' align=center>��ȸ</td>
                					<td class=lpad10>
                					  <%=read_num%>
                					</td>
									<td align=center>&nbsp;</td>
                					<td>&nbsp;</td>
									<td align=center>&nbsp;</td>
                					<td>&nbsp;</td>                					
                				</tr>
								<%if(board_seq>0 ){%>
								<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>�̹���</td>
                                 <td id=imageArea class=lpad10 style='padding-top:7;padding-bottom:7;' colspan=7 height=100 valign=top>
                                 <div id="imageAreaValue">
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
											<%=viewReal_name%> &nbsp;</br>
											<img src="<%=img_name%>" onload=resizeImg(this)> 
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
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>�̹���</td>
                                 <td class=lpad10 colspan=7>
                                    <input type="file" name="attachFile01"  size="25"><font color=red>**�̹�������ȭ������:600*400 pixel</font>
									<div id="imageAreaValue"></div>
									
                                 </td>
                				</tr>  
								
                				<tr><td colspan=8 height=1 class=linec1></td></tr>
								<tr><td colspan=8 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  <% if(board_seq <= 0){ %>
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=���  class=btn onclick="javascript:chk()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                  <%  }else{%>
								   <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=����  class=btn onclick="javascript:chk()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								    <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=����  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <%}%>
								  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=��� class=btn onclick="location.href='tour_admin_gallery.jsp'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>         					
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
