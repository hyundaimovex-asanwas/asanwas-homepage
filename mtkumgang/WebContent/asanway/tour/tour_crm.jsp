<%--
  - �ۼ���: ������
  - ����: 2006.05.03
  -������: �̼ҿ� (2006.8)
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ������>�Ź���
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CrmBoard"%>
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
String user_name		= "";
int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType	= "14";
String open_yn = "0";
String reply_yn = "0";

// DB���� ��ü
CrmBoard dao = new CrmBoard();
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
int allCount = dao.getTotalCount(part,keyword);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword, orderBy );

%>

<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSearch(){
	f = document.searchForm;
	f.submit();
}

function goOrderBy(){
	f = document.mainForm;
	f.submit();
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
          	        <TD colspan=2 height=50 align=right style='padding-top: 10'>
          	        <img src="<%=imageServer%>/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>Ȩ</A> > 
          	        <A HREF=# class=loc>������</A> > 
          	        <span class=locon>�Ź���</span>
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
          					<td class='title'><img src='<%=imageServer%>/tour_img/bu_blue_title.gif' align=texttop class=rmar10>�Ź���</td>
          				</tr>
          				</table>
          				<br>
						<FORM METHOD=POST name="mainForm" ACTION="tour_crm.jsp" >
          				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<col width=10%>
          					<col width=40% style='padding:5 3 3 3;'>
          					<col width=20%>
          					<col width=10%>
          					<col width=10%>
          					<col width=10%>
          					<tr><td colspan=6 height=2 class=linec1></td></tr>
          					<tr height=28 align=center>
                                   <td class=th>��ȣ</td>
                                   <td class=th>����</td>
                                   <td class=th>�ۼ���</td>
                                   <td class=th>�����</td>
                                   <td class=th>��������</td>
                                   <td class=th>
                                          <select name="orderBy" style='width:80;' onChange="javascript:goOrderBy()">
                                          <option value=''>�亯����</option>
                                          <option value='replyY'>Y</option>
                                          <option value='replyN'>N</option>
                                          </select></a></td>
          					</tr>
          					<tr><td colspan=6 height=1 class=linec1></td></tr> 
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
										String reply_yn_name = "N";
										String reg_date_string = tbean.getReg_date_String();
										String new_img	= BoardUtil.getNewArticle( tbean.getReg_date(),imageServer);
										if(open_yn.equals("1")){open_yn_name="����";}
										if(reply_yn.equals("1")){reply_yn_name=reg_date_string;}
							            
                                                        %>
						   
										<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
											   <td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
											   <td align="left">
											       <%if(use_yn.equals("0")){%>
												      <a href="tour_crm_edit.jsp?board_seq=<%=board_seq%>"><%=Util.getStringLimit(title,15)%></a> &nbsp;<font color=red>�����ȰԽù�</font>
												   <%}else{%>
												       <a href="tour_crm_edit.jsp?board_seq=<%=board_seq%>"><%=Util.getStringLimit(title,30)%></a>
												   <%}%>
											   </td>
											   <td>
									                   <%
									                   if(!user_id.equals("")){
									                        out.println(user_name+"("+user_id+")");
									                   }else{
									                        out.println(user_name);
									                   }
									                   %>
											   </td>
											   <td><%=reg_date_string%></td>
											   <td><%=open_yn_name%></td>
											   <td><%if(reply_yn.equals("0")){%>
													   <font color=red> <%=reply_yn_name%> </font>
													<%}else{%>
														  <%=reply_yn_name%>
													<%}%>
													 
												</td>
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
			                      "tour_crm.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
                                           </td>
                                        </tr>
                                       </table>
                                      <!--����¡ -->
                                    </td>
                                    <td width=50% align=right></td>
          					</tr>
          					
          				</table>
                              <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          				<tr>
          					<td align=right>
							<!--�˻� START -->
							  <FORM METHOD=POST NAME=searchForm ACTION="tour_crm.jsp">
          						<table border=0 cellspacing=0 cellpadding=0>
          						<tr>
                                        <td >
                                          <select name="part" style='width:80;'>
                                          <option <%if(part.equals("")){%>selected<%}%> value=''>�˻�����</option>
                                          <option <%if(part.equals("1")){%>selected<%}%> value='1'>����</option>
                                          <option <%if(part.equals("2")){%>selected<%}%> value='2'>�̸�</option>
                                          <option <%if(part.equals("3")){%>selected<%}%> value='3'>���̵�</option>
                                          </select>
                                        <input type=text style='width:200;' name="keyword" value="<%=keyword%>" >
                                        <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value="�˻�" class="btn" onclick="goSearch()" onfocus="this.blur();"><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
										</td>
                                                                          
          						</tr>
          						</table>
							  </FORM>
							  <!--�˻� END -->
          					</td>
          				</tr>
          				<tr><td height=6></td></tr>
          				</table>                        
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
