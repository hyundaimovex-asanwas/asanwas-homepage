<%--
  - �ۼ���: �ڻ��
  - ����: 2006.04.17
  - ���۱� ǥ��: IMJ Korea
  - ���� ������ : ������
  - ���� ������ : 2006.06.09
  - ����: ������ - ���� üũ ������
  - 2011.06.08 �ɵ��� �ҽ� ������ 
--%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%
	//�α���� ���庯��
	String session_id	  = "";
	String session_name   = "";
	String session_email  = "";
	String session_tel    = "";
	String session_isfrom = "";
	String session_client_sid="";
   	String session_level  = "";

	//ž�޴� �÷��� ����
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


	//ž�޴� �÷���
	if(session_id.equals("")||session_id==""||session_id==null){ //�α��� �ƴϸ�
		aaa = "off";
		bbb = "b";
	
		//out.println(ScriptUtil.returnURL("/index.jsp","�α��� �ð��� ����Ǿ����ϴ�.\n�ʱ�ȭ������ �̵��մϴ�."));
		//return;
	}else{
		aaa = "on";
	       
		if(session_isfrom.equals("a")){//�븮��
			bbb = "a";
		}else  if(session_isfrom.equals("c")){//���»�
			bbb = "c";
		}else{
			bbb = "b";
		};
		nCookie = 1;

	}
%>
 
<script language="javascript">
  //�븮��������
  function Top_agent01(){
         var val = "http://toursales.hdasan.com";
	window.open(val,"","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
  //���¾�ü����
  function Top_agent02(){
          var val = "http://toursales.hdasan.com";
	window.open(val,"","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
</script>
