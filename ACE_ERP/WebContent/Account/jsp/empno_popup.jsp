<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: Empno_popup.HTML
+ �� �� �� ��	: 
+ �� �� �� ��	: 
+ �� �� �� ��	: 
+ ��  ��  ��  : �� �� ��
+ �� �� �� �� : 2010/03/23
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����ȸ</title>

<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var parentGubun="";
get_cookdata();
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

  /*
	if(window.dialogArguments[0]=="H050009"||window.dialogArguments[0]=="EMPNO"){
	   parentGubun ="";
	}else if(window.dialogArguments[0] != undefined && window.dialogArguments[0] != "H030003" && window.dialogArguments[0] != "H050005"&& window.dialogArguments[0] != "H050008") { 
	   parentGubun="P040001";
	}else if(window.dialogArguments[0] == "H030003") {
		parentGubun="H030003";
	}else if(window.dialogArguments[0] == "H050008") {
		parentGubun="H050008";
	}else if(window.dialogArguments[0] == "H050005") {
		parentGubun="H050005";
	}
	*/

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(e){
  var strChk="";

	if(chk_p01.checked==false ){
		strChk="N";
	}else{
		strChk="Y";
	}

  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>empno_s1?"  
								   + "v_str1="+txt_nm.value
									 + "&v_str2="+strChk;
  
	//prompt(this,gcds_data.DataID);
	gcds_data.Reset();
	
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
******************************************************************************/
function ln_Close(e){
  var row= gcds_data.rowposition;

	if(e=="A"){
		window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
											 + gcds_data.namevalue(row,"EMPNO") ;
		window.close();
	}else{
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="50px;" bgcolor="#eeeeee">����</td>
		<td width="120px">
			<input type="text" class="txt11" id="txt_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td class="tab41" width="70px" bgcolor="#eeeeee">���������</td>
		<td width="70px"><nobr> 
			  <input type="checkbox" id=chk_p01   value="T" style="position:relative;left:2px;"> </nobr> 
    </td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:358;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"     value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=EMPNO,		Name=���,		width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=EMPNMK,		Name=����,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=DEPTNM,		Name=�ҼӸ�,	    width=106,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=PAYGNM,		Name=������,	    width=86,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:360;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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

<!-- <iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 