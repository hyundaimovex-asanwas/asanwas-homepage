<%
/*******************************************************************************
 *                      << 프로그램 DESCRIPTION >>
 *******************************************************************************
 * 프로그램 명   : 
 * 작성일자      : 2006.05.29
 * 작성자        : 김근래
 * 프로그램 개요 : 게시판 등록 처리 (Process)
 ******************************************************************************/
%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%  response.setContentType("text/html; charset=euc-kr"); %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="sales.org.common.log.LogUtil"%>
<%@ page import="sales.org.common.property.CommonProperty"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.org.common.request.FileStorage"%>
<%@ page import="sales.org.util.StringUtil"%>
<%@ page import="sales.org.util.CalendarUtil"%>
<%@ page import="sales.org.util.ClassUtil"%>
<%@ page import="sales.menu.my.*"%>
<%@ page import="sales.common.HDUtil"%>
<%
try {
   String brd_creator_name	=HDUtil.nullCheckStr(request.getParameter("brd_creator_name"));
   brd_creator_name = new String(brd_creator_name.getBytes("ISO8859-1"),"EUC-KR");	//이름 한글 파라미터 적기..
	//아래 SmartRequest로 받음..깨지네.ㅠ_ㅠ 웹쪽 소스 가져오다보니..킁;; 에구__);

   SmartRequest sr = new SmartRequest(request);
   
   String work_flag    = sr.getString("work_flag");
   String page_num     = sr.getString("page_num");
   String search_key  = sr.getString("search_key");
   String search_value  = sr.getString("search_value");
   String ltype    = sr.getString("scode");
   String m_id     = sr.getString("id");
   String menu_id  = sr.getString("menu");
   String brd_gu  = sr.getString("brd_gu");   
   String brd_contents = sr.getString("brd_contents");
   String brd_creator  = sr.getString("brd_creator");   

   
	String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)

	String brd_no_s = sr.getString("brd_no_s");
	String[] brd_no_each;
	int i ;


	//보드의 구분코드
	sr.setObject("brd_gu",(Object)brd_gu);
	
   String message = "";
   
   My710Manager manager = new My710Manager();
   if(work_flag.equalsIgnoreCase("INSERT")){
      manager.insert(sr);
   }else if(work_flag.equalsIgnoreCase("KEEP")){	//받은쪽지함에서 보관
      manager.keep(sr);
   }else if(work_flag.equalsIgnoreCase("KEEP2")){	//보낸쪽지함에서 보관
      manager.keep2(sr);
   }else if(work_flag.equalsIgnoreCase("DELETE")){	//받은 쪽지함 삭제
      manager.delete(sr);
   }else if(work_flag.equalsIgnoreCase("DELETE2")){	//보낸 쪽지함 삭제
      manager.delete2(sr);
   } else if(work_flag.equalsIgnoreCase("DELETE3")){	// 쪽지보관함 삭제
      manager.delete3(sr);
   }else if(work_flag.equalsIgnoreCase("MULTI_DELETE")){	//받은 쪽지함 멀티 삭제
   		brd_no_each = brd_no_s.split(":");
		for (i = 0 ; i < brd_no_each.length; i++) {	//멀티 
			sr.setParameter("brd_no",brd_no_each[i]);
			manager.delete(sr);			
		};
   }else if(work_flag.equalsIgnoreCase("MULTI_DELETE2")){	//보낸 쪽지함 멀티 삭제
		brd_no_each = brd_no_s.split(":");
			for (i = 0 ; i < brd_no_each.length; i++) {	//멀티 
				sr.setParameter("brd_no",brd_no_each[i]);
				manager.delete2(sr);			
			};
   }else if(work_flag.equalsIgnoreCase("MULTI_DELETE3")){	//쪽지보관함 멀티 삭제
		brd_no_each = brd_no_s.split(":");
			for (i = 0 ; i < brd_no_each.length; i++) {	//멀티 
				sr.setParameter("brd_no",brd_no_each[i]);
				manager.delete3(sr);			
			};
   }else if(work_flag.equalsIgnoreCase("REPLY")){
      manager.reply(sr);
   }

   manager.close();
%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<form name="boardForm" method="post">
		<input type="hidden" name="search_key" value="<%=search_key%>">
		<input type="hidden" name="search_value" value="<%=search_value%>">
		<input type="hidden" name="scode" value="<%=ltype%>">
		<input type="hidden" name="id" value="<%=m_id%>">
		<input type="hidden" name="menu" value="<%=menu_id%>">
		<input type="hidden" name="brd_gu" value="<%=brd_gu%>">
		<input type="hidden" name="brd_contents" values="<%=brd_contents%>">
	    <input name="ssID" type="hidden" value="<%=session.getId()%>" />	
	</form>
	<script language="javascript">
		<%
		if(work_flag.equalsIgnoreCase("INSERT")){
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my710_write.jsp?idx=947";	// 쓰기 페이지로
			alert("쪽지를 성공적으로 보냈습니다.");
			form.submit();
		<%
		}else if(work_flag.equalsIgnoreCase("REPLY")){
		%>
			opener.location.href="my710_reply.jsp?brd_creator=<%=brd_creator%>&brd_creator_name=<%=brd_creator_name%>&ssID=<%=ssID%>";
			window.close();
		<%
		}else if(work_flag.equalsIgnoreCase("KEEP")){
		%>
			window.close();
			opener.location.href="my730_list.jsp?ssID=<%=ssID%>";
		<%
		}else if(work_flag.equalsIgnoreCase("KEEP2")){
		%>
			window.close();
			opener.location.href="my730_list.jsp?ssID=<%=ssID%>";
		<%
		}else if(work_flag.equalsIgnoreCase("DELETE")){
		%>
			window.close();
			opener.location.reload();   
		<%
		}else if(work_flag.equalsIgnoreCase("DELETE2")){
		%>
			window.close();
			opener.location.reload();   
		<%
		}else if(work_flag.equalsIgnoreCase("DELETE3")){
		%>
			window.close();
			opener.location.reload();   
		<%
		}else if(work_flag.equalsIgnoreCase("MULTI_DELETE")){	//자기창임.
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my710_list.jsp?idx=398&ssID=<%=ssID%>";	// 목록 페이지로
			form.submit();
		<%
		}else if(work_flag.equalsIgnoreCase("MULTI_DELETE2")){	//자기창임.
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my720_list.jsp?idx=404&ssID=<%=ssID%>";	// 목록 페이지로
			form.submit();
			<%
		}else if(work_flag.equalsIgnoreCase("MULTI_DELETE3")){	//자기창임.
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my730_list.jsp?idx=404&ssID=<%=ssID%>";	// 목록 페이지로
			form.submit();
		<%
		}
		
		if(StringUtil.isNotNull(message)){
		%>
		   alert("<%=message%>");
		<%
		}
	%>
	
	<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

</script>