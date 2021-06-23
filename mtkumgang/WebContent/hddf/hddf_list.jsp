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
int pageSize = 12;	//1페이지에 상품 몇 개씩 
int blockSize = 10;	//페이지 블럭을 몇 개 단위로 보여줄지

// DB연결 객체(ibatis사용)  
Df_item_info dao = new Df_item_info();
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
Df_item_bean record [] = dao.getGoodsList(requestedPage, pageSize, part);

// 전체 게시물 수
int allCount = dao.getCount(part);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>

<html>
<head>
<title>현대 면세점 이용 안내</title>
<link rel="STYLESHEET" type="text/css" href="css/common.css">
<script langage="JavaScript">
  function searchCh()  {
       var form=document.frm;
       form.submit();
  }

</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td valign="top" align="center">
	
<!-- / content  -->
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
		  	<span style="color:orange">▶취급품목 : 주류 90품목 / 담배 60품목 / 화장품 500품목 / 향수 170품목/ 건강식품 50품목 / 시계 420품목/ 잡화 400품목 / 생활가전 100품목 외  다수</span>
		  	
		  	<table width="769" cellpadding="0" cellspacing="0" border="0">
			  <tr>
				<td valign="top">
					<!-- / list table  -->
					<table cellpadding="0" cellspacing="0" border="0" width="769">
					<col width="190"><col width="190"><col width="190"><col width="190">
					
			<% if(record.length <= 0){ %>
					<tr align="center">
						<td height="26" align="center" colspan="4">등록된 데이터가 없습니다.</td>
					</tr>
					<tr><td height="1" colspan="4" class="line_g2"></td></tr>
			<%
			}else{
				//리스트 화면에 전시
				for(int i=0;i<record.length; i++){ 
					Df_item_bean tbean = record[i];
					idx = tbean.getIdx();
					g_corner = tbean.getG_corner(); 
					g_imgfile = tbean.getG_imgfile(); 
					g_name = tbean.getG_name(); 
					g_std = tbean.getG_std(); 
					g_price = tbean.getG_price();
					g_maker = tbean.getG_maker();
					g_etc = tbean.getG_etc();
					g_bigo = tbean.getG_bigo();
			
					//천단위
					DecimalFormat df = new DecimalFormat("###,###");
					String s_price = df.format(g_price);
					
					if(i%4==0){
			%>
					<tr align="center">
					<%} %>
						<td class="tpad_10 bpad_10 lpad_10 rpad_10">
						<!-- 1 item -->
						<table cellpadding="0" cellspacing="0" border="0">
						  <tr>
						  	<td align=center><%if(g_imgfile == null || g_imgfile.equals("")){%>
						    		<img src="./imgs/items/temp_simg.jpg" width="160" height="160">
					        	<%}else{%>
									<a href="hddf_view.jsp?idx=<%=idx%>&requestedPage=<%=requestedPage%>" class="listtxt04"><img src="./imgs/items/<%=g_imgfile%>_s.jpg" width="160" height="160"></a>				            	<%}%></td>
				          </tr>
				          <!-- 한글 -->
				          <tr>
				          	<td align=center><b>[<%=g_maker%>]</b></td>
				          </tr>
				          <tr>
				          	<td align=center><a href="hddf_view.jsp?idx=<%=idx%>&requestedPage=<%=requestedPage%>" class="listtxt04"><%=g_name%></a></td>
				          </tr>
				          
				          <!-- 영문 
				          <tr>
				          	<td align=center><b>[<%=g_etc%>]</b></td>
				          </tr>
				          <tr>
				          	<td align=center><a href="hddf_view.jsp?idx=<%=idx%>&requestedPage=<%=requestedPage%>" class="listtxt04"><%=g_bigo%></a></td>
				          </tr>-->
			
				          <tr>
				            <td align=center><%=g_std%></td>
				          </tr>
				          <tr>
				            <td align=center><%if(g_corner.equals("01")){%>
				            		  <b>가격 별도문의</b>
				            <%}else{%><b>￦<%=s_price%></b>	
				            <%}%>
				            </td>
				            
				          </tr>
				        </table>
						<!-- 1 item -->
						</td>
					<%if(i%4==3){%>
					</tr>
					<%}			
				}
			}
			%>
					</tr>
					<tr>
						<td height="1" colspan="4" align="center"><!-- /paging -->
							<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "hddf_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
						</td>
					</tr>
			
					</table>
					<!-- list table / -->
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