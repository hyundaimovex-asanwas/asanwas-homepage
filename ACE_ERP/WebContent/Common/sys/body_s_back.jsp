<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%
	String dirPath = request.getContextPath();
	
	//���� tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //�޾ƿ� ���� �޴� ��! fnOnLoad() �Լ��� �Ķ���ͷ� �����Ͽ� �޴�����!
%>

<!-- BODY header begin-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(<%=tree_idx%>);">

<TABLE width=100% height=100% border=0 cellspacing="0" cellpadding="0">
	<TR WIDTH="100%">
	  <TD WIDTH="100%" HEIGHT=80 VALIGN=top><!-- ž�޴� -->
		<TABLE CELLPADDING="0" CELLSPACING="0" border=0 width=100%>
		  <TR STYLE="height:42px;">
			<TD>
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:2px"><img src=<%=dirPath%>/images/Common/logo.gif border=0></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM   style="padding-bottom:1px"><FONT COLOR=#696969 style="font-weight:bold;padding-left:12px">��ä��(2070141)�ԡ�[�������� > �渮�� > ������]</font></TD>
					<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:4px"></TD>
				  </TR>
				</TABLE>
			</TD>
		  </TR>
		  <TR STYLE="height:35px;">
			<TD Background=<%=dirPath%>/images/Common/topMenu_back.gif>
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:4px"><FONT COLOR=#FFFFFF style="font-weight:bold;">Home | Logout</font></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM   style="padding-bottom:5px"><FONT COLOR=#FFFFFF style="font-weight:bold;font-size:14px;padding-left:12px;" name=menu_title id=menu_title></font></TD>
					<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:4px"><FONT COLOR=#FFFFFF style="padding-right:12px;" name=menu_full id=menu_full></font></TD>
				  </TR>
				</TABLE>
			</TD>
		  </TR>
		  <TR STYLE="height:3px;">
			<TD bgcolor=#FFD104></TD>
		  </TR>
		</TABLE>
	  </TD>
	</TR>
	<TR WIDTH="100%">
	  <TD WIDTH="100%" VALIGN=top>
		<TABLE border=0 cellspacing=0 cellpadding=0 height=100%>
		  <TR>
			<TD VALIGN=top BGCOLOR=#E9F8FE STYLE="border-right:1 solid #DFDFDF;">
				<!-- ����Ʈ �޴� �г� -->
				<DIV style='width:100%;height:23px;padding:4px' align=right>
					<img ID=leftMenuArrow src='<%=dirPath%>/images/Common/arrow_menuClose.gif' border=0 style='cursor:hand' onclick='togLeftMenu();'>
					<!-- open���ο� ���� �̹��� �ҽ�����...��Ű�� ������ ��.. -->
				</DIV>
				<DIV ID=leftMenuLayer style='width:157px;height:100%;padding-left:0px;padding-right:1px;display:;'>
				  <jsp:include page="/Common/sys/cm010i.jsp"  flush="true"/>				  
				</DIV>
				<!-- ����Ʈ �޴� �г� -->
			</TD>
			<TD WIDTH=100% STYLE="padding-left:12px;" VALIGN=top>
<!-- BODY header end-->