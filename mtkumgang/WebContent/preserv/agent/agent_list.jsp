<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.06.08  
  - ���۱� ǥ��: IMJ Korea
  - ����: ����Ʈ - �븮�� �ȳ�
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Agent_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.AgentInfo"%>
<%@ page import="java.util.*"%>
<%
//���� ����
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

// DB���� ��ü(ibatis���)  
AgentInfo dao = new AgentInfo();

// �˻� - �����ڵ�
area_cd = ParamUtil.getReqParameter(request.getParameter("area_cd"));
keyword = ParamUtil.getReqParameter(request.getParameter("keyword"));
part = ParamUtil.getReqParameter(request.getParameter("part"));

Agent_bean agent_record[] = dao.getAgentList(area_cd,keyword,part);
%>
<html>
<head>
<title> �ݰ������      </title>
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
 //     alert("������ �����ϼ���.");
 //     form.part.focus();
 //     return;
 //  }
   if (form.keyword.value == ""){
      alert("Ű���带 �Է��ϼ���.");
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
//	window.open('/reservation/agent/popup_agent.jsp','agent_pop','left=0, top=0, width=500, height=470'); // �˾��������� ��ο� ũ�⸦ ���� �ϼ���
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
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">����/��û</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�븮�� �ȳ�</span></td>
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
							f_id = "agencyMap";//�÷��� ���̵�
							f_name ="<%=imageServer%>/tour_swf/agencyMap.swf"; //�÷��� ���ϸ�
							f_width = "395";//����ũ��
							f_height ="356"; //���γ���
							f_trans =""; //����, transparent(����)
							f_para =""; //�Ķ����
							show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
						</script>
					    <!--<a href="agent_list.jsp?area_cd=01">����</a>
					    <a href="agent_list.jsp?area_cd=02">�λ�</a>
					    <a href="agent_list.jsp?area_cd=03">�뱸</a>
					    <a href="agent_list.jsp?area_cd=04">��õ</a>
					    <a href="agent_list.jsp?area_cd=05">����</a>
					    <a href="agent_list.jsp?area_cd=06">����</a>
					    <a href="agent_list.jsp?area_cd=07">���</a>
					    <a href="agent_list.jsp?area_cd=51">���</a><br>
					    <a href="agent_list.jsp?area_cd=52">����</a>
					    <a href="agent_list.jsp?area_cd=53">���</a>
					    <a href="agent_list.jsp?area_cd=54">�泲</a>
					    <a href="agent_list.jsp?area_cd=55">���</a>
					    <a href="agent_list.jsp?area_cd=56">�泲</a>
					    <a href="agent_list.jsp?area_cd=57">����</a>
					    <a href="agent_list.jsp?area_cd=58">����</a>
					    <a href="agent_list.jsp?area_cd=59">����</a><br>
					    <a href="agent_list.jsp?area_cd=90">�ؿ�</a>-->
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
											<td rowspan="2"><a href="javascript:openSch()"><img src="<%=imageServer%>/tour_img/btn/btn_app_search.gif" align="absmiddle" style="margin-left:12px;"></a><!-- �˻� --></td>
										</tr>
<form name="frm" method="post" action="agent_list.jsp">
<input type="hidden" name="area_cd" value="<%=area_cd%>">
										<tr>
											<td height="19">
												<select name="part">
                                                  <option <%if(part.equals("")){%>selected<%}%> value=''>����</option>
                                                  <option <%if(part.equals("client_nm")){%>selected<%}%> value='client_nm'>�븮����</option>
                                                  <option <%if(part.equals("address")){%>selected<%}%> value='address'>�ּ�</option>
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
							<td height="26"><img src="<%=imageServer%>/tour_img/txt13.gif"><!-- �븮���� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt14.gif"><!-- �ּ� --></td>
							<td><img src="<%=imageServer%>/tour_img/txt15.gif"><!-- ��ȭ��ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt16.gif"><!-- �ѽ���ȣ --></td>
							<td><img src="<%=imageServer%>/tour_img/txt17.gif"><!-- Ȩ������ --></td>
						</tr>
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
            <% 
            if(agent_record.length <= 0){ 
            %>							
						<tr><td height="1" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="56" colspan="5">����� ���� �Ǵ� �븮�������� �˻����ּ���. </td>
						</tr>
						<tr><td height="1" colspan="5" class="line_g2"></td></tr>
            <%
            }else{
            	//����Ʈ ȭ�鿡 ����
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