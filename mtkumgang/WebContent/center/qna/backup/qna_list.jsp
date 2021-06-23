<%--
  - �ۼ���: ������
  - ����: 2006.06.07
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>������ϱ� ����Ʈ
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%


//���� ����
int board_seq			= 0;
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		= "";
String type_code  = "";
String type_name = "";
String use_yn			= "";
String user_id		= "";
int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType	= "06";
String open_yn = "0";
String reply_yn = "0";
String user_name ="";
// DB���� ��ü
QnABoard dao = new QnABoard();
CommonBoard commonDao = new CommonBoard();




// �˻� - �÷���
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// �˻� - �˻���
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword"));
// �˻� - �Ķ����
String key_str = "&part="+part+"&keyword="+keyword;
//���ļ���
String orderBy    = ParamUtil.getReqParameter(request.getParameter("orderBy"));

//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// ��ü �Խù� ��
int allCount = dao.getFrontTotalCount(part,keyword);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
//������ ������
String page_str = "&requestedPage="+requestedPage+"&position="+position;
// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getFrontList(rowsPerPage, requestedPage, part, keyword, orderBy );





//out.println("key_str: "+key_str);


//out.println("allCount: "+allCount);
//out.println("pageCount: "+pageCount);
//out.println("dataNum: "+dataNum);

%>

<HTML>
<HEAD>
<title></title>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>



<script language="javascript">

function openSch(){
   var form = document.frm;
   if (form.schVal.value == "Ű���带 �Է��ϼ���"){
      form.schVal.value="";
   }
   form.submit();
}



function goSearch(){
	f = document.searchForm;
	//alert();
	if(f.part.value == ""){
	    alert ("�˻� ������ �������ּ���");
		f.part.focus();
		return;
	}

	f.submit();
}


function getXMLHttpRequest() {
	if (window.ActiveXObject) {
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch(e) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch(e1) { return null; }
		}
	} else if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}
var httpRequest = null;

function sendRequest(url, params, callback, method) {
	httpRequest = getXMLHttpRequest();
	var httpMethod = method ? method : 'GET';
	if (httpMethod != 'GET' && httpMethod != 'POST') {
		httpMethod = 'GET';
	}
	var httpParams = (params == null || params == '') ? null : params;
	var httpUrl = url;
	if (httpMethod == 'GET' && httpParams != null) {
		httpUrl = httpUrl + "?" + httpParams;
	}
	httpRequest.open(httpMethod, httpUrl, true);
	httpRequest.setRequestHeader(
		'Content-Type', 'application/x-www-form-urlencoded');
	httpRequest.onreadystatechange = callback;
	httpRequest.send(httpMethod == 'POST' ? httpParams : null);
}


function isOwn(passConfirmNum){
	f = document.mainForm;
	var element = document.getElementById(passConfirmNum);
	
	if (element) {
		//alert(""+element.style.display);
		if(element.style.display == ''){
			element.style.display = 'none';
		}else{
            element.style.display = '';
		}
	}

}

var global_board_seq = "";

function goPassAsk(board_seq){
    var passAsk = document.getElementById('passAsk'+board_seq);
	global_board_seq =board_seq;
	//alert("global_board_seq==>"+global_board_seq);
	//alert("passAsk.value==>"+passAsk.value);
	if(passAsk.value != null){
	   //alert("sendRequest go-->"+"okPass.jsp?board_seq="+board_seq+"&password="+passAsk.value);
	   sendRequest("okPass.jsp?board_seq="+board_seq+"&password="+passAsk.value,null,okPass,"Get");
	   //alert("sendRequest  end ");
	}
}


function okPass() {
	var resultValue = '0';
	f = document.mainForm;
	    //alert("okPass  go--> ");
		if (httpRequest.readyState == 4) {
			   if (httpRequest.status == 200) {
				    var xmlDoc = httpRequest.responseXML;
					var passList = xmlDoc.getElementsByTagName("passYn");
					for (var i = 0 ; i < passList.length ; i++) {
						var pass = passList.item(i);
						resultValue = pass.getElementsByTagName("result").item(0)
											 .firstChild.nodeValue;
						
						   //alert("resultValue="+resultValue);
						   if(resultValue=='1'){
							   f.action = "qna_view.jsp?board_seq="+global_board_seq+"<%=key_str%><%=page_str%>";
							    //alert("action="+f.action);
							   f.submit();
							}else{
							   alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
							}
					}
				}
				//alert(message);
		}


}


	


</script>
</HEAD>
<body>


   <TABLE cellspacing=0 cellpadding=0 width=650>
		<TR valign=top>
			<!-- main -->
			<TD width=650 valign=top>
				<table width=650 border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td class='title'><img src='<%=imageServer%>tour_img/bu_blue_title.gif' align=texttop class=rmar10>������ϱ�</td>
						</tr>
						</table>
						<br>
						<FORM METHOD=POST NAME=mainForm ACTION="qna_list.jsp">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<col width=10%>
							<col width=50% style='padding:5 3 3 3;'>
							<col width=20%>
							<col width=10%>
							<col width=10%>
							<tr><td colspan=5 height=2 class=linec1></td></tr>
							<tr height=28 align=center>
                             <td class=th>��ȣ</td>
                             <td class=th>����</td>
                             <td class=th>�ۼ���</td>
                             <td class=th>�����</td>
                             <td class=th>��ȸ��</td>
							</tr>
							<tr><td colspan=5 height=1 class=linec1></td></tr> 
							<% 
								//out.println(list.size());
								if(record.length <= 0){ %>	
								<tr align=center height=28 align=center height=35>
									<td colspan="6" align="center" height="30">����Ÿ�� �������� �ʽ��ϴ�.</td>
								</tr>
								<tr>
								    <td colspan="6" height=1 class=linec1></td>
							    </tr>
							<%
								}else{
									//����Ʈ ȭ�鿡 ����
									for(int i=0;i<record.length; i++){ 
										Tbrd_board_ma_bean tbean = record[i];
										board_seq			= tbean.getBoard_seq();
										read_num			= tbean.getRead_num(); 
										title				= tbean.getTitle(); 
										use_yn				= tbean.getUse_yn(); 
										user_id				= tbean.getUser_id();
										user_name           = tbean.getUser_name();
										open_yn				= tbean.getOpen_yn();
										reply_yn				= tbean.getReply_yn();

                                        String open_yn_name = "�����";
										String reply_yn_name = "";
										String reg_date_string = tbean.getReg_date_String();
										String new_img	= BoardUtil.getNewArticle( tbean.getReg_date(),imageServer);
										
										
										if(open_yn.equals("1")){open_yn_name="����";}
										if(reply_yn.equals("1")){reply_yn_name="<font color=red>�亯�Ϸ�</font>";}  
							           
                                         //�����ڿ� ���ؼ� ���� �Ǿ�����
							            if(use_yn.equals("0")){
										    reg_date_string ="";
										}
                                        
										//����� ���϶�
                                        if(open_yn.equals("0")){
										   //�۾��̰� �α��� �� ����� �ƴҶ�
										   if(user_id.equals(session_id)){
										   }
										} //if(open_yn.equals("1")) END
										int listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));
							 %>
						   
											<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
												   <td><%=listNum%></td>

													   <!-- �����ڿ� ���� ������ ���϶�  ==>�����Ǿ����ϴ� ��Ʈ ���� -->
												   <td><%if(use_yn.equals("0")){%> 
															�����ڿ� ���ؼ� �����Ǿ����ϴ�.
														<!--�����:O -->
													   <%}else if(open_yn.equals("0") ){ %>
													       <!-- ȸ���̾���:X  OR  �ڱ��:X   ==> �н����� Ȯ���� ����   -->
														   <%if(user_id.equals("") || !user_id.equals(session_id) ){%>
																<a href="javascript:isOwn('passConfirm<%=listNum%>')">
																	<%=Util.getStringLimit(title,30)%> &nbsp;<font color=green>�����</font>
																</a>
																<div id=passConfirm<%=listNum%> style="display:none;">
																    ��й�ȣ:<input type=text name="passAsk<%=board_seq%>" id="passAsk" value="">
																	<a href="javascript:goPassAsk('<%=board_seq%>')">Ȯ��</a> 
																</div>
													       <!--ȸ���̾���:O AND �ڱ��:O-->
														   <%}else{%>
                                                                  <a href="qna_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><%=Util.getStringLimit(title,30)%> &nbsp;<font color=green>�����</font> </a>&nbsp;<%=reply_yn_name%>
														   <%}%>
													   <%}else{%>
														  <a href="qna_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><%=Util.getStringLimit(title,30)%></a>&nbsp;<%=reply_yn_name%>
													   <%}%>
												    
												   </td>
												   <td><%if(use_yn.equals("0")){%>
													   <%}else{%>
													       <!--id �������-->
														   <%if(!user_id.equals("")){%>
															    <%=user_name%>(<%=user_id%>)
															<%}else{%>
																<%=user_name%>
															<%}%>
														  
														<%}%>
												   </td>
												   <td><%=reg_date_string%></td>
												   <td><%if(use_yn.equals("0")){%><%}else{%><%=read_num%><%}%></td>
					  
											</tr>
											<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
										
									}  //for END
								} //if(record.length <= 0) END
								
							%>
          					
          					<tr><td colspan=6 height=1 class=linec1></td></tr>	
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
          						       <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "qna_list.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
                                           </td>
                                        </tr>
                                       </table>
                                <!--����¡ -->
                              </td>
                              <td width=50% align=right></td>
							</tr>
						</table>
                       
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>                   
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
                          <td align=right>
                          <!--�˻� START -->
							  <FORM METHOD=POST NAME=searchForm ACTION="qna_list.jsp">
          						<table border=0 cellspacing=0 cellpadding=0>
          						<tr>
                                        <td width="100" align=center>
                                          <select name="part" style='width:80;'>
                                          <option <%if(part.equals("")){%>selected<%}%> value=''>���ļ���</option>
                                          <option <%if(part.equals("1")){%>selected<%}%> value='1'>����</option>
                                          <option <%if(part.equals("2")){%>selected<%}%> value='2'>�̸�</option>
                                          <option <%if(part.equals("3")){%>selected<%}%> value='3'>���̵�</option>
                                          </select>
                                        </td>                                  
                                        <td class="dblue rpad5">
                                        <input type=text style='width:200;' name="keyword" value="<%=keyword%>" >
                                        <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value="�˻�" class="btn" onclick="goSearch()" onfocus="this.blur();"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
										</td>
                                                                          
          						</tr>
          						</table>
							  </FORM>
							  <!--�˻� END -->                 
                          </td>
						</tr>
						<tr><td height=6></td></tr>
					   </table>  
					   

					   <table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�����ϱ� class=btn onclick="location.href='qna_edit.jsp'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>
                                 </td>
                				</tr>
                	   </table>
					 </td>
				   </tr>
				</table>
			 </TD>
			<!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>