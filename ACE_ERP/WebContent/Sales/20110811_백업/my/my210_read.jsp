<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ��������
 * ���α׷�ID 	: CU010i
 * J  S  P		: cu010i
 * �� �� ��		: Cu010i
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������		: �������� (��)
 * [��  ��   ��  ��][������] ����
 * [2008-01-03][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.*, java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My210DTO" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�

try {
   // ContextPath
   String dirPath = request.getContextPath(); //HDASan
   
   ArrayList data3 = new ArrayList();
   SmartRequest sr3 = new SmartRequest(request);
   String where_sql3     = "";
//   String brd_gu = request.getParameter("brd_gu");
   
   String brd_gu 	= sr3.getString("brd_gu");
   String brd_no 	= sr3.getString("brd_no");
   String work_flag = sr3.getString("work_flag");
   String ref 		= sr3.getString("ref");
   String ref_step	= sr3.getString("ref_step");


   int len3 = 0;
   BaseDataClass bean3;
   String key = sr3.getString("search_key");
   String values = sr3.getString("search_value");
   
   sr3.setObject("where_sql",(Object)where_sql3);
   sr3.setObject("brd_no", (Object)brd_no);
   My210Manager manager3 = new My210Manager();
   My210DTO dto = manager3.select(sr3);
   manager3.close();


	//���ϸ���Ʈ html �����
    StringBuffer sb = new StringBuffer();
	String real_fileList = dto.getReal_file();	//���� �ҷ��ͼ� 
	String sys_fileList = dto.getSys_file();
	String fileHtml		="";

	String real_file[] = real_fileList.split(":");	//�迭�� ����
	String sys_file[] = sys_fileList.split(":");	//�迭�� ����
	
		for(int j=0; j<sys_file.length; j++){

			sb.append(" <a href='"+ dirPath +"/Common/sys/download.jsp?dir=board&filename="+real_file[j]+"&sysfilename="+sys_file[j]+"' >"+ real_file[j] +"</a> |");
		};
		
	fileHtml = sb.toString();
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
	<!--
	get_cookdata();
			
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(404);	//Ʈ���ʱ�ȭ ȣ��
								
		fnInit(); 

	}	
	
	function fnInit(){
		//�б�ȭ�� �б���������.
//		var oEditor = FCKeditorAPI.GetInstance('brd_contents') ;
//		oEditor.EditorDocument.body.contentEditable = false;
//		oEditor.EditorDocument.body.unselectable = true;	
	};
	
	function list(){
		var f = document.form1;
		f.action = "my210_list.jsp?idx=404";
		f.submit();
	}
	
	function edit(){
		var  f = document.form1;	
		if(GetCookie("vusrnm")=="<%=dto.getBrd_creator()%>") {
			f.work_flag.value = "MODIFY";
			f.action = "my210_write.jsp?idx=404";
			f.submit();
		}else{
			alert("�ۼ��ڸ� ���� �����մϴ�.");
		};
	}
	
	function reply(){
		var f = document.form1;
		f.work_flag.value = "REPLAY";
		f.action = "my210r.jsp?idx=404";
		f.submit();
	}
	
	function fnDelete() {
		var f = document.form1;
		if(GetCookie("vusrnm")=="<%=dto.getBrd_creator()%>") {
			f.work_flag.value = "DELETE";
			f.action = "my210_exec.jsp";
			f.submit();
		}else{
			alert("�ۼ��ڸ� ���� �����մϴ�.");
		};
	}	


	
	//-->
	</script>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

		<table border=0 cellpadding="0" cellspacing="0" width="700" bgcolor="#F2F1E2">
		  <form name="form1" method=post>
		  <input type="hidden" name="brd_no" value="<%=brd_no%>">                                                                                            
		  <input type="hidden" name="brd_gu" value="<%=brd_gu%>">                                                                                            
		  <input type="hidden" name="search_key" value="<%=key%>">                                                                                           
		  <input type="hidden" name="search_values" value="<%=values%>">                                                                                     
		  <input type="hidden" name="ref" value="<%=ref%>">                                                                                                 
		  <input type="hidden" name="ref_step" value="<%=ref_step%>">                                                                                       
		  <input type="hidden" name="work_flag">
		  <input type="hidden" name="idx" value="404">		  

			<col width="11"></col>
			<col width="47" style="padding-left:10"></col>
			<col width="1"></col>
			<col width="418" style="padding-left:10"></col>
			<col width="47" style="padding-left:10"></col>
			<col width="1"></col>
			<col width="88" style="padding-left:10"></col>
			<col width="11"></col>
			<tr>
				<td valign="top" rowspan="3" background="http://www.hdasan.com/img/common/bbs_left_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_tleft.gif"></td>
				<td colspan="6" height="1" bgcolor="#DEDDCF"></td>
				<td valign="top" rowspan="3" background="http://www.hdasan.com/img/common/bbs_right_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_tright.gif"></td>
			</tr>
			<tr height="30">
				<td><img src="http://www.hdasan.com/img/common/bbs_title.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_subject()%></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_name.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_creator()%></td>
			</tr>
			<tr><td colspan=8 height="1" bgcolor="#DEDDCF"></td></tr>
			<tr height="30">
				<td valign="bottom" rowspan="2" background="http://www.hdasan.com/img/common/bbs_left_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_bleft.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_file.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=fileHtml%></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_date.gif"></td>
				<td><img src="http://www.hdasan.com/img/common/bbs_bar_center.gif"></td>
				<td class="bbs"><%=dto.getBrd_cdate2()%></td>
				<td valign="bottom" rowspan="2" background="http://www.hdasan.com/img/common/bbs_right_bg.gif"><img src="http://www.hdasan.com/img/common/bbs_bright.gif"></td>
			</tr>
			<tr><td colspan="6" height="1" bgcolor="#DEDDCF"></td></tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="700" height="370">
			<tr>
				<td valign="top" style="padding: 15 20 20 15" class="bbs">
				<!-- ���� : ������ ��� 2098-03-12 by �ɵ��� -->
				<FCK:editor id="brd_contents" basePath="/FCKeditor/" 
					width="100%" height="360" 
					toolbarSet="asan_read">
					<%=dto.getBrd_contents()%>
				</FCK:editor>						
				</td>
			</tr>
		  </form>                                                                                                          
		</table>
		<!-- //Press READ-->

		<table border="0" cellpadding="0" cellspacing="0" width="700">
			<tr><td colspan="2" height="1" bgcolor="#DBDACB"></td></tr>
		</table>

		<!-- Button-->
		<table border="0" cellpadding="0" cellspacing="0" width="700">
			<tr><td height="8"></td></tr>
			<tr>
				<td align="right">
					<!-- a href="javascript:reply();"><img src="../images/b_reply.gif" border="0"></a-->                                                    
					<a href="javascript:edit();"><img src="../images/b_edit.gif" border="0"></a>                                                            
					<a href="javascript:fnDelete();"><img src="../images/b_del.gif" border="0"></a>                                                         
					<a href="javascript:list();"><img src="../images/b_list.gif" border="0"></a>
					
				</td>
			</tr>
		</table>
		<!-- Button-->
<br><br>

                                                                                                                                                        
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	