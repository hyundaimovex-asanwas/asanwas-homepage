<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.*"%>
<%@ page import="com.hmm.ejb.common.UtilDB"%>
<%
	int i_number, i_count;

	int i_cur_num=0, i_total_no=0, i_total_page=0; // 가상 글 번호

	int i_page_num = 10; // 한 화면에 보여줄 페이지 링크 갯수 -> 블록

	int i_list_num =7; // 한 페이지에 보여줄 게시물의 수

	int i_total_block, i_block;

	int i_first, i_last, i_block_prev, i_block_next, i_page_link;

	int i_page, i_prev, i_next;

	String s_page, s_writetime ;

	s_page = request.getParameter("page"); // summer_event_view.jsp?page=3 과 같이 넘어온 값 "3"을 넘겨받음.

	if(s_page==null) s_page="1"; // 그냥 summer_event_view.jsp로 했을 경우

	i_page = Integer.parseInt(s_page);

	int i_offset = i_list_num*(i_page-1); //한 페이지의 시작 글 번호(i_listnum 수만큼 나누었을 때 시작하는 글의 번호)
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::금강산 여름휴가 프로젝트::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.txt{font-family:돋움; font-size:11; border: 1 solid;}
.font{font-family:돋움; font-size:11;}
.num{font-family:Tahoma; font-size:10;}
-->
</style>

<script language="javascript">
function parentGO() {
	parent.location.href='summer_event_write.jsp';
}
</script>
</head>
<body>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="3" colspan="5" background="<%=imageServer%>/summer_img/line_01.gif"></td>
  </tr>
  <tr> 
    <td width="112" height="32" align="center"><img src="<%=imageServer%>/summer_img/title_01.gif" width="29" height="12"></td>
    <td width="1" align="center"><img src="<%=imageServer%>/summer_img/line_02.gif" width="1" height="5"></td>
    <td width="485" align="center"><img src="<%=imageServer%>/summer_img/title_02.gif" width="47" height="12"></td>
    <td width="1" align="center"><img src="<%=imageServer%>/summer_img/line_02.gif" width="1" height="5"></td>
    <td width="109" align="center"><img src="<%=imageServer%>/summer_img/title_03.gif" width="29" height="12"></td>
  </tr>
  <tr> 
    <td height="1" colspan="5" bgcolor="000000"></td>
  </tr>
</table>
<table width="700" border="0" cellspacing="0" cellpadding="0">
<%    
	Connection conn = null;
	PreparedStatement pstmt = null; 
	ResultSet rs = null;   

	String query = ""; 
	try { 
	  conn = UtilDB.getConnection("jdbc/tourds"); 
	  query = "select count(*) from asan.EVENT_SUMMER"; 
	  pstmt = conn.prepareStatement(query); 
	  rs = pstmt.executeQuery(); 

	  if(rs.next()) {
		i_total_no=rs.getInt(1);  //총 글수
	  }

	  if(i_total_no%i_list_num==0) { // 전체 글 수를 페이지당 글 수로 나눈 값의 올림 값 = 전체 페이지 수를 구합니다.
		i_total_page = i_total_no/i_list_num;
	  } else {
		i_total_page = (i_total_no/i_list_num)+1; // 올림 수 구하기
	  }

	  i_cur_num = i_total_no - i_list_num*(i_page-1); // 현재 글의 가상 번호(실제 테이블의 number 값과는 다릅니다.)

	  int curRows = 0;
	  curRows = (Integer.parseInt(s_page) - 1) * i_list_num;

	  if (Integer.parseInt(s_page) == 1) {
		// 1페이지만 존재하니 그냥 셀렉트
		query = new StringBuffer(" SELECT B.IDX, B.ID, B.NAME, B.CONTENT, B.I_DATE  \n")
		.append(" FROM ASAN.EVENT_SUMMER B\n") 
		.append(" ORDER BY B.IDX DESC  \n") 
		.append(" FETCH FIRST "+i_list_num+" ROWS ONLY   \n") 
		.toString();
	  } else {
		query = new StringBuffer(" SELECT B.IDX, B.ID, B.NAME, B.CONTENT, B.I_DATE  \n") 
		.append(" FROM ASAN.EVENT_SUMMER B \n") 
		.append(" WHERE IDX NOT IN \n") 
		.append(" ( \n") 
		.append(" SELECT IDX FROM ( \n") 
		.append(" SELECT A.IDX  \n") 
		.append(" FROM ASAN.EVENT_SUMMER A \n") 
		.append(" ORDER BY A.IDX DESC \n") 
		.append(" FETCH FIRST "+curRows+" ROWS ONLY  \n")  
		.append(" ) AS TMP \n") 
		.append(" )  \n") 
		.append(" ORDER BY B.IDX DESC \n") 
		.append(" FETCH FIRST "+i_list_num+" ROWS ONLY   \n") 
		.toString();
	  }
	  
	  pstmt = conn.prepareStatement(query);
	  rs = pstmt.executeQuery(); 
		
	  String idx = ""; 
	  String name = "";
	  String content = "";
	  String i_date = "";

	  while (rs.next()) {             
		idx = rs.getString("IDX"); 
		name = rs.getString("NAME"); 
		content = rs.getString("CONTENT"); 
		i_date = rs.getString("I_DATE").substring(0,10); 	  
			%>
		<tr>
          <td width="110" height="50" align="center" class="font"><%=name%></td>
          <td width="479" style="padding:0 10 0 10;" class="font"><%=content%></td>
          <td width="109" align="center" class="num"><%=i_date%></td>
        </tr>
        <tr>
          <td height="1" colspan="3" align="center" background="<%=imageServer%>/summer_img/line_03.gif"></td>
        </tr>
        <% 
				  }  
			%> 
		   <% 
		    }catch (Exception e) {
				e.printStackTrace();
				System.out.println("Exception during connection :"+e.getMessage());
			} finally {
				UtilDB.closeConnection(conn, pstmt, rs);
			}
		%> 
        <tr>
          <td height="1" colspan="3" align="center" bgcolor="000000"></td>
        </tr>
        <tr>
          <td height="30" colspan="3" align="center">
		  <table width="700" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="400" align="center">
			  <table width="200" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <%
				/*************************************
				*페이지 링크
				**************************************/

				if (i_total_page%i_page_num==0) { // 전체 블록의 수 : 전체 페이지 수를 한 화면에 보이는 페이지 수로 나눔
						i_total_block = i_total_page/i_page_num; 
				} else {
						i_total_block = (i_total_page/i_page_num)+1; 
				}

				if (i_page%i_page_num==0) {
						i_block = i_page/i_page_num; // 현재 블록의 번호 : 
				}
				else {
						i_block = (i_page/i_page_num)+1;
				}

				i_first = (i_block-1)*i_page_num; // 현재 블록이 시작하는 첫 페이지
				i_last = i_block*i_page_num; // 현재 블록의 끝 페이지

				if(i_block >= i_total_block) {
						i_last = i_total_page;
				} 
				%>

				  <td width="18">
					<%
					if(i_page>1) {
							i_prev = i_page-1;
							out.println("<a href='summer_event_list.jsp?page="+i_prev+"'><img src='"+imageServer+"/summer_img/arr_l.gif' width='18' height='9' border='0'></a> ");
					} else {
						out.println("<img src='"+imageServer+"/summer_img/arr_l.gif' width='18' height='9' border='0'>");
					}
					%>
					</td>
				  <td width="164" height="32" align="center" class="num">
				  <%
					for (i_page_link=i_first+1;i_page_link<=i_last;i_page_link++) {
						if(i_page_link==i_page) {
								out.println("<strong>"+i_page_link+" </strong>");
						} else {
								out.println("<a href='summer_event_list.jsp?page="+i_page_link+"'>["+i_page_link+"]</a>");
						}
				}
				%></td>
                  <td width="18" align="right">
				<%
				if (i_total_page > i_page) {
						i_next = i_page+1;
						out.println(" <a href='summer_event_list.jsp?page="+i_next+"'><img src='"+imageServer+"/summer_img/arr_r.gif' width='18' height='9' border='0'></a>");
				} else {
					out.println("<img src='"+imageServer+"/summer_img/arr_r.gif' width='18' height='9' border='0'>");

				}
				%>
				</td>
                </tr>
              </table></td>
              <td width="300"><a href="javascript:parentGO();"><img src="<%=imageServer%>/summer_img/btt_go_event.gif" width="277" height="45" border="0"></a></td>
            </tr>
          </table></td>
        </tr>
      </table>
</body>