<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 공지사항
 * 프로그램ID 	: CU010i
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-16
 * 기능정의		: 공지사항 (상세)
 * [수  정   일  자][수정자] 내용
 * [2008-01-03][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드

try {
   // ContextPath
   String dirPath = request.getContextPath(); //HDASan

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
String user_name		= "";
String virtual_name	= "";
String real_name		= "";
String regdate			= "";
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "04";

// DB연결 객체
TourGalleryBoard dao = new TourGalleryBoard();
CommonBoard commonDao = new CommonBoard();



// 검색 - 분류
String searchTypeCode =ParamUtil.getReqParameter(request.getParameter("searchTypeCode"));
// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword"));

// 검색 - 파라메터
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 전체 게시물 수
int allCount = dao.getFrontTotalCount(part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getFrontList(rowsPerPage, requestedPage, part, keyword );
//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;



String McNum = "5";
String sub = "4";
String pageNum = "4";
String subNum = "1";   
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
	<script language="javascript">
	<!--
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
								
		fnInit(); 

	}	
	
	function fnInit(){
	};
	
	function list(){
	}
	
	function edit(){
	}
	
	function reply(){
	}
	
	function fnDelete() {
	}	

	
	//-->
	</script>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		




아자아자화이팅~!

                                                                                                                                                        
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	