<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="pms.common.HDConstant"%>


<%
	String dirPath = request.getContextPath();
	
	//���� tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //�޾ƿ� ���� �޴� ��! fnOnLoad() �Լ��� �Ķ���ͷ� �����Ͽ� �޴�����!

    //�α��� üũ : 2013-12-04 �ɵ��� ���� ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//������ �̵��� ����ID üũ(�̰� ������ ���� ���� ������?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//������ �̵��� ���Ǻ���("�α�") üũ
	String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ

	// (ssID + ���������ǰ� + IP) ��
	//if(!ssID.equals(session.getId()) || !gusrip.equals(request.getRemoteAddr()) || !gusrpos.equals("Tadaima") ){
	//���� �Բ� ���� ȭ������ 
		%>
		<script language="javascript">
		//alert("�ð��� �����Ǿ� �ڵ� �α׾ƿ��Ǿ��ų�\n���� ������ �ƴմϴ�.\n\n���� �α��� ���ּ���.");

		//window.close();	//â���� ����(2013-12-04)
		</script>
		<%
//		response.sendRedirect(dirPath+"/newIndeX.jsp");
		//return;
	//}
	//�α��� üũ �� ///////////////////////////////////////////////////////////////////////////////////////
%>
	<form name="movForm" id="movForm" method="post">
		<input name="ssID" type="hidden" value="<%=session.getId()%>" />
	</form>
	<object id=ds_title classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object  id="tr_title" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	
	<script language="JavaScript"  for="ds_title" event="OnLoadCompleted(row)">
		//�ε� �Ϸ��ϸ� �޴���/Ÿ��Ʋ ����
		//alert(ds_title.namevalue(ds_title.rowposition,"MENU_NM"));
		//alert(ds_title.namevalue(ds_title.rowposition,"FULL_DIR_NM"));	
		menu_title.innerHTML = ds_title.namevalue(ds_title.rowposition,"MENU_NM");
		menu_full.innerHTML = ds_title.namevalue(ds_title.rowposition,"FULL_DIR_NM");
		document.title = ds_title.namevalue(ds_title.rowposition,"MENU_NM")+"������������������������������������������������������������������������������������";
	</script>	

	<script language="JavaScript">
	
		/* ���� �޴� �ݱ� */
		function mclose(){	
			window.close();
		}
	
		/* Ʈ�� ��ȸ */
		function fnInit_tree(tree_idx){
			//�޴�����
			fnSetTitle(tree_idx);
		}
	
		/* �޴�Ʈ�� ��ȸ�ϱ� */
		function fnSetTitle(tree_idx){
			if(tree_idx==0){	//�ʱ� �ε���ȭ���� ���
				menu_title.innerHTML = "����";
				menu_full.innerHTML = "Ȩ>�λ����>���� ";
				document.title = "���ۡ�����������������������������������������������������������������������������������";
			} else{

		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
		   	     	+ "tree_idx=" + tree_idx;	//���õ� �޴� idx�� ������.
		        ln_TRSetting(tr_title, 
		            "/HDAsan<%=HDConstant.PATH_ERP_COMMON%>Cm011I_10",
		        	"JSP(O:TITLE=ds_title)",
		       		param);
		        tr_post(tr_title);
		    };
		}	
	</script> 


<body onLoad="fnOnLoad(<%=tree_idx%>);">

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
			Frameborder="0" src="/HDAsan/Purch/common/include/loadingSales.jsp">
	</iframe>	

	<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="/HDAsan/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>	
	



<!--||| HEADER START |||-->
<div id="haHeader">
	<div id="haHeaderTop">
	<table width="1000" border='0'>
	  <TR>
		<td class="c b" width="158px" style="padding-bottom:2px"><img src="<%=dirPath%>/images/Common/logo.gif" /></td>
		<td class="r b" width="12px" style="padding-bottom:1px">��</td>
		<td class="l b" style="padding-left:2px;padding-bottom:1px" id="msgTxt">�޼��� �����Դϴ�.&nbsp;</td>
		<td width="40px" class="r b" style="padding-bottom:1px;cursor:pointer;" onclick="mclose()"><img src="<%=dirPath%>/images/Common/nClose.gif" /></td>
	  </TR>
	</table>
	</div>
	<div id="haHeaderMenu">
		<table width="1000" border='0'>
		  <TR>
			<td class="c b bold" width="158px" style="padding-bottom:0px; color:#111111;"><%=gusrnm%>(<%=gusrid%>)��</td>
			<td class="l b bold" style="padding-bottom:0px;color:#111111;font-size:14px;padding-left:12px;" id="menu_title">&nbsp;</td>
			<td class="r b" style="color:#111111; padding-bottom:0px;padding-right:1px;" id="menu_full">&nbsp;</td>
		  </TR>
		</table>

	</div>
</div><!-- //HEADER START -->


<!-- MAIN CONTENTS START -->
<div id="haSubBody">
		<table border=0 cellspacing=0 cellpadding=0 height=100% >
		  <TR>
			<td VALIGN=top BGCOLOR=#E9F8FE STYLE="border-right:1 solid #DFDFDF;">			</td>
			<td WIDTH=100% STYLE="padding-left:12px;padding-top:10px;" VALIGN=top>
<!-- BODY header end-->

