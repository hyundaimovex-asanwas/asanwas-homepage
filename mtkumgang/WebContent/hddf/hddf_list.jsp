<%--
  - �ۼ���: �ɵ���
  - ����: 2015.05.19
  - ����: ����鼼�� ��ǰ�ȳ� ����Ʈ
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="com.hddutyfree.Df_item_bean"%>
<%@ page import="com.hddutyfree.Df_item_info"%>
<%@ page import="java.util.*, java.text.*"%>

<%

//���� ����
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
int pageSize = 12;	//1�������� ��ǰ �� ���� 
int blockSize = 10;	//������ ���� �� �� ������ ��������

// DB���� ��ü(ibatis���)  
Df_item_info dao = new Df_item_info();
// �˻� - �÷���
String part       = ParamUtil.getReqParameter(request.getParameter("part"));

// �˻� - �Ķ���� (��ǰ����)
String key_str = "&part="+part;
//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);
// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);
// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// �Խù� ���
Df_item_bean record [] = dao.getGoodsList(requestedPage, pageSize, part);

// ��ü �Խù� ��
int allCount = dao.getCount(part);
// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
%>

<html>
<head>
<title>���� �鼼�� �̿� �ȳ�</title>
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
						<option value="" <%if(part.equals("")){%>selected<%}%>>��ü</option>
						<option value="01"  <%if(part.equals("01")){%>selected<%}%>>�ַ�</option>
						<!-- <option value="02"  <%if(part.equals("02")){%>selected<%}%>>���</option>  -->
						<option value="03"  <%if(part.equals("03")){%>selected<%}%>>�ǰ���ǰ</option>
						<option value="04"  <%if(part.equals("04")){%>selected<%}%>>ȭ��ǰ</option>
						<option value="05"  <%if(part.equals("05")){%>selected<%}%>>���</option>
						<option value="06"  <%if(part.equals("06")){%>selected<%}%>>��ǰ</option>
						<option value="07"  <%if(part.equals("07")){%>selected<%}%>>�ð�</option>
						<option value="08"  <%if(part.equals("08")){%>selected<%}%>>��ȭ</option>
					</select><a href="javascript:searchCh()"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="5"></a>
					<!-- search/ -->
					�鼼���� ���� �̿��Ͻø� ���� �پ��� �������� ��ǰ�� ������ �� �ֽ��ϴ�.  
				</td>
				
			  </tr>
		  	</form>
		  	</table>
		  	<span style="color:orange">�����ǰ�� : �ַ� 90ǰ�� / ��� 60ǰ�� / ȭ��ǰ 500ǰ�� / ��� 170ǰ��/ �ǰ���ǰ 50ǰ�� / �ð� 420ǰ��/ ��ȭ 400ǰ�� / ��Ȱ���� 100ǰ�� ��  �ټ�</span>
		  	
		  	<table width="769" cellpadding="0" cellspacing="0" border="0">
			  <tr>
				<td valign="top">
					<!-- / list table  -->
					<table cellpadding="0" cellspacing="0" border="0" width="769">
					<col width="190"><col width="190"><col width="190"><col width="190">
					
			<% if(record.length <= 0){ %>
					<tr align="center">
						<td height="26" align="center" colspan="4">��ϵ� �����Ͱ� �����ϴ�.</td>
					</tr>
					<tr><td height="1" colspan="4" class="line_g2"></td></tr>
			<%
			}else{
				//����Ʈ ȭ�鿡 ����
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
			
					//õ����
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
				          <!-- �ѱ� -->
				          <tr>
				          	<td align=center><b>[<%=g_maker%>]</b></td>
				          </tr>
				          <tr>
				          	<td align=center><a href="hddf_view.jsp?idx=<%=idx%>&requestedPage=<%=requestedPage%>" class="listtxt04"><%=g_name%></a></td>
				          </tr>
				          
				          <!-- ���� 
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
				            		  <b>���� ��������</b>
				            <%}else{%><b>��<%=s_price%></b>	
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