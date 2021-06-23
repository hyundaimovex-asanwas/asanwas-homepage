<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	Plz_BoardBean pb = new Plz_BoardBean();
	pb.List_Gallery(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

<%
	//페이징 하기 위한 값을 셋팅한다.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getGroupsize());

	// 검색
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<script language="javascript">
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "키워드를 입력하세요"){
      form.schVal.value="";
   }
   form.submit();
}
</script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/tour/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6" align="right">
          <!--// IMJK START -->
          <TABLE cellspacing=0 cellpadding=0 width=650>
                <TR>
                  <TD>
          	      <TABLE cellspacing=0 cellpadding=0 width=650>
          	       <!-- loc -->
          	         <TR valign=top>
          		        <TD colspan=2 height=50 align=right style='padding-top: 10'>
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>커뮤니티</A> > 
          		        <span class=locon>회원갤러리(PLZ)</span>
          		        </TD>
          	          </TR>
          	       <!-- //loc -->
          	       </TABLE>
                  </TD>
               </TR>
          	<TR valign=top>
          		<!-- main -->
          
          		<TD width=650 valign=top>
								 <table width="100%" cellspacing="0" cellpadding="0" border="0" >
								 	<tr>
								 		<td>
											 <table width=100% border=0 cellspacing=0 cellpadding=0>
			          				<tr>
			          					<td colspan="3" class='title'><img src='../img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>회원갤러리(PLZ)</td>
			          				</tr>
			          				</table>
			          				<br>
			          				</tr>
											  <tr>
											    <% if ( list.size() == 0 ) { %>
											    	
															<td height="30" align="center" colspan="3">등록된 글이 없습니다.</td>
														  </tr>
													<% } else {
															int num = count - (int)helper.getPagesize()*(currentP-1);
											
															for(int i = 0; i < list.size(); i++) {
																HashMap hm = (HashMap)list.get(i);
													%>	  
											    
											    	<td width="255">
											      <!-- 01 -->
											
															      <table width="210" cellspacing="0" cellpadding="0" border="0">
																      <tr>
																      	<td>
																
																	        <table width="209" height="147" cellspacing="1" cellpadding="0" border="0" bgcolor="#C6C6C6">
																	        <tr>
																	        	<td bgcolor="#FFFFFF" align="center">
																	        		<a href=go4peace_gallery_view.jsp?idx=<%= hm.get("IDX") %>&page=<%=currentP%>&category=go4gallery&searchkey=<%=searchkey%>&searchvalue=<%=searchvalue%>>
																	        			<img src="/common/download.jsp?dir=go4peace&sysfilename=<%= hm.get("FILE_NAME0") %>" border="0" width="200" height="150"></a>
																	        		</td>
																	        </tr>
																	        </table>
																
																        </td>
																      </tr>
																      <tr>
																      	<td height="5"></td>
																      </tr>
																      <tr>
																      	<td height="25"><a href="go4peace_gallery_view.jsp?idx=<%= hm.get("IDX") %>&page=<%=currentP%>&category=go4gallery&searchkey=<%=searchkey%>&searchvalue=<%=searchvalue%>" class="gallerytxt"><%= (hm.get("TITLE") == null) ? "" : Utility.getStringcut( 28, Utility.ko((String)hm.get("TITLE")) ) %></a></td>
																      </tr>
																      <tr>
																      	<td>
																	        <table width="100%" cellspacing="0" cellpadding="0" border="0">
																	        <tr>
																	        	<td class="stxt">등록일 : <%= hm.get("REG_DATE").toString().substring(0, 10) %></td>
																	        	<td class="stxt">작성자 : <%= Utility.ko((String)hm.get("MEM_NAME")) %></td>
																	        </tr>
																	        <tr>
																	        	<td class="stxt">조회수 : <%= hm.get("CLICK_CNT") %></td>
																	        	<td class="stxt"></td>
																	        </tr>
																	        </table>        
																        </td>
																      </tr>
															      </table>
											
											      </td>
											      <%
											      if ((i+1)%3 == 0) {%>
											      </tr>
											      <tr>
											      	<table width="10" cellspacing="0" cellpadding="0" border="0">
														    <tr>
														      <td height="15"></td>
														    </tr>
														    <tr>
														    	<td background="../images/pline.gif" height="1"></td>
														    </tr>
														    <tr>
														      <td height="15"></td>
														    </tr>
														   </table>
											
															    <!--두번째 줄--->
															
															    <table width="100%" cellspacing="0" cellpadding="0" border="0">
															    <tr>
															  <% 	}
														      if (i+1 == list.size()) {
														      if(list.size() == 2 || list.size() == 5){%>
																													  	<td width="255"><table width="210"><tr><td></td></tr></table></td>
																													  	
																			  <%}
																		}}
																	}
																%>
															    	
															    </tr>
															    </table>
          					
          					<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr><td colspan="3" height="10"></td></tr>	
          						<tr>
                                     <td width=10%></td>
                                     <td align=center>
                                       <!-- --------------------------- 페이지 ----------------------- -->
																								<Table border="0" cellspacing="0" cellpadding="0" align="center">
																									<tr>
																										<td>
																										<%if(helper.getBeforegroup() > 0){%>
																											<a href="go4peace_gallery.jsp?category=go4gallery&page=<%=helper.getBeforegroup()%>"><img src="/asanway/img/imjk_img/btn_prev.gif" hspace="7"></a>
																										<% } else { %>
																											<img src="/asanway/img/imjk_img/btn_prev.gif" hspace="7">
																										<% } %>
																										</td>
																										<td>
																											<%
																											  for(int i = startP; i <= endP; i++){
																												if(i > totalP) break;
																													if(i == currentP){
																											%>
																												<b><font color="#CE261D"><%= i %></font></b>&nbsp;
																												<%  } else { %>
																												<a href="go4peace_gallery.jsp?category=go4gallery&page=<%= i %>"><%= i %></a>&nbsp;
																												<%  }
																											  } %>
																											<% if(totalP  == 0) { %>1<% } %>
																										</td>
																										<td>
																											<%if(helper.getAftergroup() > 0){%>
																												<a href="go4peace_gallery.jsp?category=go4gallery&page=<%=helper.getAftergroup()%>"><img src="/asanway/img/imjk_img/btn_next.gif" hspace="7"></a>
																											<% } else { %>
																												<img src="/asanway/img/imjk_img/btn_next.gif" hspace="7">
																											<% } %>
																										</td>
																									</tr>
																								</table>
																								<!-- --------------------------- 페이지 ----------------------- -->
                                     </td>
                                     <td width=10% align=right></td>
          						</tr>
                      <tr>
          						  <td colspan=3 align=right>
          						    </td>  
          						  </td>
          						</tr>
          					</table>
                               <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
          					<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr>
          						<td align=right>
          							<form name="search" method="get" action="go4peace_gallery.jsp">
          							<input type="hidden" name="category" value="gallery">
          							<table border=0 cellspacing=0 cellpadding=0>
          							
          							  <tr>
                                         <td >
                                           <select name="searchkey" style='width:80;'>
                                           <option value="TITLE" <% if( searchkey.equals("TITLE") ) { %>selected<% } %>>제목</option>
                                           <option value="CONTENT" <% if( searchkey.equals("CONTENT") ) { %>selected<% } %>>내용</option>
                                           </select>
                                         <input type=text style='width:200;' name="searchvalue">
                                         <img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value="검색" onclick="search.submit()" class="btn" onfocus="this.blur();"><img src=../img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                         <td>                                  
          							   </tr>
          							</table>
          							</form>
          						</td>
          					</tr>
          					<tr><td height=6></td></tr>
          					</table>                        
          				 </td>
          			   </tr>
          			</table>
          		 </TD>
          		<!-- //main -->
                </TR>
             </TABLE>    
          <!--// IMJK END -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>

</body>
</html>
