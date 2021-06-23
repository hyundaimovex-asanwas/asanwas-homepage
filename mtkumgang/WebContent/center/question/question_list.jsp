<%-- 
  - �ۼ���: ������
  - ����: 2006.06.05
  - ������ : �̼ҿ� 
  - ���� : 2006.07    
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>���� ���� ���� ����Ʈ
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
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


// DB���� ��ü
BestQuestion dao = new BestQuestion();
CommonBoard commonDao = new CommonBoard();




// �˻� - �з�
String searchTypeCode =clearXSS(ParamUtil.getReqParameter(request.getParameter("searchTypeCode")),avatag );

// �˻� - �÷���
String part       = clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
// �˻� - �˻���
String keyword    =  clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag ); //Util.toKSC(ParamUtil.getReqParameter(request.getParameter("keyword")));

// �˻� - �Ķ����
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;

//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// ��ü �Խù� ��
int allCount = dao.getTotalCount(searchTypeCode,part,keyword);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, searchTypeCode, part, keyword );

//������ ������
String page_str = "&requestedPage="+requestedPage+"&position="+position;

String pageNum = "1";
String McNum = "6";
String sub = "1";


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

//�˻�
function goSearch(searchTypeCode){
	f = document.searchForm;
	if(searchTypeCode != ''){
	   f.searchTypeCode.value=searchTypeCode;
	}
	f.submit();
}
</script>

</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                      <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			
			<!--  left menu flash -->
				<%@ include file="../../include/center/tour_center_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/customer/tit_cus01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">������</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���ֹ�������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus01.jpg"></td></tr>
				<tr>
					<td>
						<!-- / �����ͼҺз� -->
						<table width="690" height="153" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/customer/bg_smenu.gif');fixed no-repeat left top;">
						<tr>
							<td width="197"></td>
							<td width="493" valign="top">
								<table width="467" cellpadding="0" cellspacing="0" border="0">
								<tr><td colspan="4" height="38"></td></tr>
								<tr><td colspan="4" height="32" valign="top"><img src="<%=imageServer%>/tour_img/customer/txt_smenu.gif"></td></tr>
								<tr>
									<td width="117"><%if(searchTypeCode.trim() == "01" || searchTypeCode.equals("01")){%><img src="<%=imageServer%>/tour_img/customer/sm_01_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_01.gif'"><%}else{%><a href="javascript:goSearch('01')"><img src="<%=imageServer%>/tour_img/customer/sm_01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_01.gif'"></a><%}%></td>
									<td width="117"><%if(searchTypeCode.trim() == "02" || searchTypeCode.equals("02")){%><img src="<%=imageServer%>/tour_img/customer/sm_02_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_02.gif'"><%}else{%><a href="javascript:goSearch('02')"><img src="<%=imageServer%>/tour_img/customer/sm_02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_02.gif'"></a><%}%></td>
									<td width="117"><%if(searchTypeCode.trim() == "03" || searchTypeCode.equals("03")){%><img src="<%=imageServer%>/tour_img/customer/sm_03_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_03.gif'"><%}else{%><a href="javascript:goSearch('03')"><img src="<%=imageServer%>/tour_img/customer/sm_03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_03.gif'"></a><%}%></td>
									<td width="116"><%if(searchTypeCode.trim() == "04" || searchTypeCode.equals("04")){%><img src="<%=imageServer%>/tour_img/customer/sm_04_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_04.gif'"><%}else{%><a href="javascript:goSearch('04')"><img src="<%=imageServer%>/tour_img/customer/sm_04.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_04_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_04.gif'"></a><%}%></td>
								</tr>
								<tr><td colspan="4" height="8"></td></tr>
								<tr>
									<td><%if(searchTypeCode.trim() == "05" || searchTypeCode.equals("05")){%><img src="<%=imageServer%>/tour_img/customer/sm_05_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_05.gif'"><%}else{%><a href="javascript:goSearch('05')"><img src="<%=imageServer%>/tour_img/customer/sm_05.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_05_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_05.gif'"></a><%}%></td>
									<td><%if(searchTypeCode.trim() == "06" || searchTypeCode.equals("06")){%><img src="<%=imageServer%>/tour_img/customer/sm_06_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_06.gif'"><%}else{%><a href="javascript:goSearch('06')"><img src="<%=imageServer%>/tour_img/customer/sm_06.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_06_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_06.gif'"></a><%}%></td>
									<td><%if(searchTypeCode.trim() == "07" || searchTypeCode.equals("07")){%><img src="<%=imageServer%>/tour_img/customer/sm_07_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_07.gif'"><%}else{%><a href="javascript:goSearch('07')"><img src="<%=imageServer%>/tour_img/customer/sm_07.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_07_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_07.gif'"></a><%}%></td>
									<td><%if(searchTypeCode.trim() == "08" || searchTypeCode.equals("08")){%><img src="<%=imageServer%>/tour_img/customer/sm_08_on.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_08_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_08.gif'"><%}else{%><a href="javascript:goSearch('08')"><img src="<%=imageServer%>/tour_img/customer/sm_08.gif" onmouseover="this.src='<%=imageServer%>/tour_img/customer/sm_08_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/customer/sm_08.gif'"></a><%}%></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- �����ͼҺз� / -->
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				<tr><td align="right">

<form method=post name=searchForm action="question_list.jsp">
<input type="hidden" name="searchTypeCode" value="<%=searchTypeCode%>">				
				<input type="text" style="width:262px;" name="keyword"  value="<%=keyword%>" ><a href="javascript:goSearch('')"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--�˻�-->
</form>				
				</td></tr>
				<tr><td height="12"></td></tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="80"><col width="500"><col width="60">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- ��ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt11.gif"><!-- �з� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- ���� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- ��ȸ�� --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
<% if(record.length <= 0){ %>							
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26" colspan="4" align="center">����Ÿ�� �������� �ʽ��ϴ�.</td>
						</tr>
<%}else{
		//����Ʈ ȭ�鿡 ����
		for(int i=0;i<record.length; i++){ 
			Tbrd_board_ma_bean tbean = record[i];
			board_seq			= tbean.getBoard_seq();
			ref_no				= tbean.getRef_no(); 
			read_num			= tbean.getRead_num(); 
			title				= tbean.getTitle(); 
			content				= tbean.getContent(); 
			use_yn				= tbean.getUse_yn(); 
			user_id				= tbean.getUser_id();
			type_code				= tbean.getType_code();
			if(type_code.equals("01")){  type_name = "���ΰ���";
			}else if(type_code.equals("02")){ type_name = "�����û/���";
			}else if(type_code.equals("03")){ type_name = "�������";
			}else if(type_code.equals("04")){ type_name = "�����غ�";
			}else if(type_code.equals("05")){ type_name = "��������";
			}else if(type_code.equals("06")){ type_name = "�������Ա�";
			}else if(type_code.equals("07")){ type_name = "����ƻ�";
			}else if(type_code.equals("08")){ type_name = "��Ÿ";
			}else{ type_name = "��Ÿ";
			}

			String reg_date_string = tbean.getReg_date_String();
			String re_img	= BoardUtil.getReImg(0,0,imageServer);
			String new_img	= BoardUtil.getNewArticle(reg_date_string,imageServer);
	%>						
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26"><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td><%=type_name%></td>
							<td align="left" class="tpad_3 lpad_10">
                            <a href="question_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>" class="listtxt06"><%=Util.getStringLimit(title,25)%></a>							
                            </td>
							<td><%=read_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
    <%
    	}
    }
    
    %>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "question_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
			                 </td>
						</tr>
						</table>
						<!-- paging/ -->
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