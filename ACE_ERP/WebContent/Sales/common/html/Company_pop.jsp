<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	���¾�ü��ȸ
+ ���α׷� ID	:  Company_pop.html
+ �� �� �� ��	: 
+ �� �� �� ��	: 
+ �� �� �� ��	: bm011s_s01
------------------------------------------------------------------------------>
<html>
<head>
<jsp:include page="/Sales/common/include/head.jsp"/>
<title>���¾�ü��ȸ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../include/common.css">
<link rel="stylesheet" href="../../bm/bm.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../include/PubFun.js"></script>
<!--<Script language="javascript" src="../include/common.css"></script>	//-->
<script language="javascript" src="../js/embedControl.js"></script>
<script language="javascript">
	get_cookdata();

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
	function ln_Query(){
		if(txt_vend_nm.value==""){
			   alert("��ȸ������ �Է��ϼ���");
			   txt_vend_nm.focus();
			   return ;
			}

		var str1 = txt_vend_nm.value;
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_BM%>Company_pop_s01?v_str1=" + str1; 
		gcds_data.Reset();
	}

/******************************************************************************
	Description : â�ݱ�
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		if(gcds_data.countrow<1) {
			alert("�����Ͻ� ���¾�ü�� �����ϴ�.");
		}
		else {
			var row = gcds_data.rowposition;
			window.returnValue = gcds_data.namevalue(row,"VEND_SID") + ";" 
	                   	   + gcds_data.namevalue(row,"VEND_NM");
												 //+ gcds_data.namevalue(row,"REGNO");
			window.close();
		}
	} else {
		window.close();
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
//	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
//	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick(row,colid)">
	if (row<1) return;
	ln_Close('A');
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:0 solid #c5c5c5">
	<tr>
	  <td class="tab_a1111" style="width:90px;height:30px;">��ü�ڵ��</td>
		<td class="tab_b0111" width="270px">
		 <input type="text" class="txt_a01" id="txt_vend_nm" style="width:150px;position:relative;top:-3px;" maxlength="50" onkeydown="if(event.keyCode==13) ln_Query();">
        <img src="../img/btn/btn_find.gif" alt="ȸ���" style="position:relative;left:8px;top:3px;cursor:hand;" onclick="ln_Query()">
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td colspan="3">
			<%=HDConstant.COMMENT_START%>
			<OBJECT id=gcgd_disp class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:360;height:329px;"  >
							<param name="DataID"				value="gcds_data">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="Indwidth"			VALUE="0">
							<PARAM NAME="Fillarea"			VALUE="true">
							<param name="sortview"			VALUE="left">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="22">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="ViewHeader" 		value="-1">
							<param name="UsingOneClick" value="1">
							<PARAM NAME="Format"			VALUE="  
								<C>ID=VEND_SID  	Name=ȸ���ڵ� 	width=80 	HeadBgColor=#eeeeee align=center sort = true</C>
								<C>ID=VEND_NM		Name=ȸ��� 	  width=200 	HeadBgColor=#eeeeee align=left	 sort = true</C>
								<C>ID=LOCAL_GU_NM		Name=���� 	  width=80 	HeadBgColor=#eeeeee align=left	 sort = true</C>
												">
	    </OBJECT><%=HDConstant.COMMENT_END%>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:361;height:20px;border:1 solid #c5c5c5;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../img/btn/btn_confirm.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../img/btn/btn_cancel.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>



</body>
</html>