<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �������� �˾�
+ ���α׷� ID	: cm015i_r.html
+ �� �� �� ��	: ��ȸ
+ �� �� �� ��	: �躴��
+ �� �� �� ��	: cm013i_s01
------------------------------------------------------------------------------>
<html>
<head>
<title>�������������˾�</title>
<jsp:include page="/Sales/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../common/include/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	get_cookdata();
	var gs_date = gn_Replace(gcurdate,"/");
	var gs_gubun="";
	var strParam = new Array();
	strParam=window.dialogArguments;

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

		if(gcem_c1.text==""){	 alert("���ó�� �Է��� �ּ���."); return false;}

		gcds_data01.DataID = "/services/servlet/sales.cm.cm012i_r_s01?"
												 + "v_str1=" + fn_trim(gcem_c1.text);
		//prompt('',gcds_data01.DataID);
		gcds_data01.Reset();
}

/******************************************************************************
	Description : â�ݱ�
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		if(gcds_data01.countrow<1) {
			alert("�����Ͻ� ������ �����ϴ�.");
		}	else {
						var row = gcds_data01.rowposition;
						window.returnValue = gcds_data01.namevalue(row,"DETAIL") + ";"		//���ó�ڵ�
														 + gcds_data01.namevalue(row,"DETAIL_NM");		//���ó��
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
<comment id="__NSID__"><OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp1" event="OnDblClick(row,colid)">
	if (row<1) return;
	ln_Close('A');
</script>
<script language=javascript for=gcem_c1 event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
//	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
//	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data01.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>
</HEAD>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:10px;top:5px;width:410px;border:0 solid #c5c5c5">
	<tr>
		<td class="tab_a1111">��&nbsp;��&nbsp;ó</td>
		<td class="tab_b0111">
				<fieldset class=field_01 style="width:160px;">
				<comment id="__NSID__"><OBJECT id=gcem_c1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
					class="gcem_01" style="width:155px;">
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<param name=Format	      value="">
						<param name=PromptChar	  value="">
						<param name=GeneralEdit   value="true">
						<param name=UpperFlag     value=1>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				</fieldset>
		</td>

	<td >
      &nbsp;&nbsp;<img src="/services/Sales/images/refer.gif"	style="position:relative;top:2px;cursor:hand;"	 onclick="ln_Query()">			
		</td>	
	</tr>
	<tr>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td colspan="3">
			<comment id="__NSID__">
						<OBJECT  id=gcgd_disp1 class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:390px;height:350px;" viewastext>
							<param name="DataID"				value="gcds_data01">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW}	 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='�ڵ�'				ID=DETAIL				HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C>
								<C> Name='���ó��'		ID=DETAIL_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=200	align=center</C>
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:390;height:20px;border:1 solid #c5c5c5;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
<!-- 			<img name="btn_select" border="0" src="../../Sales/images/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Sales/images/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')"> -->
		</td>
	</tr>
</table>
<!--
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
//-->
</body>
</html>