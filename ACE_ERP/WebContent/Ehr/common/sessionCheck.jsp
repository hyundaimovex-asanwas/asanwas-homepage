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
  if (ls_UserId == "999999") {	   //�׳� ������
%>

    <!-- ���� üũ�� ���� Expire�� ��� �α��� ȭ������ �̵� -->
    <script LANGUAGE="JavaScript">
        
        //�˾������̸� ��ź��.
        if(window.opener == undefined){
        
	        //Message ó��
			alert("�������� ������� �����̰ų�, �α������� �ʰ� ���ΰ� ������ �õ��ϼ̽��ϴ�! \n\n�α��� �� �ٽ� �۾��ϼ���!");
	
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
