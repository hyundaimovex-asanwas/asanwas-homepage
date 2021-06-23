<%--
  - 작성자: 심동현
  - 일자: 2015.05.19
  - 설명: 현대면세점 상품안내 리스트
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="com.hddutyfree.Df_item_bean"%>
<%@ page import="com.hddutyfree.Df_item_info"%>
<%@ page import="java.util.*, java.text.*"%>

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
String s_price = "";
Df_item_info dao = new Df_item_info();

//조회수증가
dao.updateReadnum(idx);

Df_item_bean[] recordview = dao.getGoodsView(idx);

int totalCount = recordview.length;

for(int i=0; i<totalCount; i++){
	Df_item_bean tbean = recordview[i];

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
	//천단위
	DecimalFormat df = new DecimalFormat("###,###");
	s_price = df.format(g_price);        
}	
%>

<html>
<head>
<title>현대 면세점 이용 안내</title>
<link rel="STYLESHEET" type="text/css" href="css/common.css">
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td valign="top" align="center">
	

		<!-------- / center area -------->
<table cellpadding="0" cellspacing="0" border="0" width="932">
  <tr height="10"><td></td></tr>
  <tr>
  		<td><!-- header -->
			<%@ include file="./hddf_topnav.jsp" %>
		</td>
  </tr>
  <tr height="30"><td></td></tr>
  <tr>
	<td><table cellpadding="0" cellspacing="0" border="0" width="932">
		  <tr>
		  	<td width="133" valign="top">
		  	<table width="133" cellpadding="0" cellspacing="0" border="0">
		  	  <tr>
		  	  	<td><img src="./imgs/sub_tit3.jpg" ></td>
		  	  </tr>
		  	  <tr height="109"><td></td></tr>
		  	  <tr height="83"><td></td></tr>
		  	  <tr height="20"><td></td></tr>
		  	  <tr>
		  	  	<td><a href="mailto:suno@hdasan.com" ><img src="./imgs/but4.jpg" ></a></td>
		  	  </tr>		  	  
		  	</table>
		  	</td>
		  	<td width="30"></td>
		  	<td valign="top">
		  	
			<table width="769" height="130" cellpadding="0" cellspacing="0" border="0" style="background:url('./imgs/top_list1.jpg');fixed no-repeat left top;">
			<form name="frm" method="post" action="hddf_list.jsp" >
			  <tr>
				<td valign="bottom" align="left" class="b" style="padding-left:84px;padding-bottom:5px;color:#fff;"><!-- /search -->
					<select name="part">
						<option value="" <%if(part.equals("")){%>selected<%}%>>전체</option>
						<option value="01"  <%if(part.equals("01")){%>selected<%}%>>주류</option>
						<!-- <option value="02"  <%if(part.equals("02")){%>selected<%}%>>담배</option>  -->
						<option value="03"  <%if(part.equals("03")){%>selected<%}%>>건강식품</option>
						<option value="04"  <%if(part.equals("04")){%>selected<%}%>>화장품</option>
						<option value="05"  <%if(part.equals("05")){%>selected<%}%>>향수</option>
						<option value="06"  <%if(part.equals("06")){%>selected<%}%>>식품</option>
						<option value="07"  <%if(part.equals("07")){%>selected<%}%>>시계</option>
						<option value="08"  <%if(part.equals("08")){%>selected<%}%>>잡화</option>
					</select><a href="javascript:searchCh()"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="5"></a>
					<!-- search/ -->
					면세점을 직접 이용하시면 더욱 다양한 국·내외 상품을 만나볼 수 있습니다.
				</td>
			  </tr>
		  	</form>
		  	</table>
			<table width="769" cellpadding="0" cellspacing="0" border="0">
			  <tr>
				<td valign="top" align=center>
				<!-- / content  -->
				<table width="690" cellpadding="0" cellspacing="0" border="0">
				  <tr><td height="10"></td></tr>
				  <tr>
					<td valign="top">
						<!-- / detail table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						  <tr valign="top">
							<td width="300" style="border:1px solid #ddd;">
					             <img src="./imgs/items/<%=g_imgfile%>_m.jpg" width="300" height="300">
							</td>
							<td width="390" align="right">
								<table width="370" height="305" cellpadding="0" cellspacing="0" border="0">
								<tr><td colspan="2" height="2" class="line_dg"></td></tr>
								<tr>
									<td width="107" height="35"><img src="<%=imageServer%>/tour_img/guide/txt_guide06.gif"><!-- 상품명 --></td>
									<td width="263" class="fs14 b txt_dgreen"><%=g_name%></td>
								</tr>
								<tr><td colspan="2" height="1" class="line_g2"></td></tr>
								<tr>
									<td height="35"><img src="<%=imageServer%>/tour_img/guide/txt_guide07.gif"><!-- 가격 --></td>
									<td class="tpad_3"><%if(g_corner.equals("01")){%>
				            		  <b>별도문의</b>
						            <%}else{%><b>￦<%=s_price%></b>	
						            <%}%>
						            </td>
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
								<tr><td colspan="2" height="1" class="line_g2"></td></tr>
								<tr>
									<td height="100%"><!-- 설명/효능 --></td>
									<td class="tpad_10 lpad_0 rpad_10 bpad_10">
									<%
									  if (g_function !="" && !g_function.equals("")){
									      out.println (g_function);
									  }else{
								             out.println ("&nbsp;");
								          }
									%>									
									</td>
								</tr>
								<tr><td colspan="2" height="2" class="line_dg"></td></tr>
								</table>
							</td>
						  </tr>
						  <tr><td colspan="2" height="45" align="center"><a href="hddf_list.jsp?page=<%=requestedPage%>&position=<%=requestedPage%>&part="><img src="<%=imageServer%>/tour_img/btn/btn_guide_listview.gif"></a><!-- 목록보기 --></td></tr>
						</table>
				<!--  content / -->
				</td>
			  </tr>		  				
			</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
</table> 





	<!-- footer -->
	<%@ include file="./hddf_footer.jsp" %>
		
	</td>
  </tr>
</table>


</body>
</html>