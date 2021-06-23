<%-- 
  - 작성자: 임형수
  - 일자: 2006.06.07
  - 수정자 : 이소연 
  - 일자 : 2006.08  
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>묻고답하기 리스트
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>


<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CrmBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%


//변수 선언
int board_seq			= 0;
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		= "";
String type_code  = "";
String type_name = "";
String use_yn			= "";
String user_id		= "";
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "14";
String open_yn = "0";
String reply_yn = "0";
String user_name ="";

String pageNum = "3";
String McNum = "6";
String sub = "3";

// DB연결 객체
CrmBoard dao = new CrmBoard();
CommonBoard commonDao = new CommonBoard();


// 검색 - 컬럼명
String part       = clearXSS(ParamUtil.getReqParameter(request.getParameter("part")),avatag );
//검색 - 내가쓴글 아이디
String search_id = clearXSS(ParamUtil.getReqParameter(request.getParameter("search_id")),avatag );
// 검색 - 검색어
String keyword    =  clearXSS(ParamUtil.getReqParameter(request.getParameter("keyword")),avatag );
// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;

//정렬순서
String orderBy    = ParamUtil.getReqParameter(request.getParameter("orderBy"));

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// 전체 게시물 수
int allCount = 0;
if(part.equals("3"))
    allCount = dao.getFrontTotalCount("5",search_id);
else
    allCount = dao.getFrontTotalCount(part,keyword);

// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;
// 게시물 목록
Tbrd_board_ma_bean record [] = null;


if(part.equals("3"))
    record = dao.getFrontList(rowsPerPage, requestedPage, "5", search_id, orderBy );
else
    record = dao.getFrontList(rowsPerPage, requestedPage, part, keyword, orderBy );

%>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<script language="javascript">

function openSch(){
   var form = document.frm;
   if (form.schVal.value == "키워드를 입력하세요"){
      form.schVal.value="";
   }
   form.submit();
}



function goSearch(){
	f = document.searchForm;
	if(f.part.value == ""){
	    alert ("검색 종류를 선택해주세요");
		f.part.focus();
		return;
	}
           if(f.part.value!="3" && f.keyword.value == "")
           {
                alert("검색어를 입력해 주세요");
                f.keyword.focus();
                return;
           }
	f.submit();
}



function getXMLHttpRequest() {
	if (window.ActiveXObject) {
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch(e) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch(e1) { return null; }
		}
	} else if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}
var httpRequest = null;

function sendRequest(url, params, callback, method) {
	httpRequest = getXMLHttpRequest();
	var httpMethod = method ? method : 'GET';
	if (httpMethod != 'GET' && httpMethod != 'POST') {
		httpMethod = 'GET';
	}
	var httpParams = (params == null || params == '') ? null : params;
	var httpUrl = url;
	if (httpMethod == 'GET' && httpParams != null) {
		httpUrl = httpUrl + "?" + httpParams;
	}
	httpRequest.open(httpMethod, httpUrl, true);
	httpRequest.setRequestHeader(
		'Content-Type', 'application/x-www-form-urlencoded');
	httpRequest.onreadystatechange = callback;
	httpRequest.send(httpMethod == 'POST' ? httpParams : null);
}


function isOwn(passConfirmNum){
	f = document.mainForm;
	var element = document.getElementById(passConfirmNum);

	if (element) {
		//alert(""+element.style.display);
		if(element.style.display == ''){
			element.style.display = 'none';
		}else{
            element.style.display = '';
		}
	}
}

function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}

var global_board_seq = "";

function goPassAsk(board_seq){
    var passAsk = document.getElementById('passAsk'+board_seq);
	global_board_seq =board_seq;
//	alert("global_board_seq==>"+global_board_seq);
//	alert("passAsk.value==>"+passAsk.value);
	if(passAsk.value.length>0){
//	   alert("sendRequest go-->"+"okPass.jsp?board_seq="+board_seq+"&password="+passAsk.value);
	   sendRequest("okPass.jsp?board_seq="+board_seq+"&password="+passAsk.value,null,okPass,"Get");
//	   alert("sendRequest  end ");
	} else {
		alert("비밀번호를 입력해주세요.");
		return;
	}
}


function okPass() {
	var resultValue = '0';
	f = document.mainForm;
	    //alert("okPass  go--> ");
		if (httpRequest.readyState == 4) {
			   if (httpRequest.status == 200) {
				    var xmlDoc = httpRequest.responseXML;
					var passList = xmlDoc.getElementsByTagName("passYn");
					for (var i = 0 ; i < passList.length ; i++) {
						var pass = passList.item(i);
						resultValue = pass.getElementsByTagName("result").item(0)
											 .firstChild.nodeValue;
						
						  //alert("resultValue="+resultValue);
						   if(resultValue=='yeSoK'){
							   f.action = "crm_view.jsp?board_seq="+global_board_seq+"<%=key_str%><%=page_str%>";
							    //alert("action="+f.action);
							   f.submit();
							}else{
							   alert("비밀번호가 일치하지 않습니다.");
								return;
							}
					}
				}
				//alert(message);
		}


}


function writedSeach(){
	f = document.searchForm;
	var keywordId = document.getElementById('keywordId');
	//alert("f.part.value="+f.part.value);
    if(f.part.value=="3"){
        f.keyword.value="<%=session_id%>";
		keywordId.innerHTML = "<input type=text style='width:140;' name=keyword  value='<%=session_id%>' readonly >";
	}else{
		var key = f.keyword.value;
        keywordId.innerHTML = "<input type=text style='width:140;' name=keyword  value="+key+" >";
	}
}

</script>

</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/center/tour_center_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/customer/tit_cus05.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">고객센터</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">신문고</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
         
<form method=post  name=mainForm action="crm_list.jsp">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus04.jpg"></td></tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
					  <table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="50"><col width="90"><col width="300"><col width="110"><col width="80"><col width="60">
						<tr><td height="2" colspan="6" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- 번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt11.gif"><!-- 구분 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt02.gif"><!-- 제목 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt04.gif"><!-- 작성자 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt08.gif"><!-- 등록일 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt05.gif"><!-- 조회수 --></td>
						</tr>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
            <% if(record.length <= 0){ %>							
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26" colspan="6">데이타가 존재하지 않습니다.</td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
            <%
            	}else{
            		//리스트 화면에 전시
            		for(int i=0;i<record.length; i++){ 
            			Tbrd_board_ma_bean tbean = record[i];
            			board_seq			= tbean.getBoard_seq();
            			read_num			= tbean.getRead_num(); 
            			title				= clearXSS(tbean.getTitle(),avatag ); 
            			use_yn				= tbean.getUse_yn(); 
						type_code			= tbean.getType_code(); 
						  if(type_code.equals("31"))
							type_name="관광객";
						  if(type_code.equals("32"))
							type_name="대리점";
						  if(type_code.equals("33"))
							type_name="협력사업자";
						  if(type_code.equals("34"))
							type_name="기　타";

            			
            			user_id				= tbean.getUser_id();
            			user_name           = tbean.getUser_name();
            			open_yn				= tbean.getOpen_yn();
            			reply_yn			= tbean.getReply_yn();
            
                        String open_yn_name = "비공개";
            			String reply_yn_name = "";
            			String reg_date_string = tbean.getReg_date_String();
            			String new_img	= BoardUtil.getNewArticle( tbean.getReg_date(),imageServer);
            			
            			if(open_yn.equals("1")){open_yn_name="공개";}
            			if(reply_yn.equals("1")){reply_yn_name="<img src='"+imageServer+"/tour_img/bu/ico_cus_replyok.gif' align='absmiddle'>";}  
                       
                         //관리자에 의해서 삭제 되었을때
                        if(use_yn.equals("0")){
            			    reg_date_string ="";
            			}
                        
            			//비공계 글일때
                        if(open_yn.equals("0")){
            			   //글쓴이가 로그인 한 사람이 아닐때
            			   if(user_id.equals(session_id)){
            			   }
            			} //if(open_yn.equals("1")) END
            			int listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));
             %>
             						
						<tr align="center">
							<td height="26"><%=listNum%></td>
							<td><%=type_name%></td>
							<!-- 관리자에 의해 삭제된 글일때  ==>삭제되었습니다 멘트 보임 -->
							<td align="left" class="tpad_3 lpad_10">
							<!--비밀글 아이콘-->
							<%if(open_yn.equals("0")){%>
								<img src="<%=imageServer%>/tour_img/btn/icon_key.gif">
                            <%}%>


							<%if(use_yn.equals("0")){%>
							     관리자에 의해서 삭제되었습니다.
							<!--비공계:O -->
							<%}else if(open_yn.equals("0") ){ %>
                            <!--회원이쓴글:O AND 로그인하지 않았을때:X-->
							     <%if(!user_id.equals("") && session_id.equals("")){%>
							         <a href="javascript:popLogin()">
							         <%=Util.getStringLimit(title,30)%>
							         </a>&nbsp;<%=reply_yn_name%>
							<!-- 회원이쓴글:X  OR  자기글:X   ==> 패스워드 확인후 연결   -->
							     <%}else if(user_id.equals("") || !user_id.equals(session_id) ){%>
							         <a href="javascript:isOwn('passConfirm<%=listNum%>')">
							         <%=Util.getStringLimit(title,30)%>
							         </a>&nbsp;<%=reply_yn_name%>
							         <div id=passConfirm<%=listNum%> style="display:none;">
							         비밀번호:<input type=password name="passAsk<%=board_seq%>" id="passAsk" value="">
							         <a href="javascript:goPassAsk('<%=board_seq%>')"><img src="<%=imageServer%>/tour_img/btn/btn_s_confirm.gif" align='absmiddle'></a> 
							         </div>
                             <!--회원이쓴글:O AND 자기글:O-->
                                    <%}else if(!user_id.equals("") && user_id.equals(session_id)){%>
                                     <a href="crm_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>" class="listtxt06"><%=Util.getStringLimit(title,30)%> &nbsp;</a>&nbsp;<%=reply_yn_name%>
									<%}%>
                            <%}else{%>
                                    <a href="crm_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>" class="listtxt06"><%=Util.getStringLimit(title,30)%></a>&nbsp;<%=reply_yn_name%>
                            <%}%>
							</td>
							<td>
                              <%if(use_yn.equals("0")){%>
								<%}else{%>
								    <!--id 있을경우-->
								      <%if(!user_id.equals("")){%>
									    <%=user_name%>(<%=user_id%>)
									<%}else{%>
										<%=user_name%>
									<%}%>
								<%}%>							
							</td>
							<td><%=reg_date_string%></td>
							<td><%if(use_yn.equals("0")){%><%}else{%><%=read_num%><%}%></td>
						</tr>
						<tr><td height="1" colspan="6" class="line_g2"></td></tr>
						<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
										
									}  //for END
								} //if(record.length <= 0) END
								
							%>
						<tr><td height="1" colspan="6" class="line_dg"></td></tr>
					  </table>
					</form>						
						<!-- list table / -->



						<!-- /paging -->
                        <table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td width="30%"></td>
							<td width="40%" align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "crm_list.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
			                </td>
			                <td width="30%" align="right">
						  <!--	<% if(!session_id.equals("")){ %>
			                 <a href="crm_edit.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_cus_recom.gif" class="btn"></a><!-- 글쓰기 
						    <% }else{ %>
                               <a href="javascript:;" onClick="javascript:popLogin()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_recom.gif" class="btn"></a>
                            <%}%>-->

			                </td>			                
						</tr>
						</table>
						<!-- paging/ -->	
						
						<!-- /search -->
<form  method=post  name="searchForm" action="crm_list.jsp">						
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr>
							<td align="center">
							<select name="part">
                                                                              <option <%if(part.equals("")){%>selected<%}%> value=''>선택</option>
                                                                              <option <%if(part.equals("1")){%>selected<%}%> value='1' >제목</option>
                                                                              <option <%if(part.equals("2")){%>selected<%}%> value='2' >이름</option>
                                                                              <option <%if(part.equals("5")){%>selected<%}%> value='5' >아이디</option>
                                                                              <option <%if(part.equals("6")){%>selected<%}%> value='6' >이메일</option><a href="crm_view.jsp">금강산관광</a>
							   <%if(!session_id.equals("")){%>
							   <option <%if(part.equals("3")){%>selected<%}%> value='3'>내가쓴글</option>
							    <%}%>
							</select>
							<input type="text" name="keyword" value="<%=keyword%>"  <%if(part.equals("3")){%>readonly<%}%>  style="width:140px;"><a href="javascript:goSearch()"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a><!--검색--></td>
							<input type="hidden" name="search_id" value="<%= session_id%>">
						</tr>
						</table>
						<!-- search/ -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td height="10"></td></tr>
						</table>
</form>									<table cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="<%=imageServer%>/tour_img/community/bottom_080307.gif"></td>
							</tr>
							<tr>
								<td height="32"></td>
							</tr>
						</table>		
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