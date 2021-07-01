<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%  response.setContentType("text/html; charset=euc-kr"); %>
<%
/******************************************************************************
 * 시스템명      : 마이페이지
 * 프로그램ID 	 : my710i
 * J  S  P       : my710i
 * 서 블 릿      : My710DAO,My710DTO,My710Manager
 * 작 성 자      : 박경국, 심동현
 * 작 성 일      : 2010-05-20
 * 기능정의      : 공지사항 조회
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-03-14][심동현] 새로운 폼으로 수정
 * [2008-09-03][심동현] 검색창 열었음 : 멀티파트로 날리면 한글을 잘 받네요.. 흐미..
 * [2008-11-12][심동현] 검색부분 폼=멀티파트. 읽기로 가는 폼(신규)=일반.. 
 *						이렇게 해야 정상적으로 값을 받아가네... 후;; 쿨럭..
 * [2010-05-20][박경국] 현대아산 임직원+대리점 담당자가 같이 사용가능한 받은 쪽지함 신규 생성.
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
<%@ page import="sales.menu.my.My730Manager" %>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.org.util.StringUtil"%>
<%@ page import="sales.common.*"%>
	
<script language="javascript"> 
	function fnOnLoad(tree_idx){
		fnInit_tree(590);	//트리초기화 호출
	}
</script>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	//쿠키불러오기 시작
	String v_login_name ="";
	String v_login_id = "";
	Cookie cookies[] = request.getCookies();
     if(cookies != null) {
          for(int i=0; i<cookies.length; i++){
               if(cookies[i].getName().equals("vusrid") ) {
                    v_login_id = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
               }
               if(cookies[i].getName().equals("vusrnm") ) {
                    v_login_name = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
               }
          }
     } 
	//쿠키불러오기 끝


	SmartRequest sr3 = new SmartRequest(request);
	String key 			 = sr3.getString("search_key");
	String values 		 = sr3.getString("search_value");
	// 결국 한글을 받아오면서 깨지는 것이 문제입니다. ㅠ_ㅠ;; 움..
	// 멀티파트로 보내니 된다!
	String requestedPage = sr3.getString("requestedPage");
	String pageSize  	 = "10";  	//1페이지에 표시될 개수
	String where_sql3    = "";

	//조건절 만들기.
	if (values !=  null && !values.equals("")){	
    	where_sql3=" AND " + key + " like '%" + values + "%'";
	}
   
	ArrayList data3 = new ArrayList();	//게시물 리스트를 받아올 것 생성.
	int len3 = 0;
	String brd_gu = "01";	//보드 구분~!
	BaseDataClass bean3;

	
	ArrayList data_all = new ArrayList();	//게시물 전체 카운트를 받아올 것 생성.     
	
	//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
	sr3.setObject("where_sql",(Object)where_sql3);	//조건절 세팅
	sr3.setObject("brd_gu",(Object)brd_gu);			//보드 구분 세팅
	sr3.setObject("requestedPage",(Object)requestedPage);	//요청페이지 세팅
	sr3.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
	sr3.setObject("search_key",(Object)key);			//페이지 사이즈 세팅
	sr3.setObject("v_login_id",(Object)v_login_id);		//로긴 아이디 셋팅 
	sr3.setObject("v_login_name",(Object)v_login_name);		//로긴 이름 셋팅 
	
	My730Manager manager3 = new My730Manager();
	data3 		= manager3.list(sr3);		//화면에 표시될 리스트 불러오기.
	data_all 	= manager3.alllist(sr3);	//해당 조건의 전체 게시물 숫자 카운트해오기
	manager3.close();

	//************************************************************************************
	// 페이지 관련 변수 세팅
	int allPageCnt, totalRowCnt, position, allRecordCnt;
	
	bean3 = (BaseDataClass)data_all.get(0);
	totalRowCnt = Integer.parseInt(bean3.get("brd_no"));	// 전체 로우 갯수

	allPageCnt	= (totalRowCnt / Integer.parseInt(pageSize) ) + 1;	//총 페이지 갯수 

	position 	= HDUtil.nullCheckNum(sr3.getString("position")); //페이징 블럭에서의 현재 위치.

	// 현재 페이지 세팅 : 기본값
	if (requestedPage ==  null || requestedPage.equals("")){
		requestedPage="1"; 
	}  
	// 페이징 블럭에서의 현재 위치- 1페이지보다 작으면 기본 값 1페이지.
	if (position < 1 ){
		position = 1; 
	}  
%>

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

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<script language="javascript"> 	
   function view_send(brd_no,ref,ref_step){
		var readURL ="my710_read_pop.jsp?pageFrom=730&idx=400&brd_no="+brd_no+"&ref="+ref+"&ref_step="+ref_step;
	   	window.open(readURL,"memoRead_to","width=480,height=450,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
   }
	
	function view_send1(brd_no,ref,ref_step){
   	 var f = document.searchForm;
      f.action="my710_read.jsp?idx=400";
      f.brd_no.value = brd_no;
      f.ref.value = ref;
      f.ref_step.value = ref_step;
      f.method = "POST";
      f.target="";
      
      f.submit();
   }

   function write_ok(){
    var f = document.searchForm;
		f.action='my730_write.jsp?idx=404&work_flag=INSERT';
		f.target='';
		f.method = "POST";
		f.submit();
   }
   
   
   
   function sel_chk(){
    var f = document.searchForm;
      if(f.search_value.value==""){alert('검색어를 넣어 주세요'); f.search_value.focus();  return;}
      f.action='my730_list.jsp?idx=590';
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
      f.action='my730_list.jsp?idx=590';
      f.requestedPage.value= requestedPage;
      f.position.value= position;            
      f.taget='';
      f.method = "POST";
      f.submit();
   }
   
   	//전체 선택 스크립트 시작 ------------------------------------
	var varflag = "false";
	function fn_allcheck(my_chkbox) {
		if (varflag == "false") {
			for (i=0; i < my_chkbox.length; i++) {
					my_chkbox[i].checked = true;			
			}
			varflag = "true";
		}else {
			for (i=0; i < my_chkbox.length; i++) {
					my_chkbox[i].checked = false;			
			}
			varflag = "false";
		}
	}
	//전체 선택 스크립트 끝 ------------------------------------
	
	//선택 삭제 함수
	function fn_delete(){
		var brd_no_s = "";
		var varflag = "false";
		var my_chkbox = document.listForm.chkbox;
		for (i=0; i < my_chkbox.length; i++) {
			if (document.listForm.chkbox[i].checked) {
				varflag = "true";
				brd_no_s += document.listForm.chkbox[i].value+":";
			}
		}
		if (varflag == "false") {
			alert ("지울 쪽지를 하나 이상 선택해 주세요!");
			return false;
		}
		
		document.listForm.action="my710_exec.jsp?work_flag=MULTI_DELETE3&brd_no_s="+brd_no_s;
		document.listForm.submit();
	}
  
</script>


<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	
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
					<OPTION VALUE='BRD_CONTENTS' <%= key.equals("BRD_CONTENTS") ? "selected" : "" %>>내용</OPTION>
					<OPTION VALUE='BRD_RECIPIENT_NAME' <%= key.equals("BRD_RECIPIENT_NAME") ? "selected" : "" %>>수신인 이름</OPTION>
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
   <table border="0" cellpadding="0" cellspacing="0">
     <form name="listForm" method="post">
     <col width="30" align="center" ></col>
     <col width="20" align="center" ></col>
     <col width="1" valign="top"></col>
     <col width="110" align="center"></col>
     <col width="1" valign="top"></col>
     <col width="430" style="padding-left:10px"></col>
     <col width="1" valign="top"></col>
     <col width="120" align=center></col>

     <tr> 
       <td colspan="8" height="3" bgcolor="#DBDACB"></td>
     </tr>
     <tr height="25" bgcolor="#F5F5E9" align="center"> 
       <td><input type=checkbox name=allChk id=allChk onclick="fn_allcheck(this.form.chkbox);"></td>
       <td></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_name_to.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_content.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
       <td><img src="http://www.hdasan.com/img/common/bbs_date.gif"></td>
     </tr>
     
  <%if ( data3.size() == 0 ) { %>
  <tr><td colspan="8" height="1" bgcolor="#DBDACB"></td></tr>
  <tr height="30" bgcolor="#F5F5E9">
	<td colspan=8 align=center>보관 쪽지가 없습니다.</td>
  </tr>
  <%} else {
     	len3 = data3.size();
	   bean3 = null;

         for(int h = 0; h < len3 ; h++) {
       	bean3 = (BaseDataClass)data3.get(h);
     %>

     <tr> 
       <td colspan=8 height="1" bgcolor="#DBDACB"></td>
     </tr>
     <tr height="30" > 
		<td><input type=checkbox name="chkbox" value="<%=bean3.get("brd_no")%>"></td>
		<td valign=top style="padding-top:9px">
			<% if(Integer.parseInt(bean3.get("brd_viewcnt"))>0){ %>
				<img src="http://static.naver.com/pwe/note/ico_note_off.gif" border="0">
			<%}else{%>
		  		<img src="http://static.naver.com/pwe/note/ico_note_on.gif" border="0">
		  	<%}%>
		</td>
		<td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
		<td><%=bean3.get("brd_creator")%>(<%=bean3.get("brd_creator_name")%>)</td>
		<td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
		<td><a href="javascript:view_send('<%=bean3.get("brd_no")%>','<%=bean3.get("ref")%>','<%=bean3.get("ref_step")%>');">
       	<%=StringUtil.cut(StringUtil.strReplace(bean3.get("brd_contents"), "<br>", "") ,20)%></a></td>
	    <td><img src="http://www.hdasan.com/img/common/bbs_bar_top.gif"></td>
		<td><%=bean3.get("brd_cdate")%></td>

     </tr>
  <%  }
	}
  %>			  
  
     <tr> 
       <td colspan=8 height="1" bgcolor="#DBDACB"></td>
     </tr>
     <!-- Button-->
	<tr height=30>
		<td align="right" colspan=2>
			<a href="#" ><img src="http://www.hdasan.com/img/common/btn_delete.gif" border="0" onclick="javascript:fn_delete()"></a>  
		</td>
		<td align="right" colspan=6></td>	
	</tr>
	<!-- Button-->				
     <tr> 
       <td colspan=8 height="1" bgcolor="#DBDACB"></td>
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
</table>
		
			
                      

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

