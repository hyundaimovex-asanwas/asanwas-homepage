<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - ����	
+ ���α׷� ID	:  A080003.html
+ �� �� �� ��	:  ������ȸ �˾�â
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� �� :	   
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>������ȸ</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var gs_strFdcode = ""; //����
var gs_strBgtyy = ""; //����⵵
var gs_strBgtdpt = ""; //����μ�

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;

    gs_strFdcode = strParam[0];
    gs_strBgtyy = strParam[1];
	gs_strBgtdpt = strParam[2];
	txt_atkornam.value = strParam[3];
	txt_atcode.value = strParam[4];
	txt_bgtyy1.value = strParam[5];

	ln_Query();
	//��������
	//gcds_comcode01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0033";
	//gcds_comcode01.Reset();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	gcds_code01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>bgtdetail1_popup_s1?v_str1="+gs_strFdcode+"&v_str2="+gs_strBgtyy+
																				   "&v_str3="+gs_strBgtdpt+"&v_str4="+txt_atkornam.value+
																				   "&v_str5="+txt_atcode.value+"&v_str6="+txt_bgtyy1.value;
	//prompt('',gcds_code01.DataID );
    gcds_code01.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"ATCODE")  + ";" 
	                   	   + gcds_code01.namevalue(row,"ATCODE1")+ ";" 
						   + gcds_code01.namevalue(row,"SATCODE")  + ";"
						   + gcds_code01.namevalue(row,"BGTMM")+ ";"
						   + gcds_code01.namevalue(row,"RESULTS1");
		window.close();
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13)
		ln_Close('A');
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:500px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">���������</td>
		<td width="110px">
			<input type="text" class="txt11" id="txt_atkornam" style="position:relative;left:3px;width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td class="tab16" width="60px;" bgcolor="#eeeeee" align="center">�����ڵ�</td>
		<td width="60px">
			<input type="text" class="txt11" id="txt_atcode" style="position:relative;left:3px;width:50px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td class="tab16" width="40px;" bgcolor="#eeeeee" align="center">�����</td>
		<td width="60px">
			<input type="text" class="txt11" id="txt_bgtyy1" style="position:relative;left:3px;width:50px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		</td>
		<td align="right">
			<img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:-5px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:500;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=ATCODE,		 Name=�ڵ�,   	  width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=ATCODE1,	 Name=���������, width=140,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=SATCODE1,	 Name=����,       width=140,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true, EditStyle='lookup' Data='gcds_fdcode:FDCODE:FDNAME'</C>
					<C>ID=BGTMM,	  Name=�����,   width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=RESULTS1,	 Name=�ܾ�,   width=82,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sort = true</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:502;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:100px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 