<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.my.BaseDataClass" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.common.HDConstant" %>
<%
/******************************************************************************
 * �ý��۸�      	: 
 * ���α׷�ID 	: 
 * J  S  P      : 
 * �� �� ��      : 
 * �� �� ��      		: ����ǥ
 * �� �� ��      		: 2006-06-15
 * �������      	: �������� ����Ʈ
 * ��������      	:
 * �� �� ��      		: 
 * ������������    	: 
 * TODO         :
 * TODO         :
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description    :  JAVA Import 

%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description    :  �ڹ��ڵ�

   // ContextPath
   String dirPath = request.getContextPath(); //HDASan

	String servletPath = "/services/servlet/sales.common.my.BaseServlet";
  ArrayList data = (ArrayList)request.getAttribute("DATA");
	BaseDataClass param = (BaseDataClass)request.getAttribute("PARAM");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD ���� -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
         Style Sheet, Common Java Script Link
=============================================================================*/
%>
   
 <script> 
   	function fnOnLoad(){

	}
	
	// ��������� �̵� 
	function fnGoInsertPage() {
		var f = document.form1;
		
		f.action = "<%=dirPath%>/Sales/my/my120i.jsp?menu_title=my120s&ut=A&mt=M";

		f.method = "post";
		f.submit();
	}
	
	
	// �� 
	function fnModify(id) {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my120s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_MODIFY%>'; // �۾� Ÿ��

		f.brd_no.value = id;

		f.method = "post";
		f.submit();
	}
  
   </script>
</head>
<jsp:include page="/Sales/common/include/body_s.jsp"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<form name="form1">
	<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table3">
                      <tr>
                        <td height="30" colspan="6" align="right">
                          <table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table4">
                            <tr>
                              <td height="25">
                                 <select name="search_key"  style="font-size=9pt;color : #ffffff ;background-color:#797979">
                                      <option value ="BRD_SUBJECT" >����</option>
                                      <option value ="BRD_CREATOR" >�ۼ���</option>
                                 </select>
                                 <input type="text" name="search_value" size="12" style="height:19px; border:1 solid; border-color: #cccccc; font-size: 12px;" onKeyDown="javascript:sel_chk_enter();" ID="Text1"> <a href="javascript:sel_chk();"><img src="<%=dirPath%>/Sales/images/b_search.gif" border="0" align="absmiddle"></a> </td>
                              <td width="100" align="right"><a href="javascript:fnGoInsertPage();"><img src="<%=dirPath%>/Sales/images/b_write.gif" border="0" align="absmiddle"></a> </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                         <td height="2" colspan='6' bgcolor="#CEC8DD"></td>
                      </tr>
                      <tr bgcolor="#F3F0F9">
                         <td width="50" align='center'><b><font color="#555555">��ȣ</font></b></td>
                         <td width="485" align='center'><b><font color="#555555">����</font></b></td>
                         <td width="60" align='center'><b><font color="#555555">÷������</font></b></td>
                         <td width="100" align='center'><b><font color="#555555">�ۼ���</font></b></td>
                         <td width="80" align='center'><b><font color="#555555">�ۼ���</font></b></td>
                         <td width="70" align='center'><b><font color="#555555">��ȸ��</font></b></td>
                      </tr>
                      <tr>
                        <td height="1" colspan='6' bgcolor="#CEC8DD"></td>
                      </tr>
                
                   </table></td>
                   </tr>
                   <tr>
                     <td width="100%"><div id='hscroll_box'><div id='vscroll_box'><table width="100%" border="0" cellspacing="0" cellpadding="0" ID="Table3">
<%
                           if(data == null || data.size() < 1 ) {
%>
                            <tr>
                               <td colspan='6' align='center' height='800'><b>�Խù��� �����ϴ�.</b></td>
                             </tr>
<%
                           } else  {
                         	 BaseDataClass value = null;
                         	 int no  =data.size();
								if (data.size() > 0) {
									for (int i = 0; i < data.size(); i++) {
										value = (BaseDataClass)data.get(i);
%>
				                          <tr>
				                            <td height=1 colspan='6'></td>
				                          </tr>
				                          <tr>
				                            <td width="50" align='center' height='20'><%=no--%></td>
				                            <td width="485" align='left'>&nbsp;&nbsp;
				                            	<a href="javascript:fnModify(<%=value.get("brd_no")%>);">
<%
                                		int wid=0;
                                		if(Integer.parseInt(value.get("ref_step"))>0){
                                      		wid = 10 * Integer.parseInt(value.get("ref_step"));
%>
                             						<img src="<%=dirPath%>/Sales/images/space.gif" width="<%=wid%>" height="10"  border="0" ><img src="<%=dirPath%>/Sales/images/re.gif" border="0">
<%
                                 		}
%>
												<%=value.get("brd_subject")%>
												</a></td>
												<td width="60" align="center">
											
											<%
												if (!"".equals(value.get("sys_file").trim())) {
											%>
											<a href="<%=dirPath%>/Sales/my/fileDownload.jsp?down=<%=value.get("sys_file")%>" target="" >
											<img src="<%=dirPath%>/Sales/images/file.gif" border=0 align="absmiddle"></a>
											<%
												}
											%>
											</td>
				                            <td width="100" align="center"><%=value.get("brd_creator")%></td>
				                            <td width="80" align="center"><%=value.get("brd_cdate").substring(0,10)%></td>
				                            <td width="70" align="center"><%=value.get("brd_viewcnt")%></td>
				                          </tr>
				                          <tr>
				                            <td height="1" colspan="6" background="<%=dirPath %>/Sales/images/line_pt.gif"></td>
				                          </tr>
<%
                           			}
                       			}
                       	}
%>
                        <tr>
                          <td height="4" colspan='6' bgcolor="#ECE9F1"></td>
                           </tr>
                      </table></div></div>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
				 	
		<input type="hidden" name="brd_no" 	value="">
		          
		<input type="hidden" name="actId" 			value=""> 	<!-- �׼� ID -->
		<input type="hidden" name="process_flag" 	value=""> 	<!-- �۾� �÷��� -->
   </form>
<jsp:include page="/Sales/common/include/body_e.jsp"/>
