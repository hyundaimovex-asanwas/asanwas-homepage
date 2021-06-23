<%--
  - 작성자: 박상배
  - 일자: 2006.04.17
  - 저작권 표시: IMJ Korea
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.09
  - 설명: 관리자 - 세션 체크 페이지
  - 2011.06.08 심동현 소스 재정리 
--%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%
	//로긴상태 저장변수
	String session_id	  = "";
	String session_name   = "";
	String session_email  = "";
	String session_tel    = "";
	String session_isfrom = "";
	String session_client_sid="";
   	String session_level  = "";

	//탑메뉴 플래시 제어
	String aaa = "";
	String bbb = "";
    
	//cookie read
	int nCookie = 0;
	Cookie[] cookies = request.getCookies();
	
	session_id		= Util.getString((String)session.getAttribute("memberid"),"");
	session_name 	= Util.getString((String)session.getAttribute("membername"),"");
	session_email	= Util.getString((String)session.getAttribute("memberemail"),"");
	session_tel 	= Util.getString((String)session.getAttribute("membertel"),"");
	session_isfrom	= Util.getString((String)session.getAttribute("memberisfrom"),"");
	session_client_sid	= Util.getString((String)session.getAttribute("memberclient_sid"),"");
	session_level 	= Util.getString((String)session.getAttribute("memberlevel"),"");


	//탑메뉴 플래시
	if(session_id.equals("")||session_id==""||session_id==null){ //로긴이 아니면
		aaa = "off";
		bbb = "b";
	
		//out.println(ScriptUtil.returnURL("/index.jsp","로그인 시간이 만료되었습니다.\n초기화면으로 이동합니다."));
		//return;
	}else{
		aaa = "on";
	       
		if(session_isfrom.equals("a")){//대리점
			bbb = "a";
		}else  if(session_isfrom.equals("c")){//협력사
			bbb = "c";
		}else{
			bbb = "b";
		};
		nCookie = 1;

	}
%>
 
<script language="javascript">
  //대리점고객전용
  function Top_agent01(){
         var val = "http://toursales.hdasan.com";
	window.open(val,"","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
  //협력업체전용
  function Top_agent02(){
          var val = "http://toursales.hdasan.com";
	window.open(val,"","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
</script>
