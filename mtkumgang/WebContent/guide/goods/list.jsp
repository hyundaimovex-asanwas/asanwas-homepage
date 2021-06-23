<%--
  - 작성자: 이소연
  - 일자: 2006.09.07
  - 저작권 표시: IMJ Korea
  - 설명: 프론트 - 상품안내 리스트
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Goods_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.GoodsInfo"%>
<%@ page import="java.util.*"%>
<%

//변수 선언
int idx = 0;
int g_viewcnt = 0; 
int g_price = 0;
String g_name = ""; 
String g_corner = "";
String g_std = "";
String g_maker = "";
String g_function = "";
String g_element = "";
String g_usage = "";
String g_etc = "";
String g_bigo = "";
String g_imgfile = "";
String g_date = "";
int pageSize = 5;
int blockSize = 10;

//상단 플래쉬 정보
String McNum = "4";
String sub = "5"; 
String pageNum = "5";
String subNum = "";

// DB연결 객체(ibatis사용)  
GoodsInfo dao = new GoodsInfo();
// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 파라메터 (상품종류)
String key_str = "&part="+part;
//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);
// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);
// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// 게시물 목록
Goods_bean record [] = dao.getGoodsList(requestedPage, pageSize, part);

// 전체 게시물 수
int allCount = dao.getCount(part);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>

<html>
<head>
<title>   금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script langage="JavaScript">
  function searchCh()  {
       var form=document.frm;
       form.submit();
  }
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/guide/tour_guide_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/guide/tour_guide_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/guide/tit_guide05.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">현지안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">금강산 상품</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
<form name="frm" method="post" action="list.jsp" >				
				<tr>
					<td>
						<table width="690" height="183" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/guide/bg_top_guide05.jpg');fixed no-repeat left top;">
						<tr>
							<td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/guide/stit_guide05.gif" hspace="5"></td>
							<td valign="bottom" align="right" style="padding-bottom:7px;">
								<!-- /search -->
								<img src="<%=imageServer%>/tour_img/guide/txt_guide00.gif" hspace="3">
								<select name="part">
									<option value="" <%if(part.equals("")){%>selected<%}%>>전체</option>
									<option value="북측상품"  <%if(part.equals("북측상품")){%>selected<%}%>>북측상품</option>
									<option value="면세상품"  <%if(part.equals("면세상품")){%>selected<%}%>>면세상품</option>
									<option value="국내상품"  <%if(part.equals("국내상품")){%>selected<%}%>>국내상품</option>
								</select><a href="javascript:searchCh()"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="5"></a><!--검색-->
								<!-- search/ -->
							</td>
						</tr>
						</table>
					</td>
				</tr>
</form>				
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="90"><col width="120"><col width="220"><col width="130"><col width="130">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/guide/txt_guide01.gif"><!-- 상품종류 --></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_guide02.gif"><!-- 상품사진 --></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_guide03.gif"><!-- 상품명 --></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_guide04.gif"><!-- 규격 --></td>
							<td><img src="<%=imageServer%>/tour_img/guide/txt_guide05.gif"><!-- 가격 --></td>
						</tr>
						
						<tr><td height="1" colspan="5" class="line_g2"></td></tr>
<% if(record.length <= 0){ %>
						<tr align="center">
							<td height="26" align="center" colspan="5">등록된 데이터가 없습니다.</td>
						</tr>
						<tr><td height="1" colspan="5" class="line_g2"></td></tr>
<%
}else{
	//리스트 화면에 전시
	for(int i=0;i<record.length; i++){ 
		Goods_bean tbean = record[i];
		idx = tbean.getIdx();
		g_corner = tbean.getG_corner(); 
		g_imgfile = tbean.getG_imgfile(); 
		g_name = tbean.getG_name(); 
		g_std = tbean.getG_std(); 
		g_price = tbean.getG_price(); 
%>
						<tr align="center">
							<td height="26"><%=g_corner%></td>
							<td class="tpad_10 bpad_10">
							<%if(g_imgfile == null || g_imgfile.equals("")){%>
							     <img src="<%=imageServer%>/tour_img/guide/_temp_simg.jpg" width="90" height="68">
						        <%}else{%>
						             <img src="<%=imageServer%>/tour_img/goods/<%=g_imgfile%>_S.jpg" width="90" height="68">
					                <%}%>
							</td>
							<td align="left" class="tpad_3 lpad_10"><a href="detail.jsp?idx=<%=idx%>&requestedPage=<%=requestedPage%>" class="listtxt04"><%=g_name%></a></td>
							<td><%=g_std%></td>
							<td>$ <%=g_price%></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_g2"></td></tr>
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
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
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