<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명      	: 마이페이지
 * 프로그램ID 	: CU010i
 * J  S  P      : cu010i
 * 서 블 릿      		: My210DAO,My210DTO,My210Manager
 * 작 성 자      		: 남기표
 * 작 성 일      		: 2006-06-15
 * 기능정의      	: 공지사항 조회
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * @param page:현재 페이지, allPage:전체 페이지 숫자 , position:현재의 블록에서의 위치, 
 *        url: 링크 URL, width: 테이블 크기, parameter: 기타 필요한 파라미터들
 *        imagePath: 이미지위치 ,blockPerPage:  한 블럭 당  페이지 숫자 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
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

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	SmartRequest sr3 = new SmartRequest(request);

	String key 			= HDUtil.nullCheckStr(request.getParameter("search_key"));
	String values 		= HDUtil.nullCheckStr(request.getParameter("search_value"));
	String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
	String pageSize  	= "10";  	//1페이지에 표시될 개수
	String where_sql3     = "";

	//최초 tree_idx : body_s.jsp에 있는 내용인데..움;;
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //받아온 현재 메뉴 값! fnOnLoad() 함수에 파라미터로 전달하여 메뉴구성!

	
	//조건절 만들기.
	if (values !=  null && !values.equals("")){	
    	where_sql3=" AND " + key + " like '%" + values + "%'";
	}
   	where_sql3 = "";	// 임시 기본값 세팅
   
	ArrayList data3 = new ArrayList();
	int len3 = 0;
	String brd_gu = "01";	//보드 구분~!
	BaseDataClass bean3;
      
	sr3.setObject("where_sql",(Object)where_sql3);	//조건절 세팅
	sr3.setObject("brd_gu",(Object)brd_gu);			//보드 구분 세팅
	sr3.setObject("requestedPage",(Object)requestedPage);			//요청페이지 세팅
	sr3.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅

	My210Manager manager3 = new My210Manager();
	data3 = manager3.list(sr3);		//화면에 표시될 리스트 풀러오기.
	//해당 조건의 전체 게시물 숫자 카운트해오기
	manager3.close();


	//************************************************************************************
	// 페이지 관련 변수 세팅
	int allPageCnt, totalRowCnt, position, blockPerPage;
	
	position =HDUtil.nullCheckNum(request.getParameter("position")); //페이징 블럭에서의 현재 위치.

	// 현재 페이지 세팅 : 기본값
	if (requestedPage ==  null || requestedPage.equals("")){
		requestedPage="1"; 
	}  
	// 페이징 블럭에서의 현재 위치.
	if (position < 1 ){
		position = 1; 
	}  

	    
	totalRowCnt = data3.size();	// 전체 게시물 갯수
	allPageCnt =(int)Math.ceil(totalRowCnt / Integer.parseInt(pageSize) );	//총 페이지 갯수 
	

 	blockPerPage = 10;	//페이징 블럭에 표시되는 페이지숫자의 갯수
%>

totalRowCnt:<%=totalRowCnt%>;<br>
allPageCnt:<%=allPageCnt%>;<br>
position:<%=position%>;<br>
blockPerPage:<%=blockPerPage%>;<br>
requestedPage:<%=requestedPage%>;<br>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript"> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출


	}
	</script>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<script language="javascript"> 	
   function view_send(brd_no,ref,ref_step){
   	 var f = document.form1;
      f.action="my210v.jsp?idx=404";
      f.brd_no.value = brd_no;
      f.ref.value = ref;
      f.ref_step.value = ref_step;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }
   function sel_chk(){
    var f = document.form1;
      if(f.search_value.value==""){alert('검색어를 넣어 주세요'); f.search_value.focus();  return;}
      f.action='my210s.jsp?idx=404';
      f.taget='';
      f.method = "POST";
      f.submit();
   }
   function sel_chk_enter(){
   
      if(event.keyCode=="13"){
         sel_chk()
       }
   }
   function write_ok(){
    var f = document.form1;
       f.action='my210i.jsp?idx=404';
       f.target='';
             f.method = "POST";
       f.submit();
   }
  
</script>


<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	
<!-- Search-->
<table border="0" cellpadding="0" cellspacing="0" width="724">
<form name="form1">
           <input type="hidden" name="brd_gu" value="<%=brd_gu%>">
           <input type="hidden" name="brd_no" value="01">
           <input type="hidden" name="ref" value="">
           <input type="hidden" name="ref_step" value="">
<tr>
	<td width="70"><img src="http://www.hdasan.com/img/common/search_left.gif"></td>
	<td background="http://www.hdasan.com/img/common/search_bg.gif" align="right" style="padding-right:10">

		<table border="0" cellpadding="0" cellspacing="0" width="">
		<tr>
			<td width="92">
				 <SELECT name="searchkey" ID="Select02" STYLE="width:87px;height:15px;display:none;">
					<OPTION VALUE='title' <%//= searchkey.equals("title") ? "selected" : "" %>>제목</OPTION>
					<OPTION VALUE='content' <%//= searchkey.equals("content") ? "selected" : "" %>>내용</OPTION>
				</SELECT>
				<SCRIPT>
					Select_box("Select02","search");
				</SCRIPT>
			</td>
			<td width="145"><input type="text" name="searchvalue" style="width:140; height:18;" class="serach_input" value='<%//= searchvalue %>'></td>
			<td><a href="javascript:document.searchfrm.submit()"><img src="http://www.hdasan.com/img/common/btn_search.gif" border=0></a></td>
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
	<td colspan=9 align=center>등록된 글이 없습니다.</td>
  </tr>
  <%} else {
     	len3 = data3.size();
       bean3 = null;
       int tocnt = data3.size();

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
				<%=HDUtil.doPageCut( Integer.parseInt(requestedPage), 15 , position 
									, "my210s.jsp", "500", "idx="+ tree_idx
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
		<td align="right">
			<a href="javascript:write_ok();"><img src="<%=dirPath%>/Sales/images/b_write.gif" border="0" align="absmiddle"></a>  
		</td>
	</tr>
</table>
<!-- Button-->				
                      

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

