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

	int i_cur_num=0, i_total_no=0, i_total_page=0; // ���� �� ��ȣ

	int i_page_num = 10; // �� ȭ�鿡 ������ ������ ��ũ ���� -> ���

	int i_list_num = 10 ; // �� �������� ������ �Խù��� ��

	int i_total_block, i_block;

	int i_first, i_last, i_block_prev, i_block_next, i_page_link;

	int i_page, i_prev, i_next;

	String s_page, s_writetime ;

	s_page = request.getParameter("page"); // pray_event_view.jsp?page=3 �� ���� �Ѿ�� �� "3"�� �Ѱܹ���.

	if(s_page==null) s_page="1"; // �׳� pray_event_view.jsp�� ���� ���

	i_page = Integer.parseInt(s_page);

	int i_offset = i_list_num*(i_page-1); //�� �������� ���� �� ��ȣ(i_listnum ����ŭ �������� �� �����ϴ� ���� ��ȣ)

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���� D-100�� ���ʺ� �⵵ �̺�Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="800" height="600" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="60" colspan="2"><img src="<%=imageServer%>/moon_img/tit.gif" width="800" height="60"></td>
  </tr>
  <tr> 
    <td height="60" colspan="2" align="right" background="<%=imageServer%>/moon_img/bg.gif"><a href="pray_event_write.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/moon_img/btn_wri.gif" width="165" height="50" hspace="44" vspace="10" border="0"></a></td>
  </tr>
  <tr>
    <td colspan="2" align="center" valign="top" background="<%=imageServer%>/moon_img/bg.gif"><table width="700" cellpadding="1" cellspacing="0" bgcolor="#FFFFFF">
        <tr> 
          <td height="33"><img src="<%=imageServer%>/moon_img/board_tit.gif" width="700" height="33"></td>
        </tr>
        <tr> 
          <td valign="top"><table width="700" cellspacing="0" cellpadding="5">
			<%    
			   Connection conn = null;
			   PreparedStatement pstmt = null; 
			   ResultSet rs = null;   
			   
			   String query = ""; 
			   try { 
				  conn = UtilDB.getConnection("jdbc/tourds"); 
				  query = "select count(*) from asan.EVENT_WISH"; 
				  pstmt = conn.prepareStatement(query); 
				  rs = pstmt.executeQuery(); 

				  if(rs.next()) {
					i_total_no=rs.getInt(1);  //�� �ۼ�
				  }

				  if(i_total_no%i_list_num==0) { // ��ü �� ���� �������� �� ���� ���� ���� �ø� �� = ��ü ������ ���� ���մϴ�.
					i_total_page = i_total_no/i_list_num;
				  } else {
					i_total_page = (i_total_no/i_list_num)+1; // �ø� �� ���ϱ�
				  }

				  i_cur_num = i_total_no - i_list_num*(i_page-1); // ���� ���� ���� ��ȣ(���� ���̺��� number ������ �ٸ��ϴ�.)

				  int curRows = 0;
				  curRows = (Integer.parseInt(s_page) - 1) * i_list_num;

				  //query = "select IDX, ID, NAME, CONTENT, I_DATE from asan.EVENT_WISH "; 				  
				  //out.println(query);

				  /*query = new StringBuffer(" select IDX, ID, NAME, CONTENT, I_DATE, RN  \n")
						.append(" FROM  (SELECT TT.*, rownumber() OVER (ORDER BY IDX DESC)  AS RN FROM asan.EVENT_WISH TT) AS TR \n")
						.append(" where RN between "+i_offset+" and "+i_list_num+" \n")
						.toString();
				  out.println(query);

				  query = new StringBuffer(" SELECT B.IDX, B.ID, B.NAME, B.CONTENT, B.I_DATE  \n") 
				    .append(" FROM ASAN.EVENT_WISH B \n") 
					.append(" WHERE IDX NOT IN \n") 
					.append(" ( \n") 
					.append(" SELECT IDX FROM ( \n") 
					.append(" SELECT A.IDX  \n") 
					.append(" FROM ASAN.EVENT_WISH A \n") 
					.append(" ORDER BY A.IDX DESC \n") 
					.append(" FETCH FIRST 30 ROWS ONLY  \n")  
					.append(" ) AS TMP \n") 
					.append(" )  \n") 
					.append(" ORDER BY B.IDX DESC \n") 
					.append(" FETCH FIRST 10 ROWS ONLY ;   \n") 
					.toString();
				  out.println(query);
					*/
				  if (Integer.parseInt(s_page) == 1) {
					// 1�������� �����ϴ� �׳� ����Ʈ
					query = new StringBuffer(" SELECT B.IDX, B.ID, B.NAME, B.CONTENT, B.I_DATE  \n")
					.append(" FROM ASAN.EVENT_WISH B\n") 
					.append(" ORDER BY B.IDX DESC  \n") 
					.append(" FETCH FIRST "+i_list_num+" ROWS ONLY   \n") 
					.toString();
				  } else {
					query = new StringBuffer(" SELECT B.IDX, B.ID, B.NAME, B.CONTENT, B.I_DATE  \n") 
				    .append(" FROM ASAN.EVENT_WISH B \n") 
					.append(" WHERE IDX NOT IN \n") 
					.append(" ( \n") 
					.append(" SELECT IDX FROM ( \n") 
					.append(" SELECT A.IDX  \n") 
					.append(" FROM ASAN.EVENT_WISH A \n") 
					.append(" ORDER BY A.IDX DESC \n") 
					.append(" FETCH FIRST "+curRows+" ROWS ONLY  \n")  
					.append(" ) AS TMP \n") 
					.append(" )  \n") 
					.append(" ORDER BY B.IDX DESC \n") 
					.append(" FETCH FIRST "+i_list_num+" ROWS ONLY   \n") 
					.toString();
				  }
				  
				  //out.println(query);
				  
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
                <td width="100" height="27" align="center"><%=name%></td>
                <td width="460" style="padding-left:10px;"><%=content%></td>
                <td width="108" align="center"><%=i_date%></td>
              </tr>
              <tr bgcolor="#DDE1EA"> 
                <td height="1" colspan="3"> </td>
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

            </table></td>
        </tr>
        <tr> 
          <td height="2" bgcolor="#99CC00"> </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><table width="180" align="center" cellpadding="0" cellspacing="0" class="loca_01">
		      <%
				/*************************************
				*������ ��ũ
				**************************************/

				if (i_total_page%i_page_num==0) { // ��ü ����� �� : ��ü ������ ���� �� ȭ�鿡 ���̴� ������ ���� ����
						i_total_block = i_total_page/i_page_num; 
				} else {
						i_total_block = (i_total_page/i_page_num)+1; 
				}

				if (i_page%i_page_num==0) {
						i_block = i_page/i_page_num; // ���� ����� ��ȣ : 
				}
				else {
						i_block = (i_page/i_page_num)+1;
				}

				i_first = (i_block-1)*i_page_num; // ���� ����� �����ϴ� ù ������
				i_last = i_block*i_page_num; // ���� ����� �� ������

				if(i_block >= i_total_block) {
						i_last = i_total_page;
				} 
				%>
              <tr> 
                <td width="25" align="center">
				<%
					if(i_page>1) {
							i_prev = i_page-1;
							out.println("<a href='pray_event_view.jsp?page="+i_prev+"'><img src='"+imageServer+"/moon_img/page_pre.gif' width='24' height='13' border='0'></a> ");
					}
				%>
				</td>
                <td><div align="center"> 
				<%
				for (i_page_link=i_first+1;i_page_link<=i_last;i_page_link++) {
						if(i_page_link==i_page) {
								out.println("<strong>"+i_page_link+" </strong>");
						} else {
								out.println("<a href='pray_event_view.jsp?page="+i_page_link+"'>["+i_page_link+"]</a>");
						}
				}
				%>
				</div></td>
                <td width="25" align="center">
				<%
				if (i_total_page > i_page) {
						i_next = i_page+1;
						out.println(" <a href='pray_event_view.jsp?page="+i_next+"'><img src='"+imageServer+"/moon_img/page_next.gif' width='24' height='13' border='0'></a>");
				}
				%>
				</td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
