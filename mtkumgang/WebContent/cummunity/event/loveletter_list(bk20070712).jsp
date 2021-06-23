<%-- 
  - �ۼ���: �ɵ���
  - ����: 2007.04.27
  - ���� ������ : 
  - ���۱� ǥ��: 
  - ����: �̺�Ʈ - ����� ���� �Խ���
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourLove"%>
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

//�Խ��� Ÿ�԰���
String boardType= "13";		//����� ����=="13"
String McNum = "5";
String sub = "2";
String pageNum = "2";
String subNum = "2";

// DB���� ��ü(ibatis���)  
TourLove dao = new TourLove();
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
int allCount = commonDao.getFrontTotalCount(boardType, part,keyword);

// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getFrontList(requestedPage, pageSize, part, keyword );

// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


Tbrd_board_ma_bean best_record[] = dao.getBestList();

String best_title	= "";
String best_content = "";

if(best_record.length > 0 ){
	Tbrd_board_ma_bean bestbean = best_record[0];
	best_title		= bestbean.getTitle();
	best_content	= bestbean.getContent();
}


%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<script language="javascript">
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "Ű���带 �Է��ϼ���"){
      form.schVal.value="";
   }
   form.submit();
}

function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}
</script>

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
						<td height="54"><img src="<%=imageServer%>/tour_img/event/s_event_1_1title.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#">�̺�Ʈ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">����� ���� </span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				  </tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

<map name="Map">
	<area shape="rect" coords="395,15,495,36" href="javascript:document.location.href='prevent_list.jsp';"><!-- �����̺�Ʈ���� -->
</map>


				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_1.jpg" border="0" usemap="#Map"></td>
				</tr>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td width="496" height="25" valign="top"><img src="<%=imageServer%>/tour_img/com/0_px.gif" width="8" height="1"><img src="<%=imageServer%>/tour_img/event/s_event_1_love_stitle_1.gif"></td>
								<td width="194"><img src="<%=imageServer%>/tour_img/event/s_event_1_bigtitle_2.gif"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="370"><col width="80"><col width="90"><col width="45"><col width="45">
						  <tr>
							<td height="2" colspan="6" class="line_dg"></td>
 						  </tr>
						  <tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- ��ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- ���� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt03.gif"><!-- �ۼ��� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt04.gif"><!-- �ۼ��� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- ��ȸ�� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt06.gif"><!-- ��õ�� --></td>
						  </tr>
						  <tr><td height="1" colspan="6" class="line_dg"></td></tr>
           <% if(record.length <= 0){ %>							
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						<tr align="center" ><td colspan="6" >��ϵ� �����Ͱ� �����ϴ�.</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						
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
           		title				= tbean.getTitle(); 
           		content				= tbean.getContent(); 
           		user_name			= tbean.getUser_name(); 
           		use_yn				= tbean.getUse_yn(); 
           		user_level			= tbean.getUser_level(); 
           		board_top_no		= tbean.getBoard_top_no(); 
           		user_id				= tbean.getUser_id();
           		recomm_num			= tbean.getRecomm_num();
           		comment_num			= tbean.getComment_num();
           		isbest				= tbean.getBest().trim();
           		use_yn				= tbean.getUse_yn().trim();
           		
           		
           		java.util.Date writeday = tbean.getReg_date();
           		String reg_date_string = tbean.getReg_date_String();
           		String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
           		String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
           		int listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));
           %>						
						<tr align="center">
							<% if(use_yn.equals("0")){ %>
								<td colspan="6" align="center" class="tpad_3 lpad_10">�����ڿ� ���� �����Ǿ����ϴ�.</td>
							<% }else{ %>
								<td height="26">
								<% if(isbest.equals("1")){ %>							
								   <img src="<%=imageServer%>/tour_img/bu/ico_best.gif">
								<% }else{ %>
									<%=listNum%>
								<% } %>	
								</td>
								<td align="left" class="tpad_3 lpad_10">
								<%=re_img%>
								<a href="loveletter_read.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%>&listnum=<%=listNum%><%=key_str%>" class="listtxt05"><%=Util.getStringLimit((title).trim(),30)%>(<%=comment_num%>)</a><%=new_img%>
								</td>
								<td>
								   <%=reg_date_string%>
								</td>
								<td>
								   <%=user_id%>				
								</td>
								<td>
								   <%=read_num%>			
								</td>
								<td>
								  <%=recomm_num%>				
								</td>
							<% } %>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
                        <%
                        	}
                        }
                        %>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td width="30%"></td>
							<td width="40%" align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "loveletter_list.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
			                </td>
							<td width="30%" align="right">
							<% if(!session_id.equals("")){ %>
							   <a href="loveletter_edit.jsp"><img src="<%=imageServer%>/tour_img/event/s_event_1_lovego_bt.gif" hspace="5"></a>
						    <% }else{ %>
                               <a href="javascript:;" onclick="javascript:popLogin()"><img src="<%=imageServer%>/tour_img/event/s_event_1_lovego_bt.gif" hspace="5"></a>
                            <%}%>
							</td>
						</tr>
						</table>
						<!-- paging/ -->
                        			
						<!-- /search -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr>
							<td align="center">
                                <select name="part">
                                  <option value=''>����</option>
                                  <option value="1" <%if(part.equals("1")){%>selected<%}%>>����</option>
                                  <option value='2' <%if(part.equals("2")){%>selected<%}%>>�̸�</option>
                                  <option value='3' <%if(part.equals("3")){%>selected<%}%>>���̵�</option>
                                </select>
									<input type="text" style="width:140px;" name="keyword"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--�˻�--></td>
						</tr>
						</table>
</FORM>						
						<!-- search/ -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="32"></td></tr>
						</table>						
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