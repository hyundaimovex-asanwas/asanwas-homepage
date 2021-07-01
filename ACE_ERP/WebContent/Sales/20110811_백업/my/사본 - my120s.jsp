<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.my.BaseDataClass" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.common.HDConstant" %>
<%
/******************************************************************************
 * 시스템명      	: 
 * 프로그램ID 	: 
 * J  S  P      : 
 * 서 블 릿      : 
 * 작 성 자      		: 남기표
 * 작 성 일      		: 2006-06-15
 * 기능정의      	: 공지사항 리스트
 * 수정내용      	:
 * 수 정 자      		: 
 * 최종수정일자    	: 
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
// Description    :  자바코드

   // ContextPath
   String dirPath = request.getContextPath(); //HDASan

	String servletPath = "/services/servlet/sales.common.my.BaseServlet";
  ArrayList data = (ArrayList)request.getAttribute("DATA");
	BaseDataClass param = (BaseDataClass)request.getAttribute("PARAM");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD 정보 -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
         Style Sheet, Common Java Script Link
=============================================================================*/
%>
   
 <script> 
   	function fnOnLoad(){

	}
	
	// 등록페이지 이동 
	function fnGoInsertPage() {
		var f = document.form1;
		
		f.action = "<%=dirPath%>/Sales/my/my120i.jsp?menu_title=my120s&ut=A&mt=M";

		f.method = "post";
		f.submit();
	}
	
	
	// 상세 
	function fnModify(id) {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my120s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_MODIFY%>'; // 작업 타입

		f.brd_no.value = id;

		f.method = "post";
		f.submit();
	}
  
   </script>
</head>
<jsp:include page="/Sales/common/include/body_s.jsp"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<form name="form1">
	<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table3">
                      <tr>
                        <td height="30" colspan="6" align="right">
                          <table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table4">
                            <tr>
                              <td height="25">
                                 <select name="search_key"  style="font-size=9pt;color : #ffffff ;background-color:#797979">
                                      <option value ="BRD_SUBJECT" >제목</option>
                                      <option value ="BRD_CREATOR" >작성자</option>
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
                         <td width="50" align='center'><b><font color="#555555">번호</font></b></td>
                         <td width="485" align='center'><b><font color="#555555">제목</font></b></td>
                         <td width="60" align='center'><b><font color="#555555">첨부파일</font></b></td>
                         <td width="100" align='center'><b><font color="#555555">작성자</font></b></td>
                         <td width="80" align='center'><b><font color="#555555">작성일</font></b></td>
                         <td width="70" align='center'><b><font color="#555555">조회수</font></b></td>
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
                               <td colspan='6' align='center' height='800'><b>게시물이 없습니다.</b></td>
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
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
				 	
		<input type="hidden" name="brd_no" 	value="">
		          
		<input type="hidden" name="actId" 			value=""> 	<!-- 액션 ID -->
		<input type="hidden" name="process_flag" 	value=""> 	<!-- 작업 플래그 -->
   </form>
<jsp:include page="/Sales/common/include/body_e.jsp"/>
