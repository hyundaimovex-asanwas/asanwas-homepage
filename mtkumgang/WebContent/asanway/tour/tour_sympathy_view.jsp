<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="java.util.*"%>

<%
int board_seq		= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
int list_num		= ParamUtil.getIntParameter(request.getParameter("list_num"));

String part			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("part")));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&part="+part+"&keyword="+keyword;

//############### Connection���� ##########################
TourSympathy  dao  = new TourSympathy();

TourSympathyComment stardao = new TourSympathyComment();
//#########################################################

String title			= "";
String content			= "";
String gubun			= "";
String regdate			= "";
String status			= "";
int read_num				= 0;
int recomm_num			= 0;
int comment_num			= 0;

String virtual_name		= "";
String real_name		= "";
String img_name			= "";

int prev_board_seq		= 0;
int next_board_seq		= 0;
String prev_title		= "";
String next_title		= "";


Tbrd_board_ma_bean[] recordview = dao.getPrevAndNextBoard(board_seq);
int totalCount = recordview.length;


for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = recordview[i];

	gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		title						= tbean.getTitle();
		content						= tbean.getContent();
		regdate						= tbean.getReg_date_String();
		read_num					= tbean.getRead_num();
		recomm_num					= tbean.getRecomm_num();
		comment_num					= tbean.getComment_num();
		status						= tbean.getStatus();
	}else if(gubun.equals("PREV")){
		prev_board_seq		= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

Tbrd_attach_file_de_bean[] fileRecord = dao.getFileView(board_seq);

if(fileRecord.length > 0){
	Tbrd_attach_file_de_bean ubean = fileRecord[0];
	virtual_name			= Util.getString(ubean.getVirtual_name(),"");
	real_name				= Util.getString(ubean.getReal_name(),"");

	img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;
}

/*
if(recordview != null){
	Tbrd_board_ma_bean tbean = recordview[0];

	title					= Util.getString(tbean.getTitle(),"");
	content					= Util.getString(tbean.getContent(),"");
	virtual_name			= Util.getString(tbean.getVirtual_name(),"");
	real_name				= Util.getString(tbean.getReal_name(),"");

	img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;

}
*/

int comment_seq		= 0;
String user_nick	= "";
String user_id		= "";
String isbest		= "";


int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType		= "09";


// �˻� - �÷���
String subpart       = ParamUtil.getReqParameter(request.getParameter("subpart"));
// �˻� - �˻���
String subkeyword    = ParamUtil.getReqParameter(request.getParameter("subkeyword"));
// �˻� - �Ķ����
String subkey_str = "&board_seq="+board_seq+"&subpart="+subpart+"&subkeyword="+subkeyword;

if(subpart.equals("")){
	subpart = "3";
}

//��û�� ������ �ѹ�
int subrequestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// �Խù� ���
Tbrd_comment_de_bean record [] = stardao.getCommentAdminList(subrequestedPage, pageSize, subpart, subkeyword ,board_seq);

// ��ü �Խù� ��
int allCount = stardao.getCommentAdminTotalCount(subpart, subkeyword ,board_seq );

// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, subrequestedPage, allCount);

%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
// �̹��� ������ ���� 
function chk(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
	}
}

// ��ü ����
function colCheck(){
	form0 = document.listForm;
	try{
		if(form0.allCheck.value=="0"){
			for( i = 0; i < form0.check_yn.length; i++ ){
				form0.check_yn[i].checked=true;			
			}
			form0.allCheck.value="1"
		}else{
			for( i = 0; i < form0.check_yn.length; i++ ){
				form0.check_yn[i].checked=false;
			}
			form0.allCheck.value="0"
		}
	}catch(e){
		window.status=e;
	}
}

function colDel(){
	var count = 0;
			 
	form = document.listForm;
	form.cmd.value="delList";
	check_array =  form.check_yn;
	var check_y_seq="";
	   
	var temp;
	for(i=0; i<check_array.length; i++){
	   if(check_array[i].checked == true){
		   temp =  check_array[i].value;
			 check_y_seq += temp+","; 
			 count++;
	   }
	}

	//�ϳ��� ���õ��� �ʾ�����
	if(check_y_seq.length <= 0){
		alert("������ ����Ÿ�� �����ϴ�!")
		return;
	}else{
		if(confirm("���� �����Ͻðڽ��ϱ�?\n\nFront���� �����ڿ� ���� �����Ǿ����ϴ�. ��� �ȳ� ��Ʈ�� ����˴ϴ�.")){
			check_y_seq= check_y_seq.substring(0,check_y_seq.length-1);
			form.check_y_seq.value= check_y_seq;
			form.delcount.value = count;
			form.action="tour_sympathy_ok.jsp";
			form.submit();
		}
	}
	
}

function chkisbest(item){
	//var obj = document.listForm;
	
		if(item.checked == true){
			if(confirm("�ش� �Խù��� best�� �����Ͻðڽ��ϱ�?")){
				form = document.listForm;
				form.cmd.value="choicebest";
				form.comment_seq.value= item.value;
				form.action="tour_sympathy_ok.jsp";
				form.submit();
			}
		}else if(item.checked == false){
			if(confirm("best������ ����Ͻðڽ��ϱ�?")){
				form = document.listForm;
				form.cmd.value="cancelbest";
				form.comment_seq.value= item.value;
				form.action="tour_sympathy_ok.jsp";
				form.submit();
			}
		}
	
}

function data_update(){
	var allCount = "<%=allCount%>";
	if(allCount > 0){
		alert("�Խù��� ��ϵǾ� �����Ƿ� ������ �Ұ��մϴ�");
		return;
	}else{
		winObj = window.open("./tour_sympathy_edit.jsp?board_seq=<%=board_seq%>&page=<%=requestedPage%><%=key_str%>", "winName", "width=700,height=500,scrollbars=yes");
	}
}


function data_del(){
	var allCount = "<%=allCount%>";
	if(allCount > 0){
		alert("�Խù��� ��ϵǾ� �����Ƿ� ������ �Ұ��մϴ�");
		return;
	}else{
		if(confirm("���� �����Ͻðڽ��ϱ�?")){
			document.delForm.submit();
		}
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
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>Ȩ</A> > 
          		        <A HREF=# class=loc>Ŀ�´�Ƽ</A> > 
          		        <span class=locon>���� ������</span>
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
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>���� ������</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
							<table width=100% border=0 cellspacing=0 cellpadding=0>
							  <tr>
								<td>
								 <!-- ��ȣ : <%=list_num%>&nbsp;&nbsp; -->
								 ����� : <%=regdate%>&nbsp;&nbsp;
								 ��ȸ : <%=read_num%>&nbsp;&nbsp;
								 �Խû��� : 
								 <% if(status.equals("0")){%>
										����
								 <% }else if(status.equals("1")){%>
										������
								 <% }else if(status.equals("2")){%>
										����
								 <% }%>
								</td>
							  </tr>
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
                             	<td align=left>
                                
								
								<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=���� class=btn onclick="javascript:data_update();"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
								<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=���� class=btn onclick="javascript:data_del();"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
								<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=��� class=btn onclick="location.href='tour_sympathy.jsp?page=<%=requestedPage%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
                             	</td>
                             	<td align=right>
								  <%if(prev_board_seq > 0){%>
								  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=���� class=btn onclick="javascript:location.href='tour_sympathy_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%>&list_num=<%=list_num%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>&nbsp;
								  <% } %>
								  <%if(next_board_seq > 0){%>
								  <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=���� class=btn onclick="javascript:location.href='tour_sympathy_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%>&list_num=<%=list_num%><%=key_str%>'"><img src=../img/tour_img/btn_r.gif align=absmiddle>   
								  <% } %>
                             	</td>
                             </tr>
                			</table>
                           <br>
                           <FORM METHOD=POST  NAME=listForm encType="multipart/form-data" ACTION="tour_sympathy.jsp">
							<INPUT TYPE="hidden" name="allCheck" value="0">
							<INPUT TYPE="hidden" name="check_y_seq" value="">
							<INPUT TYPE="hidden" name="cmd" value="">
							<INPUT TYPE="hidden" name="comment_seq">
							<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
							<INPUT TYPE="hidden" name="subrequestedPage" value="<%=subrequestedPage%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="subpart" value="<%=subpart%>">
							<INPUT TYPE="hidden" name="subkeyword" value="<%=subkeyword%>">
							<INPUT TYPE="hidden" name="delcount">
							<INPUT TYPE="hidden" name="list_num" value="<%=list_num%>">
                           <table width="100%" border="0" cellspacing="0" cellpadding="0">
                           	<tr><td colspan=6 height=2 class=linec1></td></tr>
                           	<tr height=28 align=center>
                                <td class=th><input type=checkbox name="check_yn1" onclick="javascript:colCheck();"></td>
                                <td class=th>��ȣ</td>
                                <td class=th>����</td>
                                <td class=th>�����</td>
                                <td class=th>�ۼ���</td>
                                <td class=th>Best</td>
                           	</tr>
                           	<tr><td colspan=6 height=1 class=linec1></td></tr>
							<% 
							//out.println(list.size());
							if(record.length <= 0){ %>	
							
							<tr align=center height=28 align=center height=35>
								<td colspan="6" align="center" height="30">����Ÿ�� �������� �ʽ��ϴ�.</td>
							</tr>
							<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
							}else{
								//����Ʈ ȭ�鿡 ����
								for(int i=0;i<record.length; i++){ 
									Tbrd_comment_de_bean tbean = record[i];
									comment_seq			= tbean.getComment_seq();
									//board_seq			= tbean.getBoard_seq();
									title				= tbean.getTitle(); 
									content				= tbean.getContent(); 
									user_nick			= tbean.getUser_nick(); 									
									user_id				= tbean.getUser_id();
									isbest				= tbean.getBest().trim();
									
									
									
									java.util.Date writeday = tbean.getReg_date();
									String reg_date_string = tbean.getReg_date_String();
									
							%>

                           	<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type=checkbox name="check_yn" value="<%=comment_seq%>"></td>
                                <td><%=BoardUtil.getNum(allCount,subrequestedPage,rowsPerPage,(i+1))%></td>
                                <td><%=content%></td>
                                <td><%=reg_date_string%></td>
                                <td><%=user_nick%>(<%=user_id%>)</td>
                                <td><input type=checkbox name="isbest" value="<%=comment_seq%>" <%if(isbest.equals("1")){%>checked<%}%> onClick="chkisbest(this);"></td>
                           	</tr>
                           	<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
								isbest = "";
								}
							}

							%> 	
                           </table>
                           </FORM>
                           <table width=100% border=0 cellspacing=0 cellpadding=0>
                           	<tr>
                                 <td width=50%></td>
                                 <td align=center>
                                   <!--����¡ -->
                                   <table width=600 border=0 cellspacing=0 cellpadding=0>
                                    <tr>
                           	        <td align=center>
                           	        <%=HtmlUtil.doPageCut(subrequestedPage, pageCount , position , 
			                      "tour_sympathy_view.jsp", "500", subkey_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
                                       </td>
                                    </tr>
                                   </table>
                                   <!--����¡ -->
                                 </td>
                                 <td width=50% align=right></td>
                           	</tr>
                           </table>
						   <table width=100% border=0 cellspacing=0 cellpadding=0>
                           <tr>
								<td>
									<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=���û��� onclick="javascript:colDel();" class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								</td>
							</tr>
							</table>


                           <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                           <table width=100% border=0 cellspacing=0 cellpadding=0>
                           <tr>
                           	<td align=right>
                           		<table border=0 cellspacing=0 cellpadding=0>
                           		<FORM METHOD=POST ACTION="tour_sympathy_view.jsp">
								<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
								<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
								<INPUT TYPE="hidden" name="part" value="<%=part%>">
								<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
                           		<tr>
                           		  <td width="130">
                                    <select name="subpart" style='width:80;'>
                           			<option value='3'>���̵�</option>
                           			<option value='2'>�̸�</option>
                           			</select>
                                     </td>
                                     <td class="dblue rpad5">
                                     <input type=text style='width:200;' name="subkeyword">
                                     <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=submit value="�˻�" class="btn" onfocus="this.blur();"><img src=../img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                     <td>                                  
                           		</tr>
                           		</FORM>
                           		</table>
                           	</td>
                           </tr>
                           <tr><td height=6></td></tr>
                           </table> 
                
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
<FORM METHOD=POST  NAME=delForm encType="multipart/form-data" ACTION="tour_sympathy_ok.jsp">
<INPUT TYPE="hidden" name="cmd" value="del">
<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<INPUT TYPE="hidden" name="part" value="<%=part%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="subpart" value="<%=subpart%>">
<INPUT TYPE="hidden" name="subkeyword" value="<%=subkeyword%>">
<INPUT TYPE="hidden" name="subrequestedPage" value="<%=subrequestedPage%>">
<INPUT TYPE="hidden" name="list_num" value="<%=list_num%>">
</FORM>
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
