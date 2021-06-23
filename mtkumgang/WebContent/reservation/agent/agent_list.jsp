<%--
  - 작성자: 이소연
  - 일자: 2006.06.08  
  - 저작권 표시: IMJ Korea
  - 설명: 프론트 - 대리점 안내
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Agent_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.AgentInfo"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
String client_cd   = "";
String client_nm   = "";
String area_cd     = "";
String agen_gu     = "";
String tel_no      = "";
String fax_no      = "";
String client_url  = "";
String zip_cd      = "";
String address    = "";
String address1    = "";
String address2    = "";

String keyword    = "";
String part       = "";

String McNum = "2";
String sub = "6";
String pageNum = "6";
String subNum = "";

// DB연결 객체(ibatis사용)  
AgentInfo dao = new AgentInfo();

// 검색 - 지역코드
area_cd = ParamUtil.getReqParameter(request.getParameter("area_cd"));
keyword = ParamUtil.getReqParameter(request.getParameter("keyword"));
part = ParamUtil.getReqParameter(request.getParameter("part"));

Agent_bean agent_record[] = dao.getAgentList(area_cd,keyword,part);
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/maplink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>

<script language="javascript">
function openSch(){
   var form = document.frm;
   
 //  if (form.part.value == ""){
 //     alert("정렬을 선택하세요.");
 //     form.part.focus();
 //     return;
 //  }
   if (form.keyword.value == ""){
      alert("키워드를 입력하세요.");
      form.keyword.focus();
      return;
   }
   form.submit();
}

function ClientPop(val){
   if(val !=""){
     window.open(val,"client");
   }  
}


function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
function getCookie( name )
{
        var nameOfCookie = name + "=";
        var x = 0;
        while ( x <= document.cookie.length )
        {
                var y = (x+nameOfCookie.length);
                if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                                endOfCookie = document.cookie.length;
                        return unescape( document.cookie.substring( y, endOfCookie ) );
                }
                x = document.cookie.indexOf( " ", x ) + 1;
                if ( x == 0 )
                        break;
        }
        return "";
}

//if ( getCookie( "agent" ) != "done" )
//{
//	window.open('/reservation/agent/popup_agent.jsp','agent_pop','left=0, top=0, width=500, height=470'); // 팝업윈도우의 경로와 크기를 설정 하세요
//}

//-->
</script>


</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app04.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약/신청</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">대리점 안내</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="22"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/top_txt_app04.gif"></td></tr>
				<tr><td colspan="2" height="25"></td></tr>
				<tr valign="top">
					<td width="405"><!--  agency map flash -->
						<script language="javascript">
							f_id = "agencyMap";//플래시 아이디
							f_name ="<%=imageServer%>/tour_swf/agencyMap.swf"; //플래시 파일명
							f_width = "395";//가로크기
							f_height ="356"; //세로높이
							f_trans =""; //공백, transparent(투명)
							f_para =""; //파라미터
							show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
						</script>
					    <!--<a href="agent_list.jsp?area_cd=01">서울</a>
					    <a href="agent_list.jsp?area_cd=02">부산</a>
					    <a href="agent_list.jsp?area_cd=03">대구</a>
					    <a href="agent_list.jsp?area_cd=04">인천</a>
					    <a href="agent_list.jsp?area_cd=05">광주</a>
					    <a href="agent_list.jsp?area_cd=06">대전</a>
					    <a href="agent_list.jsp?area_cd=07">울산</a>
					    <a href="agent_list.jsp?area_cd=51">경기</a><br>
					    <a href="agent_list.jsp?area_cd=52">강원</a>
					    <a href="agent_list.jsp?area_cd=53">충북</a>
					    <a href="agent_list.jsp?area_cd=54">충남</a>
					    <a href="agent_list.jsp?area_cd=55">경북</a>
					    <a href="agent_list.jsp?area_cd=56">경남</a>
					    <a href="agent_list.jsp?area_cd=57">전북</a>
					    <a href="agent_list.jsp?area_cd=58">전남</a>
					    <a href="agent_list.jsp?area_cd=59">제주</a><br>
					    <a href="agent_list.jsp?area_cd=90">해외</a>-->
						</td>
					<td width="285">
						<table width="285" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="1" class="line_g3"></td>
							<td width="284" style="padding:31 0 37 0px;">
								<table width="284" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/apply/img_rig_app03.jpg" width="284" height="146"></td></tr>
								<tr>
									<td height="95" class="bg_dgreen lpad_15">
										<table cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td height="18"><img src="<%=imageServer%>/tour_img/apply/txt_app03.gif"></td>
											<td rowspan="2"><a href="javascript:openSch()"><img src="<%=imageServer%>/tour_img/btn/btn_app_search.gif" align="absmiddle" style="margin-left:12px;"></a><!-- 검색 --></td>
										</tr>
<form name="frm" method="post" action="agent_list.jsp">
<input type="hidden" name="area_cd" value="<%=area_cd%>">
										<tr>
											<td height="19">
												<select name="part">
                                                  <option <%if(part.equals("")){%>selected<%}%> value=''>선택</option>
                                                  <option <%if(part.equals("client_nm")){%>selected<%}%> value='client_nm'>대리점명</option>
                                                  <option <%if(part.equals("address")){%>selected<%}%> value='address'>주소</option>
												</select>
												<input type="text" name="keyword" style="width:112px;" value="<%=keyword%>">
											</td>
										</tr>
</form>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="140"><col width="250"><col width="110"><col width="110"><col width="70">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt13.gif"><!-- 대리점명 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt14.gif"><!-- 주소 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt15.gif"><!-- 전화번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt16.gif"><!-- 팩스번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt17.gif"><!-- 홈페이지 --></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
            <% 
            if(agent_record.length <= 0){ 
            %>							
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="56" colspan="5">가까운 지역 또는 대리점명으로 검색해주세요. </td>
						</tr>
						<tr><td height="1" colspan="5" class="line_g2"></td></tr>
            <%
            }else{
            	//리스트 화면에 전시
            	for(int i=0;i<agent_record.length; i++){ 
            		Agent_bean tbean   = agent_record[i];
            		client_cd          = tbean.getClient_cd(); 
            		client_nm          = tbean.getClient_nm(); 
            		zip_cd             = tbean.getZip_cd(); 
            		address1           = tbean.getAddress1(); 
            		address2           = tbean.getAddress2(); 
            		address = address1+address2;
            		tel_no             = tbean.getTel_no(); 
            		fax_no             = tbean.getFax_no(); 
            		client_url         = tbean.getClient_url(); 
            		agen_gu            = tbean.getAgen_gu(); 
                                
                               //if(part.equals("client_nm")){
                                  client_nm = client_nm.replaceAll(keyword, "<font color='blue'>"+keyword+"</font>");
                               //}
                               //if(part.equals("address")){
                                   address = address.replaceAll(keyword, "<font color='blue'>"+keyword+"</font>");
                               //}
            %>						
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10"><%=client_nm%></td>
							<td align="left" class="tpad_3 lpad_10"><%=address%></td>
							<td><%=tel_no%></td>
							<td><%=fax_no%></td>
							<td>
							<%if (client_url !=""){%>
							<a href="javascript:;" onclick="javascript:ClientPop('http://<%=client_url%>');"><img src="<%=imageServer%>/tour_img/btn/btn_nowgo.gif"></a>
                                                                           <%}%>
							</td>
						</tr>
						<tr><td height="1" colspan="5" class="line_g2"></td></tr>
            <%
               }
            }
            %>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->
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