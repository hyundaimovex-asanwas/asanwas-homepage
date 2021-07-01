<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.*" %>

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
    
    
    //cookie ¾øÀ¸¸é
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



%>
 