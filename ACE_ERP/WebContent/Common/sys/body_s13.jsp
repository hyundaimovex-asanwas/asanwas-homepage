<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.*" %>

<%
	String dirPath = request.getContextPath();
	
	//���� tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //�޾ƿ� ���� �޴� ��! fnOnLoad() �Լ��� �Ķ���ͷ� �����Ͽ� �޴�����!
%>

<% //�α��� üũ : 2011-07-24 �ɵ��� ���� ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//������ �̵��� ����ID üũ(�̰� ������ ���� ���� ������?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//������ �̵��� ���Ǻ���("�α�") üũ
	String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ

//	out.println("ssID===="+ssID+ "<BR>");
//	out.println("portal=="+session.getId()+"<BR>");
//	out.println(gusrid+"<BR>");
//	out.println(gusrnm+"<BR>");
	
		
	// (ssID + ���������ǰ� + IP) ��
	if(!ssID.equals(session.getId()) || !gusrip.equals(request.getRemoteAddr()) || !gusrpos.equals("Tadaima") ){
	//���� �Բ� ���� ȭ������ 
		%>
		<script language="javascript">
			alert("�ð��� �����Ǿ� �ڵ� �α׾ƿ��Ǿ��ų�\n���� ������ �ƴմϴ�.\n\n���� �α��� ���ּ���.");
			top.location.href="<%=dirPath%>/newIndeX.jsp";
		</script>
		<%
//		response.sendRedirect(dirPath+"/newIndeX.jsp");
		return;
	}
	//�α��� üũ �� ///////////////////////////////////////////////////////////////////////////////////////
%>
	<form name="movForm" id="movForm" method="post">
		<input name="ssID" type="hidden" value="<%=session.getId()%>" />
	</form>


<script language="JavaScript">
	document.onkeydown = function() {	<%//�� �������� ���� ���� ��ũ��Ʈ%>
		if( event.keyCode ==119 ) { //F2=113, F8=119
			helpme();
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;
		}
	}

	function helpme(){	<%//���� ���� ���%>
		window.open("<%=dirPath%>/Helpshop/baseFrame.jsp?menu_idx=<%=tree_idx%>","Helpshop","width=900px, height=700px, resizable=yes,");
	}
	
	function moveMove(page,param){	<%//������ �̵� : self â%>
		document.movForm.action=page+ "?"+ param;
		document.movForm.submit();
	}
	function moveMoveN(page,param){	<%//������ �̵� : ��â%>
		document.movForm.target="_blank";
		document.movForm.action=page+ "?"+ param;
		document.movForm.submit();
	}

	
</script> 

<!-- BODY header begin-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(<%=tree_idx%>);">

<%
/*=============================================================================
			Status Bar Falsh
	�ֽ� : loadingBar
	������ �� �� : LowerFrame
=============================================================================*/
%>	
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Purch/common/include/loadingSales.jsp">
	</iframe>	

	<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>	
	





<!--||| HEADER START |||-->
<div id="haHeader">
	<div id="haHeaderTop">
	<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
	  <TR>
		<TD width="158px" ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:2px"><img src=<%=dirPath%>/images/Common/logo.gif border=0></TD>
		<TD width="150px" valign="bottom" style="padding-bottom:1px"><FONT COLOR=#696969 style="font-weight:bold;padding-left:12px"><font size="-1" face="����" id=loginNM><%=gusrnm%></font>(<font size="-1" face="����" id=loginID><%=gusrid%></font>)��</td>
		<TD ALIGN=LEFT VALIGN=BOTTOM >
			<jsp:include page="/Common/sys/body_s_topIcon.jsp"  flush="true"/>		</TD>
		<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:1px"><font style="padding-right:12px;cursor:hand;" onclick="helpme();">����(F8)</font></TD>
	  </TR>
	</TABLE>
	</div>
	<div id="haHeaderMenu">
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=CENTER VALIGN=BOTTOM style="padding-bottom:4px"><a href="#" onclick="moveMove('<%=dirPath%>/portal.jsp','');"><FONT COLOR=#FFFFFF style="font-weight:bold;">Home</font></a> <FONT COLOR=#FFFFFF style="font-weight:bold;">|</font> <a href="#" onclick="moveMove('<%=dirPath%>/Common/sys/logout.jsp','');"><FONT COLOR=#FFFFFF style="font-weight:bold;">Logout</font></a></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM   style="padding-bottom:5px"><FONT COLOR=#FFFFFF style="font-weight:bold;font-size:14px;padding-left:12px;" name=menu_title id=menu_title></font></TD>
					<TD ALIGN=right VALIGN=BOTTOM  style="padding-bottom:4px"><FONT COLOR=#FFFFFF style="padding-right:12px;" name=menu_full id=menu_full></font></TD>
				  </TR>
				</TABLE>

	</div>
</div>


<!--||| MAIN CONTENTS START |||-->
<div id="haSubBody">
	<!--||| basic page CONTENTS |||-->

		<TABLE border=0 cellspacing=0 cellpadding=0 height=100%>
		  <TR>
			<TD VALIGN=top BGCOLOR=#E9F8FE STYLE="border-right:1 solid #DFDFDF;">
				<!-- ����Ʈ �޴� �г� -->
				<DIV style='width:100%;height:23px;padding:4px' align=right>
					<img ID=leftMenuArrow src='<%=dirPath%>/images/Common/arrow_menuClose.gif' border=0 style='cursor:hand' onclick='togLeftMenu();'>
					<!-- open���ο� ���� �̹��� �ҽ�����...��Ű�� ������ ��.. -->
				</DIV>
				<DIV ID=leftMenuLayer style='width:157px;height:100%;padding-left:0px;padding-right:1px;display:;'>
				  <jsp:include page="/Common/sys/cm010i_13.jsp"  flush="true"/>				  
				</DIV>
				<!-- ����Ʈ �޴� �г� -->
			</TD>
			<TD WIDTH=100% STYLE="padding-left:12px;padding-top:10px;" VALIGN=top>
<!-- BODY header end-->