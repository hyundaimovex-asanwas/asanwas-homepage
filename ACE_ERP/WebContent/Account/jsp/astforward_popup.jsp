<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: ������ _ ���̿�	�˾�
+ ���α׷� ID	: AstForward_popup.html
+ �� �� �� ��	: ������ ���̿� �˾�
+ ��   ��  �� : ������
+ �� �� �� �� : 2009.10.27
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���̿��˾�</title>

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
var parentGubun="";
var gs_strGubun ="";
var gs_Gubun="";//�����μ�(A) �����μ�(B) ����
var gs_Divcd="";//  ����
var gs_Fdcode="";//  ����
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;

    fdcode.value = strParam[0];
	fdcodenm.value = strParam[1];
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

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
	Description : ���̿�
******************************************************************************/
function ln_Year_Forward(){

		if(!ln_Chk()) return;

		if(confirm(gcem_frdt.text+"�⵵ �������� "+gcem_todt.text+"�⵵�� ���̿� �Ͻðڽ��ϱ�?" )){
			gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>asetdep_yearforward_sp"
									       + "?v_str1="+fdcode.value+"&v_str2="+gcem_frdt.text									     
									       + "&v_str3=N";
		    gcds_data.Reset();
		}
}

/******************************************************************************
	Description : ���̿� üũ 
******************************************************************************/
function ln_Chk(){
  var intfrdt=0;
	var inttodt=0;

	if(fdcode.value==""){
		alert("�����ڵ带 Ȯ���Ͻʽÿ�.");
		return false;
	}

	if(gcem_frdt.text==""){
		alert("From���� ���� �Ǿ����ϴ�.");
		gcem_frdt.Focus();
		return false;
	}

	if(gcem_todt.text==""){
		alert("To���� ���� �Ǿ����ϴ�.");
		gcem_todt.Focus();
		return false;
	}

	if(gcem_frdt.text>=gcem_todt.text){
		alert("From�� �� To���� Ȯ���Ͻʽÿ�.");
		return false;
	}

	//4�ڸ��� �ƴ� ���
	if(gcem_frdt.text.length!=4){
		alert("From���� 4�ڸ� �⵵�� �ƴմϴ�. Ȯ���Ͻʽÿ�.");
		gcem_frdt.Focus();
		return false;
	}
	
  if(gcem_todt.text.length!=4){
		alert("To���� 4�ڸ� �⵵�� �ƴմϴ�. Ȯ���Ͻʽÿ�.");
		gcem_todt.Focus();
		return false;
	}

	//from�� to�� 2���̻� ���̰� �� ��� 
	intfrdt = gcem_frdt.text;
	inttodt = gcem_todt.text;

	if (inttodt-intfrdt>1) {
			alert("From�� �� To�� ���̰� 1���� �ƴմϴ�.");
			return false;
	}

  //���̿� ���� üũ
  gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astFinish_chk_s1"
									+ "?v_str1="+fdcode.value+"&v_str2=2"
									+ "&v_str3="+gcem_frdt.text+"&v_str4=";
	gcds_chk.Reset(); 

  if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		alert(gcem_frdt.text+"�⵵ �������� �Ǿ����ϴ�. �ش�⵵ ���̿� �� �� �����ϴ�.");
		return false;
	}

  return true;
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(){
	window.close();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>

	<object  id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

  alert("S_YN::"+gcds_data.namevalue(row,"S_YN"));

  if(gcds_data.namevalue(row,"S_YN")=="Y"){
		alert("���̿� �۾��� ���������� �Ϸ� �Ǿ����ϴ�.");
	}else{
		alert("���̿� �۾��� ���������� �Ϸ� ���� ���Ͽ����ϴ�.");
	}
</script>

<script language=JavaScript for=gcem_frdt event=onKillFocus()>
	if(gcem_frdt.text!=""){
		gcem_todt.text=Number(gcem_frdt.text)+1;
	}
</script>
 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<table width="325px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td width="325px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_eyuol.gif"   style="cursor:hand;position:relative;top:3px;" onclick="ln_Year_Forward()">
		</td>
	</tr>
	<tr> 
		<td width="325px" align="left" background="../../Common/img/com_t_bg.gif" >&nbsp;
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:3px;top:1px;width:325px;border:1 solid #708090">
	<tr>

	  <td class="tab12" width="50px;" bgcolor="#eeeeee" align="center">����</td>
		<td width="90px"><nobr>&nbsp;
		   <input type="text" class="txt11" id="fdcode"    style="position:relative;left:-6px;width:20px;background-color:#d7d7d7" readOnly>
			 <input type="text" class="txt11" id="fdcodenm"  style="position:relative;left:-6px;width:50px;background-color:#d7d7d7" readOnly>
		</td>
    <td class="tab16" width="50px;" bgcolor="#eeeeee" align="center">FROM��</td>
		<td width="40px"><nobr>&nbsp;
		    <comment id="__NSID__">
				<object id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:-4px;top:2px; width:35px; height:20px;" >
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
		</td>

		<td class="tab16" width="50px;" bgcolor="#eeeeee" align="center">TO��</td>
		<td width="40px" ><nobr>&nbsp;
		    <comment id="__NSID__">
				<object id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:-4px;top:2px; width:35px; height:20px;" >
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>
<table>
	<tr>
		<td height="1" > </td>
	</tr>
</table>
<table border="0" cellpadding="1" cellspacing="1" style="position:relative;left:3px;top:1px;width:325px;border:1 solid #708090">
	<tr>
    <td colspan=2> &nbsp;��) <font size="2" color="blue"> 2009�� ==> 2010�� </font> ���� ���̿� </td>
	</tr>
  <tr>
    <td> &nbsp;&nbsp;&nbsp;&nbsp;*FROM�� : 2009</td>
		<td> *TO�� : 2010 </td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
