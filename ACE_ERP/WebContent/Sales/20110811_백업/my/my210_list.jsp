<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%  response.setContentType("text/html; charset=euc-kr"); %>
<%
/******************************************************************************
 * �ý��۸�      	: ����������
 * ���α׷�ID 	: CU010i
 * J  S  P      : cu010i
 * �� �� ��      		: My210DAO,My210DTO,My210Manager
 * �� �� ��      		: ����ǥ
 * �� �� ��      		: 2006-06-15
 * �������      	: �������� ��ȸ
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-03-14][�ɵ���] ���ο� ������ ����
 * [2008-09-03][�ɵ���] �˻�â ������ : ��Ƽ��Ʈ�� ������ �ѱ��� �� �޳׿�.. ���..
 * [2008-11-12][�ɵ���] �˻��κ� ��=��Ƽ��Ʈ. �б�� ���� ��(�ű�)=�Ϲ�.. 
 *						�̷��� �ؾ� ���������� ���� �޾ư���... ��;; ��..
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>

<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

	SmartRequest sr3 = new SmartRequest(request);
	String key 			 = sr3.getString("search_key");
	String values 		 = sr3.getString("search_value");
	// �ᱹ �ѱ��� �޾ƿ��鼭 ������ ���� �����Դϴ�. ��_��;; ��..
	// ��Ƽ��Ʈ�� ������ �ȴ�!
	String requestedPage = sr3.getString("requestedPage");
	String pageSize  	 = "10";  	//1�������� ǥ�õ� ����
	String where_sql3    = "";
	//������ �����.
	if (values !=  null && !values.equals("")){	
    	where_sql3=" AND " + key + " like '%" + values + "%'";
	}
   
	ArrayList data3 = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
	int len3 = 0;
	String brd_gu = "01";	//���� ����~!
	BaseDataClass bean3;

	ArrayList data_all = new ArrayList();	//�Խù� ��ü ī��Ʈ�� �޾ƿ� �� ����.     
	
	//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
	sr3.setObject("where_sql",(Object)where_sql3);	//������ ����
	sr3.setObject("brd_gu",(Object)brd_gu);			//���� ���� ����
	sr3.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
	sr3.setObject("pageSize",(Object)pageSize);			//������ ������ ����
	sr3.setObject("search_key",(Object)key);			//������ ������ ����

	My210Manager manager3 = new My210Manager();
	data3 		= manager3.list(sr3);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
	data_all 	= manager3.alllist(sr3);	//�ش� ������ ��ü �Խù� ���� ī��Ʈ�ؿ���
	manager3.close();

	//************************************************************************************
	// ������ ���� ���� ����
	int allPageCnt, totalRowCnt, position, allRecordCnt;
	
	bean3 = (BaseDataClass)data_all.get(0);
	totalRowCnt = Integer.parseInt(bean3.get("brd_no"));	// ��ü �ο� ����

	allPageCnt	= (totalRowCnt / Integer.parseInt(pageSize) ) + 1;	//�� ������ ���� 

	position 	= HDUtil.nullCheckNum(sr3.getString("position")); //����¡ �������� ���� ��ġ.

	// ���� ������ ���� : �⺻��
	if (requestedPage ==  null || requestedPage.equals("")){
		requestedPage="1"; 
	}  
	// ����¡ �������� ���� ��ġ- 1���������� ������ �⺻ �� 1������.
	if (position < 1 ){
		position = 1; 
	}  
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript"> 
	function fnOnLoad(tree_idx){
		fnInit_tree(404);	//Ʈ���ʱ�ȭ ȣ��
	}
	</script>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<script language="javascript"> 	
   function view_send(brd_no,ref,ref_step){
   	 var f = document.searchForm;
      f.action="my210_read.jsp?idx=404";
      f.brd_no.value = brd_no;
      f.ref.value = ref;
      f.ref_step.value = ref_step;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
   function write_ok(){
    var f = document.searchForm;
		f.action='my210_write.jsp?idx=404&work_flag=INSERT';
		f.target='';
		f.method = "POST";
		f.submit();
   }
   
   
   
   function sel_chk(){
    var f = document.searchForm;
      if(f.search_value.value==""){alert('�˻�� �־� �ּ���'); f.search_value.focus();  return;}
      f.action='my210_list.jsp?idx=404';
      f.taget='';
      f.method = "POST";
      f.submit();
   }
   function sel_chk_enter(){
      if(event.keyCode=="13"){
         sel_chk()
       }
   }


   function goPage(requestedPage,position){
    var f = document.searchForm;
      f.action='my210_list.jsp?idx=404';
      f.requestedPage.value= requestedPage;
      f.position.value= position;            
      f.taget='';
      f.method = "POST";
      f.submit();
   }
  
</script>


<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	
<!-- Search-->
<table border="0" cellpadding="0" cellspacing="0" width="724">
<form name="searchForm" enctype="MULTIPART/FORM-DATA">		
  <input type="hidden" name="idx" value="404">
  <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
  <input type="hidden" name="brd_no" value="01">
  <input type="hidden" name="ref" value="">
  <input type="hidden" name="ref_step" value="">
  <input type="hidden" name="requestedPage" value="<%=requestedPage%>">
  <input type="hidden" name="position" value="">

  <tr>
	<td width="70"><img src="http://www.hdasan.com/img/common/search_left.gif"></td>
	<td background="http://www.hdasan.com/img/common/search_bg.gif" align="right" style="padding-right:10">

		<table border="0" cellpadding="0" cellspacing="0" width="">
		<tr>
			<td width="92">
				 <SELECT name="search_key" ID="Select02" STYLE="width:87px;height:15px;display:;">
					<OPTION VALUE='BRD_SUBJECT' <%= key.equals("BRD_SUBJECT") ? "selected" : "" %>>����</OPTION>
					<OPTION VALUE='BRD_CONTENTS' <%= key.equals("BRD_CONTENTS") ? "selected" : "" %>>����</OPTION>
					<OPTION VALUE='BRD_CREATOR' <%= key.equals("BRD_CREATOR") ? "selected" : "" %>>�ۼ���</OPTION>
				</SELECT>
			</td>
			<td width="145"><input type="text" name="search_value" style="width:140; height:18;" class="textbox" value='<%=values%>' onkeyup="sel_chk_enter()"></td>
			<td><img src="http://www.hdasan.com/img/common/btn_search.gif" border=0 onclick="sel_chk();" style="cursor:hand"></td>
		</tr>
		</table>

	</td>
	<td width="5" align="right"><img src="http://www.hdasan.com/img/common/search_right.gif"></td>
  </tr>
</form>
</table>
<!-- Search-->

<table border="0" cellpadding="0" cellspacing="0" width="724" height="8"><tr><td></td></tr></table>

<!-- News LIST-->
   <table border="0" cellpadding="0" cellspacing="0" width="724">
     <col width="60" align="center"></col>
     <col width="1" valign="top"></col>
     <col width="430" style="padding-left:10px"></col>
     <col width="1" valign="top"></col>
     <col width="95" align="center"></col>
     <col width="1" valign="top"></col>
     <col width="80" align=center></col>
     <col width="1" valign="top"></col>
     <col width="55" align="center"></col>

     <tr> 
       <td colspan="9" height="3" bgcolor="#DBDACB"></td>
     </tr>
     <tr height="25" bgcolor="#F5F5E9" align="center"> 
       <td><img src="http://www.hdasan.com/img/common/bbs_number.gif"></td>              
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_title.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_name.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_date.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_hit.gif"></td>
     </tr>
     
  <%if ( data3.size() == 0 ) { %>
  <tr><td colspan="9" height="1" bgcolor="#DBDACB"></td></tr>
  <tr height="30" bgcolor="#F5F5E9">
	<td colspan=9 align=center>��ϵ� ���� �����ϴ�.</td>
  </tr>
  <%} else {
     	len3 = data3.size();
	   bean3 = null;

         for(int h = 0; h < len3 ; h++) {
       	bean3 = (BaseDataClass)data3.get(h);
     %>
     <tr> 
       <td colspan=9 height="1" bgcolor="#DBDACB"></td>
     </tr>
     <tr height="30" > 
       <td><%=bean3.get("brd_no")%></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><a href="javascript:view_send('<%=bean3.get("brd_no")%>','<%=bean3.get("ref")%>','<%=bean3.get("ref_step")%>');">
       	<%=bean3.get("brd_subject")%></a></td>
	<td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><%=bean3.get("brd_creator")%></td>
	<td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><%=bean3.get("brd_cdate")%></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><%=bean3.get("brd_viewcnt")%></td>
     </tr>
  <%  }
	}
  %>			  
  
     <tr> 
       <td colspan=9 height="1" bgcolor="#DBDACB"></td>
     </tr>
</table>
<!-- //News LIST-->

<!-- Paging-->
<table border="0" cellpadding="0" cellspacing="0" width="624">
<tr height="45">
	<td align="center">
		<!-- /paging -->
		<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
		<tr>
			<td align="center">
				<%=HDUtil.doPageCut( Integer.parseInt(requestedPage), allPageCnt , position 
									, "javascript:", "500", "idx=404"
									,dirPath + "/Sales/images/", Integer.parseInt(pageSize) )%>
            </td>
		</tr>
		</table>
		<!-- paging/ -->	
	</td>
</tr>
<tr><td colspan=9 height="1" bgcolor="#DBDACB"></td></tr>
</table>
		
<!-- Button-->
<table border="0" cellpadding="0" cellspacing="0" width="724">
	<tr><td height="8"></td></tr>
	<tr>
		<td align="left">  
			<a href="my210_list.jsp?idx=404"><img src="<%=dirPath%>/Sales/images/b_list.gif" border="0" align="absmiddle"></a>  
		</td>

		<td align="right">
			<a href="javascript:write_ok();"><img src="<%=dirPath%>/Sales/images/b_write.gif" border="0" align="absmiddle"></a>  
		</td>
	</tr>
</table>
<!-- Button-->				
                      

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

