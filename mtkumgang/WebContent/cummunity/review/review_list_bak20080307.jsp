<%-- 
  - �ۼ���: �ڻ��
  - ����: 2006.05.26
  - ���� ������ : �̼ҿ� (2006.07)
  - ���۱� ǥ��: IMJ Korea 
  - ����: ������ - �����ı� �Խ���
--%>
  

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourReview"%>
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
String boardType	= "01";

String McNum = "5";
String sub = "1";
String pageNum = "1";
String subNum = "0";

 
// DB���� ��ü(ibatis���)  
TourReview dao = new TourReview();
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ�´�Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�����ı�</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" height="284" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm01.jpg');fixed no-repeat left top;">
						<tr>
							<td align="right" valign="bottom" class="rpad_15 bpad_15">
								<table width="515" height="115" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td valign="top">
										<table width="515" cellpadding="0" cellspacing="0" border="0">
										<col width="45"><col width="340"><col width="130">
<% if(best_record.length > 0 ){ %>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/ico_best2.gif"></td>
											<td class="tpad_5">
												<span class="b fs14 txt_lpurple2"><%=best_title%></span>
												<!--<br>
												<img src="<%=imageServer%>/tour_img/bu/bu_gray_rec.gif" vspace="3" hspace="3"><span class="fs11 txt_lpurple">��ȸ123</span>
												<img src="<%=imageServer%>/tour_img/bu/bu_gray_rec.gif" vspace="3" hspace="3"><span class="fs11 txt_lpurple">��õ123</span>-->
											</td>
											<td></td>
										</tr>
										<tr>
											<td colspan="3" class="tpad_5 lpad_5 txt_lpurple">
											<%=best_content%>
											<!--<br>������ / 05.12.01-->
											</td>
										</tr>
<% }else{ %>
										<tr valign="top">
											<td><img src="<%=imageServer%>/tour_img/bu/ico_best2.gif"></td>
											<td class="tpad_5">
												������ ����Ʈ�ıⰡ �����ϴ�.
											</td>
											<td></td>
										</tr>
										<tr>
											<td colspan="3" class="tpad_5 lpad_5 txt_lpurple">&nbsp;</td>
										</tr>
<% } %>											
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="15" valign="bottom" align="right"><img src="<%=imageServer%>/tour_img/community/txt_tip_comm01.gif"></td></tr>
				<tr><td height="15"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/community/stit_comm01.gif" hspace="5"></td></tr>
				<tr><td height="12"></td></tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="370"><col width="80"><col width="90"><col width="45"><col width="45">
						<tr><td height="2" colspan="6" class="line_dg"></td></tr>
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
								<!--<td colspan="6" align="center" class="tpad_3 lpad_10">�����ڿ� ���� �����Ǿ����ϴ�.</td>-->
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
								<a href="review_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%>&listnum=<%=listNum%><%=key_str%>" class="listtxt05"><%=Util.getStringLimit((title).trim(),30)%>(<%=comment_num%>)</a><%=new_img%>
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
			                      "review_list.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
			                </td>
							<td width="30%" align="right">
							<% if(!session_id.equals("")){ %>
							   <a href="review_edit.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_travelwrite.gif" hspace="5"></a>
						    <% }else{ %>
                               <a href="javascript:;" onclick="javascript:popLogin()"><img src="<%=imageServer%>/tour_img/btn/btn_comm_travelwrite.gif" hspace="5"></a>
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