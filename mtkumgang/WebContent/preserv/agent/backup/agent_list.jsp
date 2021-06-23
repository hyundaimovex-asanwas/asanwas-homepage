<%--
  - 작성자: 이소연
  - 일자: 2006.06.08
  - 저작권 표시: IMJ Korea
  - 설명: 프론트 - 대리점 안내
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Agent_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.AgentInfo"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
String client_sid  = "";
String client_cd   = "";
String client_gu   = "";
String branch_nm   = "";
String area_cd     = "";
String tel_no      = "";
String mobile_no   = "";
String fax_no      = "";
String branch_cd   = "";
String branch_url  = "";
String zip_cd      = "";
String address1    = "";
String address2    = "";

// DB연결 객체(ibatis사용)  
AgentInfo dao = new AgentInfo();

// 검색 - 지역코드
area_cd = ParamUtil.getReqParameter(request.getParameter("area_cd"));

Agent_bean agent_record[] = dao.getAgentList(area_cd);

if(agent_record.length > 0 ){
	Agent_bean agentbean = agent_record[0];
	client_gu		= agentbean.getClient_gu();
	branch_nm	= agentbean.getBranch_nm();
	branch_cd	= agentbean.getBranch_cd();
	zip_cd	= agentbean.getZip_cd();
	address1	= agentbean.getAddress1();
	address2	= agentbean.getAddress2();
	tel_no	= agentbean.getTel_no();
	mobile_no	= agentbean.getMobile_no();
	fax_no	= agentbean.getFax_no();
	branch_url	= agentbean.getBranch_url();
}
%>

<HTML>
<HEAD>
<title></title>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<script language="javascript">
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "키워드를 입력하세요"){
      form.schVal.value="";
   }
   form.submit();
}
</script>
</HEAD>
<body>
   <TABLE cellspacing=0 cellpadding=0 width=650>
   <TR valign=top>
   	<!-- main -->
    <TD width=650 valign=top>
     <table width=650 border=0 cellspacing=0 cellpadding=0>
     <tr>
       <td>
         <table width=100% border=0 cellspacing=0 cellpadding=0>
          <tr>
           <td class='title'><img src='../../asanway/img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>대리점 안내</td>
          </tr>
         </table>
         <br>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <col width=40%>
         <col width=60%>
           <tr height=100 align=left>
             <td rowspan=2>
              서울특별시&nbsp;&nbsp;
              부산광역시&nbsp;&nbsp;
              대구광역시<br>
              대전광역시&nbsp;&nbsp;
              광주광역시&nbsp;&nbsp;
              울산광역시<br>
              인천광역시&nbsp;&nbsp;
              강원도&nbsp;&nbsp;
              경기도<br>
              경상남도&nbsp;&nbsp;
              경상북도&nbsp;&nbsp;
              전라남도<br>
              전라북도&nbsp;&nbsp;
              충청남도&nbsp;&nbsp;
              충청북도<br>
              제주도&nbsp;&nbsp;
              해외
             </td>
             <td>
              <b>대리점 에서는 전화로도 관광을 예약하실 수 있습니다.</b>
             </td>
           </tr>
           <tr height=100 align=center>
             <td>
              지역명으로 찾기 
              <select name="">
                <option value="">전체</option>
                <option value="">서울특별시</option>
                <option value="">대구광역시</option>
                <option value="">광주광역시</option>
                <option value="">울산광역시</option>
                <option value="">인천광역시</option>
                <option value="">강원도</option>
                <option value="">경기도</option>
                <option value="">경상남도</option>
                <option value="">경상북도</option>
                <option value="">전라남도</option>
                <option value="">전라북도</option>
                <option value="">충청남도</option>
                <option value="">충청북도</option>
                <option value="">제주도</option>
                <option value="">해외</option>
                <option value=""></option>
                <option value=""></option>
                <option value=""></option>
              </select>  
              <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="검색" class="btn" onclick="openSch()" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
             </td>
           </tr>	    
         </table>
         <br>			
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
         	<col width=10%>
         	<col width=15% style='padding:5 3 3 3;'>
         	<col width=30%>
         	<col width=15%>
         	<col width=15%>
         	<col width=15%>
         	<tr><td colspan=6 height=2 class=linec1></td></tr>
         	<tr height=28 align=center>
             <td class=th>구분</td>
             <td class=th>대리점명</td>
             <td class=th>주소</td>
             <td class=th>전화번호</td>
             <td class=th>팩스번호</td>
             <td class=th>홈페이지</td>
         	</tr>
            <% 
            if(agent_record.length <= 0){ 
            %>	
            <tr><td colspan=6 height=1 class=linec1></td></tr> 
            <tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
            	<td colspan=8 align=center height=30>데이타가 존재하지 않습니다.</td>
            </tr>
            <tr><td colspan=7 height=1 class=linec1></td></tr>
            <%
            }else{
            	//리스트 화면에 전시
            	for(int i=0;i<agent_record.length; i++){ 
            		Agent_bean tbean   = agent_record[i];
            		client_sid         = tbean.getClient_sid();
            		client_cd          = tbean.getClient_cd(); 
            		client_gu          = tbean.getClient_gu(); 
            		branch_nm          = tbean.getBranch_nm(); 
            		zip_cd             = tbean.getZip_cd(); 
            		address1           = tbean.getAddress1(); 
            		address2           = tbean.getAddress2(); 
            		tel_no             = tbean.getTel_no(); 
            		mobile_no          = tbean.getMobile_no(); 
            		fax_no             = tbean.getFax_no(); 
            		branch_url         = tbean.getBranch_url(); 
            %>
         	<tr><td colspan=6 height=1 class=linec1></td></tr> 
         	<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
             <td><%=client_cd%></td>
             <td><%=branch_nm%></td>
             <td><%=address1%>&nbsp;<%=address1%><%=address2%></td>
             <td><%=tel_no%></td>
             <td><%=fax_no%></td>
             <td><%=branch_url%>[GO]</td>
         	</tr>
            <%
               }
            }
            %>
         </table>
        </td>
        </tr>
     </table>
     </TD>
   	<!-- //main -->
    </TR>
  </TABLE>
</BODY>
</HTML>
