<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.06.08
  - ���۱� ǥ��: IMJ Korea
  - ����: ����Ʈ - �븮�� �ȳ�
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Agent_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.AgentInfo"%>
<%@ page import="java.util.*"%>
<%
//���� ����
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

// DB���� ��ü(ibatis���)  
AgentInfo dao = new AgentInfo();

// �˻� - �����ڵ�
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
   if (form.schVal.value == "Ű���带 �Է��ϼ���"){
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
           <td class='title'><img src='../../asanway/img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>�븮�� �ȳ�</td>
          </tr>
         </table>
         <br>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <col width=40%>
         <col width=60%>
           <tr height=100 align=left>
             <td rowspan=2>
              ����Ư����&nbsp;&nbsp;
              �λ걤����&nbsp;&nbsp;
              �뱸������<br>
              ����������&nbsp;&nbsp;
              ���ֱ�����&nbsp;&nbsp;
              ��걤����<br>
              ��õ������&nbsp;&nbsp;
              ������&nbsp;&nbsp;
              ��⵵<br>
              ��󳲵�&nbsp;&nbsp;
              ���ϵ�&nbsp;&nbsp;
              ���󳲵�<br>
              ����ϵ�&nbsp;&nbsp;
              ��û����&nbsp;&nbsp;
              ��û�ϵ�<br>
              ���ֵ�&nbsp;&nbsp;
              �ؿ�
             </td>
             <td>
              <b>�븮�� ������ ��ȭ�ε� ������ �����Ͻ� �� �ֽ��ϴ�.</b>
             </td>
           </tr>
           <tr height=100 align=center>
             <td>
              ���������� ã�� 
              <select name="">
                <option value="">��ü</option>
                <option value="">����Ư����</option>
                <option value="">�뱸������</option>
                <option value="">���ֱ�����</option>
                <option value="">��걤����</option>
                <option value="">��õ������</option>
                <option value="">������</option>
                <option value="">��⵵</option>
                <option value="">��󳲵�</option>
                <option value="">���ϵ�</option>
                <option value="">���󳲵�</option>
                <option value="">����ϵ�</option>
                <option value="">��û����</option>
                <option value="">��û�ϵ�</option>
                <option value="">���ֵ�</option>
                <option value="">�ؿ�</option>
                <option value=""></option>
                <option value=""></option>
                <option value=""></option>
              </select>  
              <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="�˻�" class="btn" onclick="openSch()" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
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
             <td class=th>����</td>
             <td class=th>�븮����</td>
             <td class=th>�ּ�</td>
             <td class=th>��ȭ��ȣ</td>
             <td class=th>�ѽ���ȣ</td>
             <td class=th>Ȩ������</td>
         	</tr>
            <% 
            if(agent_record.length <= 0){ 
            %>	
            <tr><td colspan=6 height=1 class=linec1></td></tr> 
            <tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
            	<td colspan=8 align=center height=30>����Ÿ�� �������� �ʽ��ϴ�.</td>
            </tr>
            <tr><td colspan=7 height=1 class=linec1></td></tr>
            <%
            }else{
            	//����Ʈ ȭ�鿡 ����
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
