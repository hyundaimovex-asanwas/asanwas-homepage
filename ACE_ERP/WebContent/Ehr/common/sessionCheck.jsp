<%@ page pageEncoding="euc-kr"%>
<%@ page import="com.shift.gef.support.collection.CBox,com.shift.gef.support.collection.CollectionUtility,com.shift.gef.support.utility.SessionUtil,com.shift.gef.configuration.Configuration" %>
<%
  CBox box = CollectionUtility.getGauceDataBox(request);
  box  = SessionUtil.getSession(request, box);

  //String hnwcodebase = "/cabfiles/hnwactiv_5_0_0_10.cab#version=5,0,0,10";
  String hnwcodebase = "/cabfiles/hnwactiv_7_1_0_18.cab#version=7,1,0,18";  
  String LocationDNS = Configuration.getInstance().get("framework.print.ezgen.locationDNS");
  String ls_UserId = box.get("SESSION_ENONO");

  //if ((ls_UserId == null) || (ls_UserId == "")) {
  if (ls_UserId == "999999") {	   //그냥 해주자
%>

    <!-- 세션 체크후 세션 Expire된 경우 로그인 화면으로 이동 -->
    <script LANGUAGE="JavaScript">
        
        //팝업상태이면 안탄다.
        if(window.opener == undefined){
        
	        //Message 처리
			alert("오랫동안 사용하지 않으셨거나, 로그인하지 않고 비인가 접속을 시도하셨습니다! \n\n로그인 후 다시 작업하세요!");
	
			try{
				var frame = window.external.GetFrame(window);
				frame.outerWindow.do_go();
	
			} catch (e) {
				window.close();
				parent.document.location= '/index.jsp';
	
			}
			
		}

    </script>

<%
	}
%>
