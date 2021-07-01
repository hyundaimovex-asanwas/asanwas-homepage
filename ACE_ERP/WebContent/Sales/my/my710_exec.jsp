<%
/*******************************************************************************
 *                      << ���α׷� DESCRIPTION >>
 *******************************************************************************
 * ���α׷� ��   : 
 * �ۼ�����      : 2006.05.29
 * �ۼ���        : ��ٷ�
 * ���α׷� ���� : �Խ��� ��� ó�� (Process)
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

<%

try {
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
   String brd_creator_name = sr.getString("brd_creator_name");

	String brd_no_s = sr.getString("brd_no_s");
	String[] brd_no_each;
	int i ;


	//������ �����ڵ�
	sr.setObject("brd_gu",(Object)brd_gu);
	
   String message = "";
   
   My710Manager manager = new My710Manager();
   if(work_flag.equalsIgnoreCase("INSERT")){
      manager.insert(sr);
   }else if(work_flag.equalsIgnoreCase("KEEP")){	//���������Կ��� ����
      manager.keep(sr);
   }else if(work_flag.equalsIgnoreCase("KEEP2")){	//���������Կ��� ����
      manager.keep2(sr);
   }else if(work_flag.equalsIgnoreCase("DELETE")){	//���� ������ ����
      manager.delete(sr);
   }else if(work_flag.equalsIgnoreCase("DELETE2")){	//���� ������ ����
      manager.delete2(sr);
   } else if(work_flag.equalsIgnoreCase("DELETE3")){	// ���������� ����
      manager.delete3(sr);
   }else if(work_flag.equalsIgnoreCase("MULTI_DELETE")){	//���� ������ ��Ƽ ����
   		brd_no_each = brd_no_s.split(":");
		for (i = 0 ; i < brd_no_each.length; i++) {	//��Ƽ 
			sr.setParameter("brd_no",brd_no_each[i]);
			manager.delete(sr);			
		};
   }else if(work_flag.equalsIgnoreCase("MULTI_DELETE2")){	//���� ������ ��Ƽ ����
		brd_no_each = brd_no_s.split(":");
			for (i = 0 ; i < brd_no_each.length; i++) {	//��Ƽ 
				sr.setParameter("brd_no",brd_no_each[i]);
				manager.delete2(sr);			
			};
   }else if(work_flag.equalsIgnoreCase("MULTI_DELETE3")){	//���������� ��Ƽ ����
		brd_no_each = brd_no_s.split(":");
			for (i = 0 ; i < brd_no_each.length; i++) {	//��Ƽ 
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
	</form>
	<script language="javascript">
		<%
		if(work_flag.equalsIgnoreCase("INSERT")){
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my710_write.jsp?idx=400";	// ���� ��������
			alert("������ ���������� ���½��ϴ�.");
			form.submit();
		<%
		}else if(work_flag.equalsIgnoreCase("REPLY")){
		%>
		opener.location.href="my710_reply.jsp?brd_creator="+<%=brd_creator%>+"&brd_creator_name="+<%=brd_creator_name%>;
		window.close();
		<%
		}else if(work_flag.equalsIgnoreCase("KEEP")){
		%>
			window.close();
			opener.location.href="my730_list.jsp";
		<%
		}else if(work_flag.equalsIgnoreCase("KEEP2")){
		%>
			window.close();
			opener.location.href="my730_list.jsp";
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
		}else if(work_flag.equalsIgnoreCase("MULTI_DELETE")){	//�ڱ�â��.
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my710_list.jsp?idx=398";	// ��� ��������
			form.submit();
		<%
		}else if(work_flag.equalsIgnoreCase("MULTI_DELETE2")){	//�ڱ�â��.
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my720_list.jsp?idx=404";	// ��� ��������
			form.submit();
			<%
		}else if(work_flag.equalsIgnoreCase("MULTI_DELETE3")){	//�ڱ�â��.
		%>
			form = document.boardForm;
			form.target = "";
			form.action = "my730_list.jsp?idx=404";	// ��� ��������
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