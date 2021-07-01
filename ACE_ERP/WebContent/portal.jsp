<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 로그인 포탈- 개발
 * 프로그램ID 	: index
 * J  S  P		: index.jsp
 * 작 성 자		: 심동현
 * 작 성 일		: 2010-09-08
 * 기능정의		: 트리메뉴 적용한 erp 공통포탈
 * [ 수정일자 ][수정자] 내용
 * [2010-09-07][심동현] 미결함 표시 
 * [2010-09-09][심동현] 메뉴트리 조회 프로시저 새버젼 : 전체 메뉴 권한 있는 것만~!
 * [2011-04-05][심동현] 포탈화면으로 여기는 트리 없음. 각 업무군 아이콘만 존재
 * [2011-05-27][심동현] XHTML 1.0 으로 표준작업을 반영할까 하고 있는데..움;;
 *						일단은 로그인부터 반영해놓고 레이아웃을 고치자..킁..
 * [2011-06-01][심동현] UI는 1024*768 최소 기준. 테스트해볼 것~
 * [2011-08-19][심동현] 메뉴 아이콘 순서 조정 및 기타 알림, 즐겨찾기도 고민..킁;;
 * [2011-10-14][심동현] 쪽지함 오픈, 결재할문서(common.ApManager) 추가
 * [2011-12-13][심동현] EHR 연계.. 아..
 * [2013-07-19][심동현] 종합관리 메뉴 추가 (로컬만)
 * [2013-10-23][심동현] 재구성-실행 이슈
 *						UI 개편? 메세지 바?  아이콘?, 버튼? 흐음..
 * [2013-11-13][심동현] 결재할 문서, 공지사항 등java 파일 수정		 
 * [2013-11-21][심동현] UI 개편, 소스 정리~  
 * [2015-01-07][심동현] 메인 배너 교체
 * [2020-02-18][이동훈] 불필요한 화면 정리 및 Push 메세지 보여주기
 *****************************************************************************/

///////////////////////////////////////////////////////////////////////////////
//Description 	:  JAVA Import 시작
%>

<%@ page import="sales.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="common.ApManager" %>
<%@ page import="common.VacManager" %>
<%@ page import="common.MsgManager" %>


<%	
		// ContextPath 변수 설정.
		String dirPath = request.getContextPath(); //HDASan
		// local ServerScript
		// 현대아산 직원, 대리점/협력업체 구분
		// Value = ERP, Value=Tour
		// ERP인 경우 = 

		//	서버시간 만들기
	   java.util.Calendar date = java.util.Calendar.getInstance();
	   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("ssMMmmyyyyHHdd");
	   String strD = m_today.format(date.getTime());
	
	try {
		


		SmartRequest sr = new SmartRequest(request);
		//로그인 정보에서 불러오는 값 /////011-06-14 심동현수정 ///////////////////////////////////////////////////////////////////////////////////////
		String gusrid	= (String)session.getAttribute("vusrid");
		String gusrnm	= (String)session.getAttribute("vusrnm");
		String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)
		String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
		String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
		//로그인 정보에서 불러오는 값 /////
		
		
		String key 			= HDUtil.nullCheckStr(request.getParameter("search_key"));
		String values 		= HDUtil.nullCheckStr(request.getParameter("search_value"));
		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "10";  	//1페이지에 표시될 개수
		String where_sql3     = "";
		String brd_gu = "01";	//보드 구분~!
		


		//공지사항 시작 //////////////////////////////////////////////////////////////////
		//공지사항 부르기 (대리점쪽?)
		SmartRequest sr3 = new SmartRequest(request);
		int	view_cnt=6;
	
		//조건절 만들기.
		if (values !=  null && !values.equals("")){	
	    	where_sql3=" AND " + key + " like '%" + values + "%'";
		}
	   	where_sql3 = "";	// 임시 기본값 세팅
	   
		ArrayList data3 = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len3 = 0;
		BaseDataClass bean3;
	
		ArrayList data_all = new ArrayList();	//게시물 전체 카운트를 받아올 것 생성.     
		
		sr3.setObject("where_sql",(Object)where_sql3);						//조건절 세팅
		sr3.setObject("brd_gu",(Object)brd_gu);									//보드 구분 세팅
		sr3.setObject("requestedPage",(Object)requestedPage);			//요청페이지 세팅
		sr3.setObject("pageSize",(Object)pageSize);								//페이지 사이즈 세팅
	
		My210Manager manager3 = new My210Manager();
		//data3 		= manager3.list(sr3);											//화면에 표시될 리스트 불러오기.
		manager3.close();
		//공지사항 끝 //////////////////////////////////////////////////////////////////





		//쪽지함 시작 //////////////////////////////////////////////////////////////////
		SmartRequest sr4= new SmartRequest(request);

		key 		     = sr4.getString("search_key");
		values 		 = sr4.getString("search_value");
		// 결국 한글을 받아오면서 깨지는 것이 문제입니다. ㅠ_ㅠ;; 움..
		// 멀티파트로 보내니 된다!
		//requestedPage = sr4.getString("requestedPage");
		requestedPage = "1";
		pageSize  	 = "5";  	//1페이지에 표시될 개수
		String where_sql4    = "";

		ArrayList data4 = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len4 = 0;
		brd_gu = "01";	//보드 구분~!
		BaseDataClass bean4;

		ArrayList data_all4 = new ArrayList();	//게시물 전체 카운트를 받아올 것 생성.     
		
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
		sr4.setObject("where_sql",(Object)where_sql3);	//조건절 세팅
		sr4.setObject("brd_gu",(Object)brd_gu);			//보드 구분 세팅
		sr4.setObject("requestedPage",(Object)requestedPage);	//요청페이지 세팅
		sr4.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
		sr4.setObject("search_key",(Object)key);			//페이지 사이즈 세팅
		sr4.setObject("v_login_id",(Object)gusrid);		//로긴 아이디 셋팅 
		sr4.setObject("v_login_name",(Object)gusrnm);		//로긴 이름 셋팅 
		
		My710Manager manager4 = new My710Manager();
		//data4 		= manager4.list(sr4);		//화면에 표시될 리스트 불러오기.
		//data_all4 	= manager4.alllist(sr4);	//해당 조건의 전체 게시물 숫자 카운트해오기
		manager4.close();
	
		//쪽지함 끝//////////////////////////////////////////////////////////////////////




		//받은 메세지 시작 //////////////////////////////////////////////////////////////////
		SmartRequest sr_msg= new SmartRequest(request);	

		ArrayList data_msg = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len_msg = 0;
		BaseDataClass bean_msg;
	
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
		sr_msg.setObject("v_login_id",(Object)gusrid);					//로긴 아이디 셋팅 
		
		MsgManager manager_msg = new MsgManager();
		data_msg		= manager_msg.list(sr_msg);						//화면에 표시될 리스트 불러오기.
		manager_msg.close();
		//받은 메세지 끝//////////////////////////////////////////////////////////////////////	





		//결재할문서 시작 //////////////////////////////////////////////////////////////////
		SmartRequest sr_ap= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "6";  	//1페이지에 표시될 개수
		ArrayList data_ap = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len_ap = 0;
		BaseDataClass bean_ap;
	
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
		sr_ap.setObject("requestedPage",(Object)requestedPage);	//요청페이지 세팅
		sr_ap.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
		sr_ap.setObject("v_login_id",(Object)gusrid);		//로긴 아이디 셋팅 
		
		ApManager manager_ap = new ApManager();
		data_ap		= manager_ap.list(sr_ap);		//화면에 표시될 리스트 불러오기.
		manager_ap.close();
		//결재할문서 끝//////////////////////////////////////////////////////////////////////



		//근태현황 시작 //////////////////////////////////////////////////////////////////
		SmartRequest sr_vac= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "6";  	//1페이지에 표시될 개수
		ArrayList data_vac = new ArrayList();	//게시물 리스트를 받아올 것 생성.
		int len_vac = 0;
		BaseDataClass bean_vac;
	
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
		sr_vac.setObject("requestedPage",(Object)requestedPage);	//요청페이지 세팅
		sr_vac.setObject("pageSize",(Object)pageSize);			//페이지 사이즈 세팅
		sr_vac.setObject("v_login_id",(Object)gusrid);		//로긴 아이디 셋팅 
		//sr_vac.setObject("v_login_deptcd",(Object)v_login_deptcd);		//로긴 아이디 셋팅 
		
		VacManager manager_vac = new VacManager();
		data_vac		= manager_vac.list(sr_vac);		//화면에 표시될 리스트 불러오기.
		manager_vac.close();
		//근태현황 끝//////////////////////////////////////////////////////////////////////
			


		//최초 tree_idx
		int tree_idx = 0;


%>


	
<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=1080" />
		<title>열려라 금강산(개발)　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<link rel="shortcut icon" href="<%=dirPath%>/Common/img/iconlogo.jpg" />
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/



	// (ssID + 유저포지션값 + IP) 비교
	//경고와 함께 메인 화면으로 → 로그아웃 페이지로 가서 세션을 다 날리고 재접근~!!!
	
	//System.out.println("session.getId().substring(0,40) -->" + session.getId().substring(0,40));
	//System.out.println("ssID.substring(0,40) -->" + ssID.substring(0,40));	


	if(!ssID.substring(0,40).equals(session.getId().substring(0,40)) || !gusrpos.equals("Tadaima") ){		//서버
	//if(!ssID.substring(0,40).equals(session.getId().substring(0,40)) || !gusrip.equals(request.getHeader("Proxy-Client-IP")) || !gusrpos.equals("Tadaima") ){		//서버2016.01.14
	//if(!ssID.equals(session.getId()) || !gusrip.equals(request.getRemoteAddr()) || !gusrpos.equals("Tadaima") ){		//로컬
		%>
		
		
		<script type="text/javascript">
			alert("시간이 오래되어 자동 로그아웃되었습니다.\n\n새로 로그인 해주세요.");
			top.location.href="<%=dirPath%>/Common/sys/logout.jsp";
		</script>


		<%
		return;
	}
	//로그인 체크 끝 ///////////////////////////////////////////////////////////////////////////////////////
%>



	<link href="<%=dirPath%>/Common/css30/basic.css" rel="stylesheet" type="text/css">
	<link href="<%=dirPath%>/Common/css30/layout.css" rel="stylesheet" type="text/css">	

	<script language="javascript" src="<%=dirPath%>/Common/js/portal.js"></script>

	<!-- 
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/PubFun.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/embedControl.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/menu.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_pop.js"></script>      
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common.js"></script>        
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/em.js"></script>  
	 -->


	<%//	개발자 스크립트	------------------------------------------------------------------		%>		
	<script type="text/javascript">

		var menuWin;

		var gTime;

		/* 페이지로딩 */
		function fnOnLoad(tree_idx){		

			//아산 EHR 미결함 체크//2011-12-13
			//GetHRCnt();
			//window.setInterval(ChkUniHRApproval, 5000 * 60);	

		}


		function chk_safety(param1){

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	        	+ "empno=" + param1;	

			ln_TRSetting(tr_safety,
	        	"<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>ChkSafety", 
	        	"JSP(O:DS_SAFETY=ds_safety)",
	       		param);

	        tr_post(tr_safety);	
			
		} 		 
	


		/* 공지사항 안씀_20200218 이동훈*/
		function view_send(brd_no){
	
			var f = document.form1;
			f.action="<%=dirPath%>/Sales/my/my210_read.jsp?idx=404";
			f.brd_no.value = brd_no;
			f.method = "POST";
			f.target="";
			
			f.submit();

		} 


		/* 받은 쪽지함 안씀_20200218 이동훈*/
	   function view_send4(brd_no,ref,ref_step){
			var readURL ="<%=dirPath%>/Config/my/my710_read_pop.jsp?pageFrom=710&idx=400&brd_no="+brd_no+"&ref="+ref+"&ref_step="+ref_step;
		   	window.open(readURL,"memoRead_from","width=480,height=450,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
	   }
		
	
		// EHR 연결////////////////////////////////////////////////////		
		/* [인사] 결재할 문서 팝 */
		function view_send_ehr(Menutype){	

			var readURL ="<%=dirPath%>/Ehr/hr/cod/codd010.jsp?idx=2694";	
			window.open(readURL,"memoRead_from","width=1100,height=800,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");		
      
		}
		

		function view_send_act(Menutype){	
			
			var readURL ="<%=dirPath%>/Ehr/hr/acq/acqa090.jsp";	
			window.open(readURL,"memoRead_from","width=1100,height=800,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");		   
			
		}


		function view_message(){	
			
			var readURL ="<%=dirPath%>/Ehr/hr/cod/codd050.jsp?idx=2694";	
			window.open(readURL,"memoRead_from","width=1100,height=800,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");	    
			
			document.movForm.target="_self";
			document.movForm.action=page+ ""+ param;
			document.movForm.submit();
			
			
		}





		/* [인사] 가기 - 메뉴 아이콘 */
		function move_ehr_icon(Menutype){	
			var sURL = "https://ehr.hdasan.com:449/hrms_sso.jsp";
			SSORedirection2.action=sURL;
			SSORedirection2.gw_menunum.value= Menutype;
			SSORedirection2.target="_blank";
			SSORedirection2.MENU_ID.value="erp";
			SSORedirection2.submit();              
		}



		function move_ehr_yac(Menutype){	
			//yaca020 = 입력, yaca050 = 결과 조회
			//var menuWin1 = "http://ace.hdasan.com/Ehr/hr/yac/yaca050_14.jsp?idx=6103";
			//window.open(menuWin1, menuWin,"width=1080,height=790,status=yes,menubar=no,toolbar=no,scrollbars=yes,titlebar=yes,resizable=yes");

			//alert("결과 조회 기간이 끝났습니다");

			/*var sURL = "http://ehr.hdasan.com/hrms_sso.jsp";
			SSORedirection2.action=sURL;
			SSORedirection2.gw_menunum.value= Menutype;
			SSORedirection2.target="_blank";
			SSORedirection2.MENU_ID.value="yac";
			SSORedirection2.submit();              */
		}


		// EHR 연결////////////////////////////////////////////////////	


		function move_gw(){//그룹웨어 공지사항 가기	2016-03-22

			var gwURL ="http://portal.hdasan.com/employee/hda/Lists/10002_7/DispForm.aspx?ID=633&IsDlg=2";
		   	window.open(gwURL,"gw_notice","width=1040,height=750,scrollbars=yes,toolbar=yes,location=yes,top=100,left=100,resizable=yes,status=yes");

		}
	

		document.onkeydown = function() {	//전 페이지에 걸쳐 공용 스크립트.

			if( event.keyCode ==119 ) { //F2=113, F8=119
				helpme();				//펑션 호출
	            event.keyCode = 0;
	            event.cancelBubble = true;
	            event.returnValue = false;
			}

		}



		function helpme(){	//도움말 오픈 펑션
			window.open("<%=dirPath%>/Helpshop/baseFrame.jsp?menu_idx=<%=tree_idx%>","Helpshop","width=900px, height=700px, resizable=yes,");
		}
		

		function moveMove(page,param){	//곧 삭제

			document.movForm.target="_self";
			document.movForm.action=page+ ""+ param;
			document.movForm.submit();

		}

		
		function moveMoveN(page,param){		<%//페이지 이동 : 새창%>
			
			gTime = new Date();
			menuWin = "mWin"+gTime.getTime();	//새창의 이름 지정. 시간 베이스로해서 계속 열린다.
			document.movForm.target= menuWin;						//타겟을 새창으로
			document.movForm.action=page+"?idx="+ param;				//뜰 페이지
			window.open("", menuWin,"width=1080,height=790,status=yes,menubar=no,toolbar=no,scrollbars=yes,titlebar=yes,resizable=yes");
			window.opener=this;
			document.movForm.submit();	
			
		}	


		/* 결재할 문서 */
		function view_send_ap(){

			moveMoveN("<%=dirPath%>/Config/ap/ap100i.jsp","951");

		}


		function fnSetHeader_tree(){		<%//메뉴트리-데이타셋 헤더 설정  %>

			if (ds_tree.countrow < 1){
				var s_temp1 = "TREE_LV:STRING,TREE_ID:STRING,TREE_IDX:INT,TREE_NM:STRING,TREE_TYPE:STRING,TREE_SEQ:INT,TREE_FILE:STRING";
				ds_tree.SetDataHeader(s_temp1);
			}	

		}
		


		function fnInit_tree(tree_idx, menuSeq){		<%//메뉴트리-조회 %>

			//즐겨찾기 00 //구 인사 01 // 회계 02	// 관광 04 // 쇼핑 05 // 물류 07	// 공사 10 // 구매 08	// 정보 09 // 환경설정 03 // 종합관리(금강산) 13 // 로력관리(개성) 14 // Ehr 15 // PMS 16 // 물류new 17
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	        	+ "tree_idx=" + tree_idx;	//선택된 메뉴 idx를 던진다.
			ln_TRSetting(tr_tree,
	        	"<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm011I_"+ menuSeq,	//여기를 바꾸면 
	        	"JSP(O:DEFAULT=ds_tree)",
	       		param);
	        tr_post(tr_tree);

		}	
		


		function setTree(menuSeq){
			if(menuSeq=="00"){
				mcMenuTit.innerHTML="즐 겨 찾 기";
			}else if(menuSeq=="20"){
				mcMenuTit.innerHTML="인 사";	//Ehr
			}else if(menuSeq=="02"){
				mcMenuTit.innerHTML="회 계";
			}else if(menuSeq=="11"){
				mcMenuTit.innerHTML="Action Plan";
			}else if(menuSeq=="04"){
				mcMenuTit.innerHTML="관 광";
			}else if(menuSeq=="05"){
				mcMenuTit.innerHTML="유 통";
			}else if(menuSeq=="07"){
				mcMenuTit.innerHTML="물 류";
			}else if(menuSeq=="08"){
				mcMenuTit.innerHTML="구 매";
			}else if(menuSeq=="09"){
				mcMenuTit.innerHTML="정 보 보 호";
			}else if(menuSeq=="10"){
				mcMenuTit.innerHTML="자 원";
			}else if(menuSeq=="03"){
				mcMenuTit.innerHTML="환 경 설 정";
			}else if(menuSeq=="13"){
				mcMenuTit.innerHTML="금 강 산";
			}else if(menuSeq=="14"){
				mcMenuTit.innerHTML="개 성";
			}else if(menuSeq=="16"){
				mcMenuTit.innerHTML="P M S";
			}else if(menuSeq=="17"){
				mcMenuTit.innerHTML="물 류";
			}
			
			//넘 무식하게 짰음 ㅡ.ㅡ. 
			/*document.all.mcAMenu00.style.backgroundPosition="6px 0px";
			document.all.mcAMenu15.style.backgroundPosition="6px 0px";
			//document.all.mcAMenu01.style.backgroundPosition="6px 0px";
			document.all.mcAMenu02.style.backgroundPosition="6px 0px";
			document.all.mcAMenu04.style.backgroundPosition="6px 0px";
			document.all.mcAMenu05.style.backgroundPosition="6px 0px";
			document.all.mcAMenu07.style.backgroundPosition="6px 0px";
			document.all.mcAMenu08.style.backgroundPosition="6px 0px";
			document.all.mcAMenu09.style.backgroundPosition="6px 0px";
			document.all.mcAMenu10.style.backgroundPosition="6px 0px";
			document.all.mcAMenu03.style.backgroundPosition="6px 0px";
			//document.all.mcAMenu13.style.backgroundPosition="6px 0px";
			//document.all.mcAMenu14.style.backgroundPosition="6px 0px";
			document.all.mcAMenu16.style.backgroundPosition="6px 0px";*/
			//버튼을 클릭모양으로 보여주기 
			//eval("document.all.mcAMenu"+menuSeq).style.backgroundPosition="6px -46px";	//오키! 성공! 자바스크립트에서 CSS를 제어할 수 있다. Jquery 같은 lib에 있을 듯
			//문제는 원래대로 돌아가질 않네.. ㅋ


			fnInit_tree(0,menuSeq);

		}
		
		function setCenterIco(param){		<%//센터 아이콘 세팅%>

			for(i=1; i<4; i++) {
				eval("document.all.area"+i).style.display="none";//레이어를 기본설정
				eval("document.images.ico"+i).src="images/icon/ci_"+i+".png";//아이콘을 기본설정
			}

			eval("document.all.area"+param).style.display="block";
			eval("document.images.ico"+param).src="images/icon/ci_"+param+"_o.png";//아이콘을 설정

		}
		
	</script>



	<%// 	가우스 이벤트 스크립트------------------------------------------------------------------		%>
    <script language=JavaScript  for="ds_tree" event="OnLoadCompleted(row)">

		if(row>0){

			tb_TreeView.focus();
			tb_TreeView.ExpandLevel = '1';
			tb_TreeView.index=4;
			//tb_TreeView.expand=row;
			//window.setTimeout(function(){tb_TreeView.index=1}, 2000);

        }

    </script>



	<script language="javascript" for="tb_TreeView" event="OnDblClick()" >

		//메뉴트리 더블클릭 이벤트
		var fileName = ds_tree.namevalue(ds_tree.rowposition,"TREE_FILE");
		var lev      = ds_tree.namevalue(ds_tree.rowposition,"TREE_LV");
		var idx      = ds_tree.namevalue(ds_tree.rowposition,"TREE_IDX");
		
		if(lev=='4'){	//4레벨 일때만 화면 이동.

			if(idx==287||idx==603||idx==376){
				//alert(idx+"요금결제!") 우회
				moveMoveN("http://ace.hdasan.com<%=dirPath%>/"+fileName+".jsp",idx);
			}else{
				moveMoveN("<%=dirPath%>/"+fileName+".jsp",idx);
			}

		}
	</script>



    <script language=JavaScript  for="ds_safety" event="OnLoadCompleted(row)">

    	var resYN =ds_safety.namevalue(ds_safety.rowposition,"RES");//결과값을 받아서 	

		if (resYN=="N"){//이수여부가 N이면

			//alert(document.all.top_notice);
			document.all.top_notice.style.display = "";//창을 띄워줌

		}

	</script>



	<!-- gauce ds -->
	<object id=ds_tree classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False"/>
	</object>



	<!-- gauce tr -->
	<object  id="tr_tree" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyName"    value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>



	<% //공지용 2016안전보건교육  %>
	<object id=ds_safety classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False"/>
	</object>


	<object  id="tr_safety" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyName"    value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>

</head>





<!-- BODY header begin-->
<body onload="fnOnLoad(0);">


<!-- form 시작 -->
<form name="FormPortal">


<div id="wrap">

    <!-- header -->
    <div id="header">

		<div id="haHeaderTop">
			<table border=0 cellspacing=0 cellpadding=0 width=100%>
			  <tr>
				<td width="158px" class="c b" style="padding-bottom:2px;cursor:pointer;"><img src="<%=dirPath%>/images/Common/logo.gif" onclick="moveMove('<%=dirPath%>/portal.jsp','');"/></td>
				<td width="150px" >&nbsp;</td>
				<td class="l b">&nbsp;</td>
				<td class="r b" style="padding-bottom:1px"></td>
			  </tr>
			</table>
		</div>

		<div id="haHeaderMenu">
			<table width=100%>
			  <tr>
				<td width="158" height="27" class="c b bold" style="color:#ffffff"><%=gusrnm%> (<%=gusrid%>)</td>
				<td class="r b bold"><a href="#" onclick="moveMove('<%=dirPath%>/Common/sys/logout.jsp','');"><font color=#ffffff>Logout</font></a>&nbsp;&nbsp;</td>

			  </tr>
			</table>
		</div>    

    </div>
	<!-- //header -->
    
    
    
    <!-- container -->
    <div id="container">
		<!--||| Menu Area  |||-->
		<div class="mcLeftCol" >
			<!--||| MAIN CONTENTS SHORTCUT 바로가기 |||-->
			<div class="mcShortcut" >
				<div class="mcSCicon"><a href="#" onclick="setTree('00')" class="mcLMenu00" id="mcAMenu00"><span>즐겨찾기</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('20')" class="mcLMenu15" id="mcAMenu15"><span>인사</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('02')" class="mcLMenu02" id="mcAMenu02"><span>회계</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('11')" class="mcLMenu11" id="mcAMenu11"><span>Action Plan</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('08')" class="mcLMenu08" id="mcAMenu08"><span>구매</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('04')" class="mcLMenu04" id="mcAMenu04"><span>관광</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('05')" class="mcLMenu05" id="mcAMenu05"><span>유통</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('17')" class="mcLMenu07" id="mcAMenu07"><span>물류</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('10')" class="mcLMenu10" id="mcAMenu10"><span>공사관리</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('16')" class="mcLMenu16" id="mcAMenu16"><span>PMS</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('09')" class="mcLMenu09" id="mcAMenu09"><span>정보보호</span></a></div>
				<div class="mcSCicon"><a href="#" onclick="setTree('03')" class="mcLMenu03" id="mcAMenu03"><span>환경설정</span></a></div>
				<!-- <div class="mcSCicon" align="center">
					<div class="mcSCiconT" ><a href="#" onclick="setTree('01')"><img src="images/icon/mi01g.png" class="mcImg" alt="(인사)" /></a></div>
				</div>
				<div class="mcSCicon" align="center">
					<div class="mcSCiconT" ><a href="#" onclick="setTree('13')"><img src="images/icon/mi13.png" class="mcImg" alt="종합관리" /></a></div>
				</div>
				<div class="mcSCicon" align="center">
					<div class="mcSCiconT" ><a href="#" onclick="setTree('14')"><img src="images/icon/mi14.png" class="mcImg" alt="로력관리" /></a></div>
				</div> -->
			</div>
			<!-- //메뉴아이콘 -->
		

			<div id="mcSpace" >&nbsp;</div>
	

			<div id="mcMenu" >	<!--||| MAIN Menu Tree  |||-->

				<div id="mcMenuTit" class="mcMenuTitle c bold" >즐 겨 찾 기</div>

				<!-- [2013-11-21][심동현] 메뉴 표시 UI 개편 디폴트는 즐겨찾기~! -->
				<object id=tb_TreeView classid=CLSID:4401B994-DD33-11D2-B539-006097ADB678 style="border:0 solid #708090; WIDTH: 100%; HEIGHT: 658px;"> 
					<param name=DataID					value="ds_tree"/>
					<param name=TextColumn			value="TREE_NM"/>
					<param name=TypeColumn			value="TREE_Type"/>
					<param name=LevelColumn			value="TREE_LV"/>
					<param name=BorderStyle  			value="0"/>
					<param name=HasLines      			value="false"/> 
					<param name="UseImage"			value="true"/>
					<param name="ItemEnable"			value="Enable"/>
					<param name="SingleExpand"		value="true"/>
				</object>
			</div><!-- menu tree end -->
			
		
		</div>
		<div id="mcSpace" >&nbsp;</div>
		<div id="mcCenterCol" >


			<!-- 메세지함 -->
			<div class="mcMemo">
			  <table width="428" border="0" cellspacing="0" cellpadding="1">
				<tr>
				  <td><b>＊받은 메세지</b>　　　　　　　　　　　　　　　　　　　　　　
					  <a href="#" onclick="view_message()" ><img src="<%=dirPath%>/Sales/images/more.gif" border="0"/></a></td>
				</tr>
				<tr>
				  <td align="center"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="428" height="2"/></td>
				</tr>
				<tr>
				  <td valign="top" height="95">
					<table width="418" border="0" cellspacing="0" cellpadding="1" align="center">
			            <% //받은 메세지함
			               if(data_msg == null || data_msg.size() < 1 ) {
			            %>
						<tr>
							<td height="90" align="center" valign="middle" colspan="4">해당 자료가 존재하지 않습니다.</td>
						</tr>	
								                        
			            <%
			            	}else {
			            		
			                  len_msg = data_msg.size();
			                  
			                  bean_msg = null;
			                  
								for(int h=0; h<len_msg; h++) {
									
									bean_msg = (BaseDataClass)data_msg.get(h);
									

				            %>
							<tr height=19>
								<td align="center"><b>미확인 메세지 <%=bean_msg.get("cnt")%>건이 존재합니다.</b></td>
				 			</tr>
						   <%
				               		}
				           		}
						   %>							
					</table>
					
				  </td>
				</tr>
			  </table>

			</div>	
			<!-- //메세지함 -->


			<!-- 근태현황 -->
			<div class="mcVac">
			  <table width="428" border="0" cellspacing="0" cellpadding="1">
				<tr>
				  <td><b>＊팀 근태 현황</b></td>
				</tr>
				<tr>
				  <td><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="428" height="2"></td>
				</tr>
				<tr>
				  <td valign="top" height="470">
					<table width="428" border="0" cellspacing="0" cellpadding="1">
		            <% //팀 근태 현황 : 20120201
		               if(data_vac == null || data_vac.size() < 1 ) {
		            %>
					<tr>
						<td height="60" align="center" valign="middle" colspan="4">해당 자료가 존재하지 않습니다.</td>
					</tr>			                        
		            <%
		            	}else {
		                  len_vac = data_vac.size();
		                  bean_vac = null;
		
							for(int h=0; h<len_vac; h++) {
		                     	bean_vac = (BaseDataClass)data_vac.get(h);
								//bean_vac.get("eno_no") 이건 사번
								String v_day1="";	
								String v_deptnm="";
								v_day1=bean_vac.get("day"); // 이건 근태일자
								v_deptnm=bean_vac.get("dpt_nm");
		            %>
					<tr height=19>
						<td width="60" align="center"><%=bean_vac.get("day")%> (<%=bean_vac.get("dy")%>)</td>
						<td width="90" align="center"><%=bean_vac.get("job_nm")%></td>
						<td width="80" align="center"><%=bean_vac.get("eno_nm")%></td>
						<td width="80" align="center"><b><%=bean_vac.get("vac")%></b></td>
		 			</tr>
				   <%
		               		}
		           		}
				   %>
					</table>
				   </td>
				</tr>
			  </table>
			</div>	
			<!-- //근태현황 -->

		</div>


		<div id="mcSpace" >&nbsp;</div>


		<div id="mcRightCol" >
			<div class="mcProfile"><!-- 로긴 프로필 -->
				<span style="padding-bottom:1px;COLOR:#696969;font-weight:bold;padding-left:6px">My Area</span>
			</div>	<!-- //로긴 프로필 -->

<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->
<!--                                                             2019.03.29 Action Plan 확인할 문서 추가함                                                                    -->
<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->
			<div class="mcApproval"><!-- 확인할 문서 -->
			  <table width="198" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="198"><b>＊확인할 문서</b></td>
				</tr>
				<tr>
				  <td class="c"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="178" height="2"></td>
				</tr>
				<tr>
				  <td valign="top" height="50">
					<table border="0" align="center">
			            <% //＊EHR 확인함용 폼	%>
						<form name="SSORedirection" method="post">
							<input type="hidden" name="gw_menunum"/>
							<input type="hidden" name="SSO_FLAG" value="gw"/>
							<input type="hidden" name="MENU_ID" value="etcb010"/>
							<input type="hidden" name="ENO_NO" value="hda<%=gusrid%>" />
							<input type="hidden" name="SERVER_TIME" value="<%=strD%>" />
						</form>

			            <% //＊확인함
			               if(data_ap == null || data_ap.size() < 1 ) {
			            %>
						<tr>
							<td height="60" align="center" valign="middle" colspan="4">해당 자료가 존재하지 않습니다.</td>
						</tr>			                        
			            <%
			            	}else {
			                  len_ap = data_ap.size();
			                  bean_ap = null;
								for(int h=0; h<len_ap; h++) {
			                     	bean_ap = (BaseDataClass)data_ap.get(h);

			            			if("Action PLAN".equals(bean_ap.get("detail_nm")) ){%>
			            			
									<tr>
										<td width="15" height="19" class="c t"><img src="<%=dirPath%>/Sales/images/dot.gif"  style="margin-top:6px;" /></td>
										<td width="120" class="c" onclick="view_send_act('A')" style="cursor:pointer;"><%=bean_ap.get("detail_nm")%></td>
										<td width="30" class="c" onclick="view_send_act('A')" style="cursor:pointer;">
											<%if(!bean_ap.get("cnt").equals("0") ){%>
												<font color="EE6A00"><b><%=bean_ap.get("cnt")%></b></font>
											<%}else{%><%=bean_ap.get("cnt")%>
											<%}%>
										</td>
									</tr>	

			            			<%}
			               		}
			           		}
					   %>						
					   </table>	
				  </td>
				</tr>
			  </table>
			</div>	<!-- //확인할 문서 -->
<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->
<!--                                                             2019.03.29 Action Plan 확인할 문서 추가함                                                                    -->
<!-- **********************************************************************************************  -->
<!-- **********************************************************************************************  -->

			<!-- 결재할 문서 -->
			<div class="mcApproval">
			  <table width="198" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="198"><b>＊결재할 문서</b></td>
				</tr>
				<tr>
				  <td class="c"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="178" height="2"></td>
				</tr>
				<tr>
				  <td valign="top" height="100">
					<table border="0" align="center">
			            <% //＊EHR 결재함용 폼	%>
						<form name="SSORedirection" method="post">
							<input type="hidden" name="gw_menunum"/>
							<input type="hidden" name="SSO_FLAG" value="gw"/>
							<input type="hidden" name="MENU_ID" value="etcb010"/>
							<input type="hidden" name="ENO_NO" value="hda<%=gusrid%>" />
							<input type="hidden" name="SERVER_TIME" value="<%=strD%>" />
						</form>

			            <% //＊결재함
			               if(data_ap == null || data_ap.size() < 1 ) {
			            %>
						<tr>
							<td height="60" align="center" valign="middle" colspan="4">해당 자료가 존재하지 않습니다.</td>
						</tr>			                        
			            <%
			            	}else {
			                  len_ap = data_ap.size();
			                  bean_ap = null;
								for(int h=0; h<len_ap; h++) {
			                     	bean_ap = (BaseDataClass)data_ap.get(h);

			            			if("인사".equals(bean_ap.get("detail_nm")) ){%>
						<tr>
							<td width="15" height="19" class="c t"><img src="<%=dirPath%>/Sales/images/dot.gif"  style="margin-top:6px;" /></td>
							<td width="120" class="c" onclick="view_send_ehr('1')" style="cursor:pointer;"><%=bean_ap.get("detail_nm")%></td>
							<td width="30" class="c" onclick="view_send_ehr('1')" style="cursor:pointer;">
								<%if(!bean_ap.get("cnt").equals("0") ){%>
									<font color="EE6A00"><b><%=bean_ap.get("cnt")%></b></font>
								<%}else{%><%=bean_ap.get("cnt")%>
								<%}%>
								
							</td>
						</tr>

			            	<%	}else if("Action PLAN".equals(bean_ap.get("detail_nm")) ){%>

						<tr>
							<td></td>
						</tr>
	
			            			<%}else{%>
						<tr>
							<td width="15" height="19" class="c t"><img src="<%=dirPath%>/Sales/images/dot.gif"  style="margin-top:6px;" /></td>
							<td width="120" class="c" onclick="view_send_ap()" style="cursor:pointer;"><%=bean_ap.get("detail_nm")%></td>
							<td width="30" class="c" onclick="view_send_ap()" style="cursor:pointer;">
								<%if(!bean_ap.get("cnt").equals("0") ){%>
									<font color="EE6A00"><b><%=bean_ap.get("cnt")%></b></font>
								<%}else{%><%=bean_ap.get("cnt")%>
								<%}%>
							</td>
						</tr>
			            			<%}
			               		}
			           		}
					   %>	
					 </table>	
				  </td>
				</tr>
			  </table>
			</div>	
			<!-- //결재할 문서 -->


			<div class="mcSpaceH"></div>	
			<!-- //여백 -->
			

			<!-- //바로가기 -->
			<div class="mcLinks">
			  <table width="198" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="198"><b>＊바로가기</b></td>
				</tr>
				<tr>
				  <td class="c"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="178" height="2"></td>
				</tr>
				<tr>
				  <td valign="top">
					<ul>
						<li>&nbsp;&nbsp;&nbsp;▶ <a href="http://www.hdasan.com" target="_blank">회사 홈</a></li>
						<li>&nbsp;&nbsp;&nbsp;▶ <a href="http://www.mtkumgang.com" target="_blank">금강산관광</a></li>
						<li>&nbsp;&nbsp;&nbsp;▶ <a href="http://www.ikaesong.com" target="_blank">개성관광</a></li>
						<li>&nbsp;&nbsp;&nbsp;▶ <a href="http://www.hdasantour.com" target="_blank">투어센터</a></li>
						<li>&nbsp;&nbsp;&nbsp;▶ <a href="http://portal.hdasan.com" target="_blank">그룹웨어</a></li>
						<li>&nbsp;&nbsp;&nbsp;▶ <a href="#" onclick="moveMoveN('<%=dirPath%>/Config/my/sq100s.jsp','960');">개인정보보호 따라하기 강좌</a></li>
					</ul>
				  </td>
				</tr>
			  </table>			
			</div>	
			<!-- //바로가기 -->		
			

			<div class="mcSpaceH"></div>	<!-- //여백 -->


			<!-- //Responsibility & Matrix -->
			<div class="mcRAM">
				<table style="width:198px;">
				  <tr>
				  	<td width="54px"><img src="<%=dirPath%>/images/it_team/uni200261.jpg" height="60px" alt="정영식" title="정영식" /></td>
				  	<td style="line-height:1.3;">정영식 차장 (<b>3717</b>)</br>
				  		　IT기획, 계약 관리, </br>
				  		　회계, 영업, 유통, </br>
				  		　매출관리(POS), 분양
				  		</td>
				  </tr>
				</table>	<!-- //역할과 책임 -->
			</div>	<!-- //Responsibility & Matrix -->

			<div class="mcSpaceH"></div>	<!-- //여백 -->

			<div class="mcRAM">
				<table style="width:198px;">
				  <tr>
				  	<td width="54px"><img src="<%=dirPath%>/images/it_team/uni200124.jpg" height="60px" alt="이동훈" title="이동훈" /></td>
				  	<td style="line-height:1.3;">이동훈 과장 (<b>3753</b>)</br>
				  		　건설, 인사, MICE,</br>
				  		　개성사업소 지원, </br>
				  		　프로젝트 관리자 </td>
				  </tr>
				</table>
			</div>	<!-- //Responsibility & Matrix -->

			<div class="mcSpaceH"></div>	<!-- //여백 -->

			<div class="mcRAM">
				<table style="width:198px;">
				  <tr>
				  	<td width="54px"><img src="<%=dirPath%>/images/it_team/uni200440.jpg" height="60px" alt="문지예" title="문지예" /></td>
				  	<td style="line-height:1.3;">문지예 대리 (<b>3809</b>)</br>
				  		　관광, 웹사이트,</br>
				  		　정보보호 담당자,</br>
				  		　H/W + S/W 관리 </td>
				  </tr>
				</table>	<!-- //역할과 책임 -->
			</div>	<!-- //Responsibility & Matrix -->

		</div>
    
    </div><!-- //container -->
    
    <!-- footer  -->
    <div id="footer" onclick="setSet()">    </div><!-- //footer  -->
   
</div><!-- //warp	-->


</form>
<!-- form 끝 -->



<!-- 기타 html요소들 -->	
<% /* 메뉴 이동시 세션을 가져가는 폼  */ %>
<form name="movForm" id="movForm" method="post">
	<input name="ssID" type="hidden" value="<%=session.getId()%>"/>
</form>


<% /* EHR로 가져가는 폼  */ %>
<form name="SSORedirection2" method="post">
	<input type="hidden" name="gw_menunum"/>
	<input type="hidden" name="SSO_FLAG" value="gw"/>
	<input type="hidden" name="MENU_ID" value="erp"/>
	<input type="hidden" name="ENO_NO" value="hda<%=gusrid%>"/>
</form>	


<%//2016안전교육용 아이프레임.. %>
<iframe id="top_notice" 
		name="top_notice" 
		style="width:100%;height:810px;display:none;top:90px; position:absolute;z-index:90;" 
		Frameborder="0" src="<%=dirPath%>/Common/notice/1610_safety/1610_safety_01.jsp">
</iframe>	


<script language=javascript>
	fnSetHeader_tree();// 최초 1회 헤더설정
	setTree('00');//fnInit_tree(0,'10');	// 화면 표시 후 트리 부르기
	setCenterIco('1');
	chk_safety("<%=gusrid%>");//2016안전교육용
</script>






<!-- //기타 html요소들 -->
</body>
</html>


<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>



