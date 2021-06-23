<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPraise"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%> 
<%@ page import="java.util.*"%>

<%
//���� ����
int board_seq			= 0;
int ref_no				= 0; 
int level_no			= 0;
int sort_no				= 0;
int read_num			= 0;
String title			= ""; 
String content			= "";
String user_nick		= "";
String user_name		= "";
String use_yn			= "";
String user_level		= "";
int board_top_no		= 0;
String user_id			= "";
int recomm_num			= 0;
int comment_num			= 0;
String isbest			= "";

int pageSize			= 10;
int blockSize			= 10;


String McNum = "5";
String sub = "3";
String pageNum = "3";
String subNum = "1";

//�Խ��� Ÿ�԰���
String boardType	= "03";
// DB���� ��ü(ibatis���)  
TourPraise dao = new TourPraise();
CommonBoard commonDao = new CommonBoard();


// �˻� - �÷���
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// �˻� - �˻���
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));
// �˻� - �Ķ����
String key_str = "&part="+part+"&keyword="+keyword;

//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// ��ü �Խù� ��
int allCount = commonDao.getTotalCount(boardType, part,keyword);

// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getAdminList(requestedPage, pageSize, part, keyword );

// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function chk(){
	
	var obj = document.f1;

	var id = "<%=session_id%>";

	if(id == ""){
		//alert("�α����� �ʿ��� �����Դϴ�.");
		popLogin();
		return;
	}
	
	if(obj.title.value == "" || obj.title.value == "OOO�� Ī���մϴ�~" ){
		alert("Ī���� ����� �Է��ϼ���.");
		obj.title.value = "";
		obj.title.focus();
		return;
	}

	if(obj.content.value == "" || obj.content.value == "Ī�� �Ѹ���� 500�� �̳��� ��� �� �� ������ �α��� �� �̿��Ͻñ� �ٶ��ϴ�."){
		alert("Ī�������� �Է��ϼ���.");
		obj.content.value = "";
		obj.content.focus();
		return;
	}

	obj.submit();
}	

function clearText(thefield){
    if (thefield.defaultValue==thefield.value)
        thefield.value = ""
}

function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}

//-->
</SCRIPT>
</head>

<body>


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/community/tour_gallery_left.jsp" %>
            <!--  left menu flash -->
            </td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">Ī���ϱ�</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="23"></td></tr>
				<tr>
					<td>
						<table width="690" height="153" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm31.jpg');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/community/stit_comm03.gif" hspace="5"></td></tr>
						</table>
						<table width="690" height="146" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm32.jpg');fixed no-repeat left top;">
						<FORM METHOD=POST name="f1" ACTION="praise_ok.jsp">
						<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
						<INPUT TYPE="hidden" name="part" value="<%=part%>">
						<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
						<INPUT TYPE="hidden" name="cmd" value="insert">
						<tr>
							<td valign="top">
								<table width="457" cellpadding="0" cellspacing="0" border="0" style="margin:18 0 0 31px;">
								<tr>
									<td width="62"><img src="<%=imageServer%>/tour_img/community/txt_praise01.gif"></td>
									<td width="339"><input type="text" name="title" style="width:328px;" class="input05" value="OOO�� Ī���մϴ�~" onFocus="clearText(this)"></td>
									<td width="56"></td>
								</tr>
								<tr><td colspan="3" height="7"></td></tr>
								<tr>
									<td><img src="<%=imageServer%>/tour_img/community/txt_praise02.gif"></td>
									<td><textarea name="content" style="width:328px;height:79px;overflow:auto;" class="textarea05" onFocus="clearText(this)">Ī�� �Ѹ���� 500�� �̳��� ��� �� �� ������ �α��� �� �̿��Ͻñ� �ٶ��ϴ�.</textarea></td>
									<td>
									
									  <!--  <img src="<%=imageServer%>/tour_img/btn/btn_comm_praise.gif" width="56" height="56" onClick="javascript:chk();" style="cursor:hand"><!-- Ī���ϱ� -->
									
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</FORM>
						</table>
					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="370"><col width="80"><col width="90"><col width="45"><col width="45">
						<tr><td height="2" colspan="6" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- ��ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt10.gif"><!-- Ī���һ�� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt03.gif"><!-- �ۼ��� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt04.gif"><!-- �ۼ��� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- ��ȸ�� --></td>							
						</tr>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						<% 
						//out.println(list.size());
						if(record.length <= 0){ %>	
						
						<tr>
							<td colspan="5" align="center" height="30">����Ÿ�� �������� �ʽ��ϴ�.</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						<%
						}else{
							//����Ʈ ȭ�鿡 ����
							for(int i=0;i<record.length; i++){ 
								Tbrd_board_ma_bean tbean = record[i];
								
								board_seq			= tbean.getBoard_seq();
								ref_no				= tbean.getRef_no(); 
								level_no			= tbean.getLevel_no(); 
								sort_no				= tbean.getSort_no(); 
								read_num			= tbean.getRead_num(); 
								//title				= StringUtil.textToHtml(tbean.getTitle() );//�̰͵� ����
								title				= clearXSS(tbean.getTitle(),avatag );
								content				= tbean.getContent(); 
								user_name			= tbean.getUser_name(); 
								use_yn				= tbean.getUse_yn(); 
								user_level			= tbean.getUser_level(); 
								board_top_no		= tbean.getBoard_top_no(); 
								user_id				= tbean.getUser_id();
								recomm_num			= tbean.getRecomm_num();
								comment_num			= tbean.getComment_num();
								isbest				= tbean.getBest().trim();
								
								String bgline = "";
								if((i+1) == record.length){
									bgline = "line_dg";	
								}else{
									bgline = "line_g2";	
								}
								
								java.util.Date writeday = tbean.getReg_date();
								String reg_date_string = tbean.getReg_date_String();
								String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer+"/");
								String new_img	= BoardUtil.getNewArticle(writeday,imageServer+"/");
						%>		
						<tr align="center">
							<td height="26"><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td align="left" class="tpad_3 lpad_10">
							<a href="praise_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt05"><%=Util.getStringLimit((title).trim(),30)%> (<%=comment_num%>) </a><%=new_img%>
							</td>
							<td><%=reg_date_string%></td>
							<td><%=user_name%>(<%=user_id%>)</td>
							<td><%=read_num%></td>							
						</tr>
						<tr><td height="1" colspan="6" class="<%=bgline%>"></td></tr>
						<%
							}
						}
						
						%>	
						
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "praise_list.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%></td>
						</tr>
						</table>
						<!-- paging/ -->
                        					
						<!-- /search -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<FORM METHOD=POST ACTION="praise_list.jsp">
						<tr>
							<td align="center">
									<!-- <select>
										<option>����</option>
										<option>����</option>
										<option>�ۼ���</option>
									</select> -->
									 <select name="part">
									  <option value=''>����</option>
									  <option value="1" <%if(part.equals("1")){%>selected<%}%>>����</option>
									  <option value='2' <%if(part.equals("2")){%>selected<%}%>>�̸�</option>
									  <option value='3' <%if(part.equals("3")){%>selected<%}%>>���̵�</option>
									</select>
									<input type="text" name="keyword" style="width:140px;"><input type="image" src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"><!--�˻�--></td>
						</tr>
						</FORM>
						</table>
						<!-- search/ -->
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->       
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>