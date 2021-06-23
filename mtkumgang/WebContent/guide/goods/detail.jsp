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
int idx = Util.parseInt(request.getParameter("idx"), 0);
int requestedPage = Util.parseInt(request.getParameter("requestedPage"), 1);
String part   = ParamUtil.getReqParameter(request.getParameter("part"));

String key_str = "&part="+part;

//변수 선언
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
String g_unit = "";

//상단 플래쉬 정보
String McNum = "4"; 
String sub = "5";
String pageNum = "5";
String subNum = "";

GoodsInfo dao = new GoodsInfo();

//조회수증가
dao.updateReadnum(idx);

Goods_bean[] recordview = dao.getGoodsView(idx);

int totalCount = recordview.length;

for(int i=0; i<totalCount; i++){
	Goods_bean tbean = recordview[i];

	g_corner = tbean.getG_corner();
	g_name = tbean.getG_name();
	g_std = tbean.getG_std();
	g_price = tbean.getG_price();
	g_maker = tbean.getG_maker();
	g_function = tbean.getG_function();
	g_element = tbean.getG_element();
	g_usage = tbean.getG_usage();
	g_etc = tbean.getG_etc();
	g_bigo = tbean.getG_bigo();
	g_viewcnt = tbean.getG_viewcnt();
	g_imgfile = tbean.getG_imgfile();
	g_unit = tbean.getG_unit();
        g_date = tbean.getG_date();
}	
%>

<html>
<head>
<title>   금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
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
				<tr>
					<td>
						<table width="690" height="183" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/guide/bg_top_guide05.jpg');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/guide/stit_guide52.gif"></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / detail table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="215">
							<%if(g_imgfile == null || g_imgfile.equals("")){%>
							     <img src="<%=imageServer%>/tour_img/guide/_temp_img_goods.jpg" width="156" height="190">
						        <%}else{%>
						             <img src="<%=imageServer%>/tour_img/goods/<%=g_imgfile%>" width="156" height="190">
					                <%}%>
							</td>
							<td width="475">
								<table width="475" cellpadding="0" cellspacing="0" border="0">
								<tr><td colspan="2" height="2" class="line_dg"></td></tr>
								<tr>
									<td width="107" height="35"><img src="<%=imageServer%>/tour_img/guide/txt_guide06.gif"><!-- 상품명 --></td>
									<td width="368" class="fs14 b txt_dgreen"><%=g_name%></td>
								</tr>
								<tr><td colspan="2" height="1" class="line_g2"></td></tr>
								<tr>
									<td height="35"><img src="<%=imageServer%>/tour_img/guide/txt_guide07.gif"><!-- 가격 --></td>
									<td class="tpad_3">$ <%=g_price%></td>
								</tr>
								<tr><td colspan="2" height="1" class="line_g2"></td></tr>
								<tr>
									<td height="35"><img src="<%=imageServer%>/tour_img/guide/txt_guide08.gif"><!-- 제조사 --></td>
									<td class="tpad_3"><%=g_maker%></td>
								</tr>
								<tr><td colspan="2" height="1" class="line_g2"></td></tr>
								<tr>
									<td height="35"><img src="<%=imageServer%>/tour_img/guide/txt_guide09.gif"><!-- 단위 --></td>
									<td class="tpad_3"><%=g_unit%></td>
								</tr>
								<tr><td colspan="2" height="1" class="line_dg"></td></tr>
								<tr><td colspan="2" height="10"></td></tr>
								<tr>
									<td colspan="2" align="right"><a href="list.jsp?requestedPage=<%=requestedPage%>"><img src="<%=imageServer%>/tour_img/btn/btn_guide_listview.gif"></a><!-- 목록보기 --></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="45"></td></tr>
						<tr>
							<td colspan="2">
								<!-- 효능 -->
								<table width="690" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/guide/stit_guide051.gif"></td></tr>
								<tr>
									<td class="tpad_10 lpad_10 rpad_10 bpad_40">
									<%
									  if (g_function !="" && !g_function.equals("")){
									      out.println (g_function);
									  }else{
								             out.println ("&nbsp;");
								          }
									%>									
									</td>
								</tr>
								</table>

								<!-- 성분 -->
								<table width="690" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/guide/stit_guide052.gif"></td></tr>
								<tr>
									<td class="tpad_10 lpad_10 rpad_10 bpad_40">
									<%
									  if (g_element !=""  && !g_element.equals("")){
									      out.println (g_element);
									  }else{
								             out.println ("&nbsp;");
								          }
									%>									
									</td>
								</tr>
								</table>

								<!-- 사용법 -->
								<table width="690" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/guide/stit_guide053.gif"></td></tr>
								<tr>
									<td class="tpad_10 lpad_10 rpad_10 bpad_40">
									<%
									  if (g_usage !="" && !g_usage.equals("")){
									      out.println (g_usage);
									  }else{
								             out.println ("&nbsp;");
								          }
									%>									
									</td>
								</tr>
								</table>

								<!-- 기타 -->
								<table width="690" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/guide/stit_guide054.gif"></td></tr>
								<tr>
									<td class="tpad_10 lpad_10 rpad_10 bpad_40">
									<%
									  if (g_etc !="" && !g_etc.equals("")){
									      out.println (g_etc);
									  }else{
								             out.println ("&nbsp;");
								          }
									%>									
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- detail table / -->
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