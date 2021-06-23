<%-- 
  - �ۼ���: �̼ҿ�
  - ����: 2006.06.13
  - ���۱� ǥ��: IMJ Korea
  - ����: ����Ʈ - �ݰ��� �˾ƺ���>PR Room ����Ʈ
--%> 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%> 
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrRoom"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%

//���� ����
int board_seq			= 0;
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		    = "";
String type_code        = "";
String type_name        = "";
String use_yn			= "";
String user_id		    = "";
String user_name		= "";
String thumbnail_virtual_name	= "";
String thumbnail_real_name		= "";
String virtual_name	= "";
String real_name		= "";
String regdate			= "";
int pageSize			= 6;
int blockSize			= 10;

String pageNum = "4";
String McNum = "1";
String sub = "4"; 
  

//�Խ��� Ÿ�԰���
String boardType	= "10";

// DB���� ��ü
TourPrRoom dao = new TourPrRoom();
CommonBoard commonDao = new CommonBoard();


// �˻� - �÷���
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// �˻� - �˻���
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword"));

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
int allCount = dao.getTotalCount(part,keyword);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword );

%>
<html>
<head>
<title> �ݰ������      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" >
<!--
// �̹���������°� �˾� ����
function popimage(imagesrc,winwidth,winheight){
	var look='width='+winwidth+',height='+winheight+','
	popwin=window.open("","",look)
	popwin.document.open()
	popwin.document.write('<html><link rel=STYLESHEET type=text/css href=<%=imageServer%>/tour_common/common.css><title>Image Window</title><body class=popmargin><table cellspacing=0 cellpadding=0 border=0 width=100%><tr><td width=100%><table cellspacing=0 cellpadding=0 border=0 width=100% height=65 class=bg_dgreen2><tr valign=top><td style=padding:20 0 0 20><img src=<%=imageServer%>/tour_img/preview/pop_tit_imgview.gif></td><td align=right style=padding:20 15 0 0><img src=<%=imageServer%>/tour_img/preview/pop_logo.gif></td></tr></table><table cellspacing=0 cellpadding=0 border=0 width=100%><tr><td height=29></td></tr><tr><td style=padding:0 5 0 5 align=center><img src=' + imagesrc + '></td></tr><tr><td height=22></td></tr><tr><td align=center><a href=javascript:; onclick=window.close();><img src=<%=imageServer%>/tour_img/btn/btn_pre_confirm.gif></a></td></tr><tr><td height=23></td></tr></table><table cellspacing=0 cellpadding=0 border=0 width=100% height=8 class=bg_dgreen2><tr><td></td></tr></table></td></tr></table></body></html>')
	popwin.document.close()
}

function goSearch(){
	f = document.searchForm;

	if(f.part.value==""){
		alert("�˻������� �����Ͽ� �ֽʽÿ�.");
		f.part.focus();
		return;
	}
	
	f.submit();
}

//-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/preview/tour_preview_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/preview/tour_preview_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview04.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">�ݰ��� �˾ƺ���</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">PR Room</span></td>
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
						<table width="690" height="158" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/preview/bg_top_pre04.jpg');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/preview/stit_preview04.gif" hspace="5"></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="201" class="tpad_20 bpad_25"><col width="43"><col width="201" class="tpad_20 bpad_25"><col width="44"><col width="201" class="tpad_20 bpad_25">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>

                 <% 						
                 if(record.length <= 0){ %>
                    <tr valign="top">
                      <td  colspan="5" >
                 	    <div align="center">��ϵ� �����Ͱ� �����ϴ�.</div>
                 	  </td>
                 	</tr>
                 	<tr><td height="1" colspan="5" class="line_dg"></td></tr>
                 <%
                 }else{
                 	int a_table = 0;
                 	//����Ʈ ȭ�鿡 ����
                 	for(int i=0;i<record.length; i++){ 
                 		Tbrd_board_ma_bean tbean = record[i];
                 		
                 		board_seq			= tbean.getBoard_seq();
                 		read_num			= tbean.getRead_num(); 
                 		title				= tbean.getTitle(); 
                 		content				= tbean.getContent();
                 		content				= content.replaceAll("\"", "'");
                 		regdate				= tbean.getReg_date_String();
                 		use_yn				= tbean.getUse_yn(); 
                 		thumbnail_virtual_name	    = ParamUtil.getReqParameter(tbean.getThumbnail_virtual_name());
                 		thumbnail_real_name			= ParamUtil.getReqParameter(tbean.getThumbnail_real_name());
                 		virtual_name	    = ParamUtil.getReqParameter(tbean.getVirtual_name());
                 		real_name			= ParamUtil.getReqParameter(tbean.getReal_name());                 		
                 		type_code           = tbean.getType_code().trim();
                 	    
                 		String thumbnail_img_name = "";
                 		String img_name = "";
                 		
                 		if(thumbnail_virtual_name.equals("")){
                 			thumbnail_img_name = imageServer+"noimage.gif";
                 		}else{
                 			thumbnail_img_name = thumbnail_virtual_name;	
                 		}
                 		
                 		if(virtual_name.equals("")){
                 			img_name = imageServer+"noimage.gif";
                 		}else{
                 			img_name = virtual_name;	
                 		}
                 
                 		a_table = (i+1) % 3;
                 %>
				
				<% if(a_table == 1){ %>
						<tr valign="top">
                <%}%>
							<td>
								<!-- ������ && �̹��� ���̺� -->
								<table width="201" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td colspan="3">
									   <table cellpadding="2" cellspacing="1" border="0" class="imgline">
									     <tr>
									       <td class="bg_white"><img src="<%=thumbnail_img_name%>" width="195" height="146"></td>
									     </tr>
									   </table>
									</td>
								</tr>
								<tr valign="top">
									<td width="6" class="tpad_13"><img src="<%=imageServer%>/tour_img/bu/bu_gray_rec.gif" vspace="5"></td>
									<td width="134" class="tpad_13"><%=title%></td>
									<td width="61" class="tpad_13">
									
                                    <%
                                    if (type_code.equals("1")){  //�̹���
                                    %>
									  <a href="javascript:;" onclick="window.open ('popup_pr_imgview.jsp?board_seq=<%=board_seq%>&img_name=<%=img_name%>', 'movieview', 'width=750,height=700,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									  <img src="<%=imageServer%>/tour_img/btn/btn_pre_img.gif" align="absmiddle">
									  </a>                 	    
                                    <%
                                    }else if(type_code.equals("2")){  //������
                                    %>
									  <a href="javascript:;" onclick="window.open ('popup_pr_movieview.jsp?board_seq=<%=board_seq%>&img_name=<%=content%>', 'movieview', 'width=450,height=436,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
									  <img src="<%=imageServer%>/tour_img/btn/btn_pre_play.gif" align="absmiddle">
									  </a>                 	    
                                    <%
                                    }else{
                                    %>

                                    <%}%>

									</td>
								</tr>
								</table>
							</td>
							<td></td>
							
               <% if(a_table == 1){ %>
               <% } %>								
					    <% 
					    if(a_table == 0){ 						
					    	if((i+1) == allCount || (i+1) == 4){
					    %>
					    </tr>
					       <!--<tr><td height="1" colspan="5" class="line_g"></td></tr>-->
					    <%
					    	}else{
					    %>
					    </tr>
					    
					       <!--<tr><td height="1" colspan="5" class="line_g"></td></tr>-->
					    
					    <% 
					    	}
					    } 
					    %>
				     <%
				     	}
				     }
				     %>
				     
				     <tr><td height="1" colspan="5" class="line_dg"></td></tr>
						</table>
						<!-- view table / -->

						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="60">
						<tr>
							<td align="center">
							   <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "pr_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
						    </td>
						</tr>
						</table>
						<!-- paging/ -->
						<!-- /search -->
						<form method=post name=searchForm ACTION="pr_list.jsp">
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr>
						   <td align="center">
                             <select name="part" style='width:80;'>
                              <option <%if(part.equals("")){%>selected<%}%>  value=''>����</option>
                              <option <%if(part.equals("1")){%>selected<%}%> value='1'>�̹���</option>
                              <option <%if(part.equals("2")){%>selected<%}%> value='2'>������</option>
                             </select>
                             <input type="text" name="keyword" value="<%=keyword%>" style="width:140px;"><a href="javascript:goSearch();"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--�˻�-->
                           </td>
						</tr>
						</table>
						</form>
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