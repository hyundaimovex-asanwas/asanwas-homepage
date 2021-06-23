<%--
  - �ۼ���: �ڻ��
  - ����: 2006.04.17
  - ���۱� ǥ��: IMJ Korea
  - ��~ ��d�� : ��~��
  - ��~ ��d�� : 2006.06.09
  - ����: ���� - ���� üũ ������
--%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%


	String session_id	  = "";
	String session_name   = "";
	String session_email  = "";
	String session_tel    = "";
	String session_isfrom = "";
	String session_client_sid="";
    
        String aaa = "";
        String bbb = "";
    
	//cookie read
	int nCookie = 0;
	Cookie[] cookies = request.getCookies();
	if ((cookies != null) && (cookies.length > 0)) 
	{
		for(int i=0; i < cookies.length; i++) 
		{
			Cookie thisCookie = cookies[i];
			if (thisCookie.getName().equals("id") ) 
			{
			    session_id      = thisCookie.getValue();  
			    nCookie = 1;
			};
			
			if (thisCookie.getName().equals("name") ) session_name  = URLDecoder.decode(thisCookie.getValue());
			if (thisCookie.getName().equals("email") ) session_email    = URLDecoder.decode(thisCookie.getValue());
			if (thisCookie.getName().equals("tel") ) session_tel        = URLDecoder.decode(thisCookie.getValue());
			if (thisCookie.getName().equals("isfrom") ) session_isfrom  = thisCookie.getValue();
			if (thisCookie.getName().equals("client_sid") ) session_client_sid  = URLDecoder.decode(thisCookie.getValue());
		}


	}else{
         nCookie = 0;
    }
    
    
    //cookie ��8��
	if ( nCookie != 1  ) 
	{
               aaa = "off";
               bbb = "b";
        
	}else{
	
	       aaa = "on";
	       
	       if(session_isfrom.equals("a")){
	             bbb = "a";
	        }else  if(session_isfrom.equals("c")){
	             bbb = "c";
	        }else{
                       bbb = "b";
                  }    
        
    } 

/* session OLD 
String session_id	= Util.getString((String)session.getAttribute("memberid"),"");
String session_name = Util.getString((String)session.getAttribute("membername"),"");
String session_level = Util.getString((String)session.getAttribute("memberlevel"),"");
String session_email = Util.getString((String)session.getAttribute("memberemail"),"");

//if(Session_id.equals("") && Session_auth.equals("")){
//	out.println(ScriptUtil.returnURL("admin.jsp","������ ���s�4ϴ�."));
//	return;
//}
*/

%>
 
<script language="javascript">
  //�븮a�?���
  function Top_agent01(){
         var val = "http://toursales.hdasan.com/services/index.jsp?ut=A&c_sid=<%=session_client_sid%>&c_id=<%=session_id%>";
	window.open(val,"","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
  //��¾�ü���
  function Top_agent02(){
          var val = "http://toursales.hdasan.com/services/index.jsp?ut=C&c_sid=<%=session_client_sid%>&c_id=<%=session_id%>";
	window.open(val,"","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
</script>
